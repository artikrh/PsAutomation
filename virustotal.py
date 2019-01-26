#!/usr/bin/python
import sys,requests
import json,hashlib

def main():
	file = sys.argv[1]

	with open(file,"rb") as f:
		bytes = f.read()
		hash = hashlib.sha256(bytes).hexdigest();

	params = {'apikey': 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 'resource': '{}'.format(hash)}
	headers = {
  	"Accept-Encoding": "gzip, deflate",
  	"User-Agent" : "Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0"
	}

	response = requests.get('https://www.virustotal.com/vtapi/v2/file/report',params=params,headers=headers)
	parsed = json.loads(response.text)
	print json.dumps(parsed, indent=4, sort_keys=True)

if __name__ == "__main__":
	if(len(sys.argv) != 2):
		print '[*] Usage: {} file'.format(sys.argv[0])
		sys.exit()
	else:
		main()
