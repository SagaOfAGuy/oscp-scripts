#!/bin/bash

# Exit script if user presses CTRL C
trap "exit" INT

# RED color outline
RED="\e[31m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"

# Installing tools
scripts=`ls -dl */ | awk -F " " '{print substr($9,1,length($9)-1)}'`
for script in ${scripts[@]};
do
	printf "${GREEN}[+]${ENDCOLOR} Downloading $script to /usr/local/bin\n"
	sudo cp $script/$script /usr/local/bin/$script
done

# Install tools from initial-enum script
sudo cp ./initial-enum/initial-enum-multi /usr/local/bin
