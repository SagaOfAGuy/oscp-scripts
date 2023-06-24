#!/bin/bash

# Installing tools
scripts=`ls -dl */ | awk -F " " '{print substr($9,1,length($9)-1)}'`
for script in ${scripts[@]}; 
do
	printf "[+] Downloading $script to /usr/local/bin\n" 
	sudo cp $script/$script /usr/local/bin/$script

done
