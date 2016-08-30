#!/bin/bash
# mac spoof
# Author: Ross Tramontano (RegulusAlpha)

echo " $(tput setaf 1)                                     "
echo "    ___       ___       ___       ___       ___      "
echo "   /\__\     /\  \     /\  \     /\  \     /\__\     "
echo "  /::L_L_   /::\  \   /::\  \   /::\  \   /:/__/_    "
echo " /:/L:\__\ /::\:\__\ /:/\:\__\ /\:\:\__\ /::\/\__\   "
echo " \/_/:/  / \/\::/  / \:\ \/__/ \:\:\/__/ \/\::/  /   "
echo "   /:/  /    /:/  /   \:\__\    \::/  /    /:/  /    "
echo "   \/__/     \/__/     \/__/v0.01\/__/     \/__/     "
echo "                                                     "
echo "                                                     "

########################################################
#### this will reset the mac back to the default mac####
########################################################
read -r -p "reset to default mac (y/n): " macp         #   
                                                       #  
if [[ $cbvar == "y" ]]; then                           #         
ifconfig $interface down                               #          
macchanger -p $interface                               #         
ifconfig $interface up                                 #            
fi                                                     #            
                                                       #         
if [[ $cbvar == "Y" ]]; then                           #               
ifconfig $interface down                               #                
macchanger -p $interface                               #        
ifconfig $interface up                                 #       
fi                                                     #  
########################################################

#change your mac

read -r -p "set interface: " interface
read -r -p "should this be random (y/n): " ranvar

ifconfig $interface down

#change to random
if [[ $ranvar == "y" ]]; then
macchanger -r $interface
fi
if [[ $ranvar == "Y" ]]; then
macchanger -r $interface
fi
#prompt for a mac address to change to

if [[ $ranvar == "n" ]]; then
read -r -p "set mac address(00:00:00:00:00:00): " mac
macchanger -m $mac $interface
fi

if [[ $ranvar == "N" ]]; then
read -r -p "set mac address(00:00:00:00:00:00): " mac
macchanger -m $mac $interface
fi

ifconfig $interface up
#macchanger –show $interface

#wait to change back
read -r -p "change mac back (y/n): " cbvar

if [[ $cbvar == "y" ]]; then
ifconfig $interface down
macchanger -p $interface
ifconfig $interface up
fi

if [[ $cbvar == "Y" ]]; then
ifconfig $interface down
macchanger -p $interface
ifconfig $interface up
fi

if [[ $cbvar == 'n' ]]; then 
exit
fi

if [[ $cbvar == 'N' ]]; then 
exit
fi
# exit
