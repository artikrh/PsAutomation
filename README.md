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
### align.sh
* A simple script in bash to automatically align windows frame size to a custom set of coordinates
* The following resizes my terminal (has `zsh` in title) and Chromium browser (has `Chromium` in title)
* You can add/remove arbitrary windows and `-e` coordinates (gravity, x, y, w, h)

Usage:  
`$ ./align.sh`

## Helpful aliases

### Easy copy
* Requires `xclip` which can be installed from `apt`
* In the following case, the content of `file.txt` gets copied into the system clipboard

```
$ alias copy='xclip -selection c'
$ cat file.txt | copy
```

### Python SimpleHTTPServer
* The word `simple` serves a simple web server from the python module and prints `http://ip:port/` for convenience

```
$ alias simple='ip r show | grep src | cut -d " " -f 9 | sed -e "s/^/http:\/\//" | sed "s/$/:8080\//" && python -m SimpleHTTPServer 8080'      
$ simple
http://10.10.13.50:8080/
http://192.168.0.12:8080/
Serving HTTP on 0.0.0.0 port 8080 ...
```

### Quickly show IP
* Show IPv4 address for X network interface without going through the whole `ifconfig` or `ifconfig <netiface>` output
* The following shows the IPv4 address of the VPN network interface `tun0`

```
$ alias tun0='ifconfig tun0 | grep inet | head -1 | xargs | cut -d " " -f 2'
$ tun0
10.10.13.50
```
