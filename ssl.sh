#!/bin/bash
#Lets Encrypt

if [ "$EUID" -ne 0 ]
    then echo "This script requires root."
    exit
fi


wget  https://dl.eff.org/certbot-auto
chmod +x certbot-auto
./certbot-auto
