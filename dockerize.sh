#!/bin/bash

#####################################################
### Written by t0t0r <victormarechal59@gmail.com> ###
#####################################################

## CHECK IF DOCKER IS ACTUALLY INSTALLED
command -v docker >/dev/null 2>&1 || { echo >&2 "/!\ Docker is required to run this script but it's not installed. Aborting."; exit 1; }

## BANNER SECTION
cat << EOF

▓█████▄  ▒█████   ▄████▄   ██ ▄█▀▓█████  ██▀███   ██▓▒███████▒▓█████        ██████  ██░ ██ 
▒██▀ ██▌▒██▒  ██▒▒██▀ ▀█   ██▄█▒ ▓█   ▀ ▓██ ▒ ██▒▓██▒▒ ▒ ▒ ▄▀░▓█   ▀      ▒██    ▒ ▓██░ ██▒
░██   █▌▒██░  ██▒▒▓█    ▄ ▓███▄░ ▒███   ▓██ ░▄█ ▒▒██▒░ ▒ ▄▀▒░ ▒███        ░ ▓██▄   ▒██▀▀██░
░▓█▄   ▌▒██   ██░▒▓▓▄ ▄██▒▓██ █▄ ▒▓█  ▄ ▒██▀▀█▄  ░██░  ▄▀▒   ░▒▓█  ▄        ▒   ██▒░▓█ ░██ 
░▒████▓ ░ ████▓▒░▒ ▓███▀ ░▒██▒ █▄░▒████▒░██▓ ▒██▒░██░▒███████▒░▒████▒ ██▓ ▒██████▒▒░▓█▒░██▓
 ▒▒▓  ▒ ░ ▒░▒░▒░ ░ ░▒ ▒  ░▒ ▒▒ ▓▒░░ ▒░ ░░ ▒▓ ░▒▓░░▓  ░▒▒ ▓░▒░▒░░ ▒░ ░ ▒▓▒ ▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒
 ░ ▒  ▒   ░ ▒ ▒░   ░  ▒   ░ ░▒ ▒░ ░ ░  ░  ░▒ ░ ▒░ ▒ ░░░▒ ▒ ░ ▒ ░ ░  ░ ░▒  ░ ░▒  ░ ░ ▒ ░▒░ ░
 ░ ░  ░ ░ ░ ░ ▒  ░        ░ ░░ ░    ░     ░░   ░  ▒ ░░ ░ ░ ░ ░   ░    ░   ░  ░  ░   ░  ░░ ░
   ░        ░ ░  ░ ░      ░  ░      ░  ░   ░      ░    ░ ░       ░  ░  ░        ░   ░  ░  ░
 ░               ░                                   ░                 ░                   
EOF

## USER PROMPT SECTION
echo "What kind of stuff do you want to deploy today?" 
select DISTRO in debian archlinux ubuntu centos
do
read -p "OK let's do that. How many $DISTRO do you want?" NUMBER
break
done 
if ! [[ $NUMBER =~ ^[1-4]+$ ]]; then 
   echo "Error: Not a number between 1 and 4" >&2; exit 1 
fi
read -p "Are you sure you want to proceed to the deployment of $NUMBER instances of $DISTRO (Y/n)" AGREE
AGREE="${AGREE:=y}" ## default value for AGREE
if ! [[ "$AGREE" == [yY] ]]; then 
   echo "You don't need me anymore. Bye" >&2; exit 1 
fi

## DEPLOYMENT SECTION
echo "OK lezgo!!!!!"
IMAGE="$DISTRO:latest"
for ((i=1; i<=$NUMBER; i++)); do
   docker run -d $IMAGE 
done

## CHECK FOR RESULTS
if ! [[ $(docker ps -a | grep $IMAGE | wc -l) == $NUMBER ]]; then
   echo "OOPS!!!! There is a problem! You have to deal with it yourself. Bye ;)"; exit 1 
fi
echo "Deployment of containers was successful \o/"





