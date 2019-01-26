# ProcessAutomatization
Automating linux processes using python/bash scripts

### wifi-crack.sh  
* Brute force wireless passwords using `aircrack-ng`
* Offers force client deauthentication
* Autodetects wireless interface name
* Automatically detects operating mode of the wireless interface 
* Wordlist path is `/usr/share/wordlists/rockyou.txt` by default (can be changed with `-w` option)  

Usage:  
`$ chmod +x wifi-crack.sh`  
`$ sudo ./wifi-crack.sh`  
`$ sudo ./wifi-crack.sh -w /path/to/wordlist.txt`

Disable monitoring mode and just in case kill any background process running `aircrack-ng`:  
`$ sudo pkill aircrack-ng`  
`$ sudo airmon-ng stop wlan0mon`  
`$ sudo service network-manager restart`

### arp-spoof-detect.sh  
* Determines wether you are an ARP spoofing target by unique sorting ARP table  
* If ARP spoofing is detected, script offers terminating the network interface

Usage:  
`$ ./arp-spoof-detect.sh`

### procmon.sh
* A simple script in bash to continuously monitor system processes

Usage:  
`$ ./procmon.sh`

### virustotal.py
* A simple python script which accepts an executable file as input argument and then communicates with VirusTotal API to check whether that file has been scanned (if yes, provide results from different AVs)
* Requires a valid [VirusTotal API](https://developers.virustotal.com/reference) key to work

Usage:  
```
$ chmod +x virustotal.py 
$ sudo mv virustotal.py /bin
$ virustotal.py file.ext
```
