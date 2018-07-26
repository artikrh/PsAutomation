#!/bin/bash

echo  "***************************"
echo  "ARP Spoofing Detection Tool"
echo  "***************************"

GATEWAY=$(arp -a | grep gateway | cut -d " " -f 2)
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

while true
do
MATCH=$(arp -an | cut -d " " -f 4 | sort | uniq -d)

if [ -n "$MATCH" ]; then
for ip in $(arp -an | grep $MATCH | cut -d " " -f 2 | sed "/$GATEWAY/d")
do
	if [ $ip != "$GATEWAY" ]; then
		echo -e "${RED}MITM detected from $ip${NC}"
		echo -n "Would you like to bring down internet interfaces? (y/N): "
		read option
		if [ $option = "y" ]; then
			 sudo ifconfig wlan0 down
			 sudo ifconfig etho0 down
			 break
		fi
	else
		echo -e "${GREEN}You are protected"
	fi

done
else
	echo -e "${GREEN}You are protected"
fi
sleep 2
done
