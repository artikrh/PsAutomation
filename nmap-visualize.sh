#!/bin/sh

## 1. Take input XML file path argument
## 2. Output visualized HTML file into input file's directory
## 3. Open chromium new tab (can be changed to any browser in the script)

### Requires readlink, basename, dirname (pre-installed in most Linux distros) and xsltproc
### wget https://raw.githubusercontent.com/honze-net/nmap-bootstrap-xsl/master/nmap-bootstrap.xsl -O /opt/others/
XSL=/opt/others/nmap-bootstrap.xsl ### Change this path

if [ "$#" -ne 1 ]; then
	echo "[*] Usage: $0 <input XML file>"
	exit 1
fi

if [[ -f $1 ]]; then
	INPUT_FILE=$(readlink -f $1)
	INPUT_NAME=$(basename $1)
	OUTPUT_DIR=$(dirname $1)
	OUTPUT_NAME="${INPUT_NAME%.*}"
	OUTPUT_FILE=$OUTPUT_DIR/$OUTPUT_NAME.html

	if [[ ! -f $OUTPUT_FILE ]]; then
	xsltproc -o $OUTPUT_FILE $XSL $INPUT_FILE
	fi
	chromium &> /dev/null $OUTPUT_FILE
else
	echo "[*] File does not exist!"
	exit 1
fi
