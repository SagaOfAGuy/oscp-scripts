#!/bin/bash

# Check arguments
if [ $# -eq 0 ]
  then
    echo "No arguments supplied. Please supply a valid IP address to scan"
    exit
fi

# Function that performs enumeration
ports=$(sudo nmap -Pn -T5 -p- $1 -v | grep Discovered | awk -F " " '{print substr($4,1,length($4)-4)}')
autorecon $1 -p $(echo $ports | tr ' ' ',')