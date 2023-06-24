#!/bin/bash

# Check for parameters
if [ $# -lt 2 ]
  then
    echo "No arguments supplied. Please supply a valid IP address and port to scan"
    exit
fi

trap "exit" INT
# Grab banners
printf "[x] Grabbing web server banner version...\n"
nc -nv -q $1 $2 &> banner.txt

# Searchsploit search
printf "[x] Run a searchsploit scan via the command: searchsploit <Banner Version>\n"

# Check for robots.txt
printf "[x] Getting robots.txt if it exists...\n"
curl -X GET http://$1:$2/robots.txt &> "$2_robots.txt"



# Run some dirbusting
printf "[x] Running directory busting scans...\n"
printf "[x] Running common.txt scan...\n"
feroxbuster -u http://$1:$2 -k -w /usr/share/wordlists/seclists/Discovery/Web-Content/common.txt -o gobuster-$1-common.txt
printf "[x] Running seclists small.txt scan...\n"
feroxbuster -u http://$1:$2 -k -w /usr/share/wordlists/seclists/Discovery/Web-Content/directory-list-2.3-small.txt -o gobuster-$1-small.txt
printf "[x] Running seclists medium.txt scan...\n"
feroxbuster -u http://$1:$2 -k -w /usr/share/wordlists/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt -o gobuster-$1-medium.txt
printf "[x] Running seclists big.txt scan...\n"
feroxbuster -u http://$1:$2 -k -w /usr/share/wordlists/seclists/Discovery/Web-Content/directory-list-2.3-big.txt -o gobuster-$1-big.txt


# Fuzzing on Apache systems
printf "[x] Running apache fuzzing scans...\n"
feroxbuster -u http://$1:$2 -k -w /usr/share/wordlists/seclists/Discovery/Web-Content/apache.txt -o apache.txt
feroxbuster -u http://$1:$2 -k -w /usr/share/wordlists/seclists/Discovery/Web-Content/apacheFuzz.txt -o apacheFuzz.txt
feroxbuster -u http://$1:$2 -k -w /usr/share/wordlists/seclists/Discovery/Web-Content/apacheTomcat.txt -o apacheTomcat.txt


# Fuzzing nginx systems
printf "[x] Running nginx fuzzing...\n"
feroxbuster -u http://$1:$2 -k -w /usr/share/wordlists/seclists/Discovery/Web-Content/nginx.txt -o nginx.txt


# Fuzzing IIS
printf "[x] Running IIS fuzzing...\n"
feroxbuster -u http://$1:$2 -k -w /usr/share/wordlists/seclists/Discovery/Web-Content/iis-systemweb.txt -o iis-systemweb.txt
feroxbuster -u http://$1:$2 -k -w /usr/share/wordlists/seclists/Discovery/Web-Content/IIS.fuzz.txt -o IIS.fuzz.txt


# CMS fuzzing
printf "Running CMS fuzzing scans...\n"
feroxbuster -u http://$1:$2 -k -w /usr/share/wordlists/seclists/Discovery/Web-Content/CMS/wordpress.fuzz.txt -o wordpress.txt
feroxbuster -u http://$1:$2 -k -w /usr/share/wordlists/seclists/Discovery/Web-Content/CMS/wp-plugins.fuzz.txt -o wpplugin.txt
feroxbuster -u http://$1:$2 -k -w /usr/share/wordlists/seclists/Discovery/Web-Content/CMS/wp-themes.fuzz.txt -o wpthemes.txt
feroxbuster -u http://$1:$2 -k -w /usr/share/wordlists/seclists/Discovery/Web-Content/CMS/joomla-plugins.fuzz.txt -o joomla-plugins.txt
feroxbuster -u http://$1:$2 -k -w /usr/share/wordlists/seclists/Discovery/Web-Content/CMS/joomla-themes.fuzz.txt -o joomla-themes.txt
feroxbuster -u http://$1:$2 -k -w /usr/share/wordlists/seclists/Discovery/Web-Content/CMS/drupal-themes.fuzz.txt -o drupal-themes.txt
feroxbuster -u http://$1:$2 -k -w /usr/share/wordlists/seclists/Discovery/Web-Content/CMS/Drupal.txt -o Drupal.txt

# Get page source
printf "[x] Grabbing source code of main page...\n"
curl -s http://$1:$2 &> source.txt

# CMS detection checks
printf "[x] Running cmsmap scans...\n"
cmsmap http://$1 &> cmsmap.txt
cmseek --url http://$1 &>cmseek.txt
wpscan --url http://$1 &> wpscan.txt
joomscan --url http://$1 &> joomscan.txt
droopescan scan drupal -u http://$1 &> droopescan.txt
droopescan scan silverstripe -u http://$1 &> droopescan-silver.txt

# Run a nikto scan
printf "[x] Running nikto scan on target...\n"
nikto -host $1 &> nikto.txt






