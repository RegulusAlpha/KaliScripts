#!/bin/bash
#credit goes hak5darren

read -r -p "Set netmask [255.255.255.0]: " netmaskvar
read -r -p "Set network ip [10.0.0.1/24]: " netip
read -r -p "set interface for router internet connection [eth0]: " interfaceroute
read -r -p "Set interface between kali and internet [wlan0]: " interfacenet
read -r -p "Set ip of router WAN [10.0.0.1]: " routeripwan
read -r -p "Set ip of pc WAN [10.0.0.200]: " pcipwan

temppineapplegw=`netstat -nr | awk 'BEGIN {while ($3!="0.0.0.0") getline; print $2}'` #Usually correct by default
echo -n "Internet Gateway [$temppineapplegw]: "
read pineapplegw
if [[ $pineapplegw == '' ]]; then 
pineapplegw=`netstat -nr | awk 'BEGIN {while ($3!="0.0.0.0") getline; print $2}'` #Usually correct by default
fi


ifconfig $interfaceroute $pcipwan netmask $netmaskvar up

echo '1' > /proc/sys/net/ipv4/ip_forward


iptables -X
iptables -F


iptables -A FORWARD -i $interfacenet -o $interfaceroute -s $netip -m state --state NEW -j ACCEPT
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A POSTROUTING -t nat -j MASQUERADE

route del default

route add default gw $pineapplegw $interfacenet


route add default gw $pineapplegw $pineapplewan
