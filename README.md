# ProcessAutomatization
Automating linux processes using bash scripts

### wifi-crack.sh
* Autodetects wireless interface name
* Automatically detects operating mode of the wireless interface 
* Wordlist path is `/usr/share/wordlists/rockyou.txt` by default (can be changed with `-w` option)  

Usage:
`
$ chmod +x wifi-crack.sh
$ sudo ./wifi-crack.sh
$ sudo ./wifi-crack.sh -w /path/to/wordlist.txt"
`
