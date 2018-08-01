# ProcessAutomatization
Automating linux processes using bash scripts

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
* Determines wether you are an ARP spoofing targete or no by unique sorting ARP table  
* If ARP spoofing is detected, script offers bringning down internet interfaces

Usage:  
`$ ./arp-spoof-detect.sh`
