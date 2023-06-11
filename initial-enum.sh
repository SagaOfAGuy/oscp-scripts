#!/bin/bash

# Check arguments
if [ $# -eq 0 ]
  then
    echo "No arguments supplied. Please supply a valid IP address to scan"
    exit
fi

# Function that performs enumeration
sudo nmap -Pn -T5 -p- $1 -v | grep Discovered | awk -F " " '{print substr($4,1,length($4)-4)}' | tee ports.txt && tr '\n' , < ports.txt > ports_csv.txt && autorecon $1 -p `cat ports_csv.txt`
