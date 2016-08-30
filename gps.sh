#!/bin/bash
# GPSD Startup Script
# Author: Ross Tramontano

echo " $(tput setaf 3)"
echo "      ___         ___      ___         ___         ___      "
echo "     /  /\       /  /\    /  /\       /  /\       /__/\     "
echo "    /  /:/_     /  /::\  /  /:/_     /  /:/_      \  \:\    "
echo "   /  /:/ /\   /  /:/\:\/  /:/ /\   /  /:/ /\      \__\:\   "
echo "  /  /:/_/::\ /  /:/~/:/  /:/ /::\ /  /:/ /::\ ___ /  /::\  "
echo " /__/:/__\/\:/__/:/ /:/__/:/ /:/\:/__/:/ /:/\:/__/\  /:/\:\ "
echo " \  \:\ /~~/:\  \:\/:/\  \:\/:/~/:\  \:\/:/~/:\  \:\/:/__\/ "
echo "  \  \:\  /:/ \  \::/  \  \::/ /:/ \  \::/ /:/ \  \::/      "
echo "   \  \:\/:/   \  \:\   \__\/ /:/   \__\/ /:/   \  \:\      "
echo "    \  \::/     \  \:\    /__/:/      /__/:/     \  \:\     "
echo "     \__\/       \__\/    \__\/  v0.1 \__\/       \__\/     "
echo "                                                            "
echo "                                                            "



if [ "$EUID" -ne 0 ]
    then echo "This script requires root to run."
    exit
fi

# restarting your computer is required if you dont want to risk bricking your gps.
read -r -p "has your computer been restarted? (y/n): " reloadvar
if [[ $reloadvar == 'n' ]]; then 
reboot
fi

if [[ $reloadvar == 'N' ]]; then 
reboot
fi

if [[ $reloadvar == 'y' ]]; then 
service gpsd stop
killall gpsd
fi

if [[ $reloadvar == 'Y' ]]; then 
service gpsd stop
killall gpsd
fi

read -r -p "What is the path of the gps (leave blank for /dev/ttyUSB1): " loc

if [[ $loc == '' ]]; then
loc=/dev/ttyUSB1
fi

gpsd -D 5 -N -n $loc



