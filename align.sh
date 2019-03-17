#!/bin/zsh

TERM=$(wmctrl -lp | grep 'zsh' | cut -d " " -f 1)
CHROMIUM=$(wmctrl -lp | grep 'Chromium' | cut -d " " -f 1)

declare -a windows=($TERM $CHROMIUM)

for i in "${windows[@]}"
do
	wmctrl -i -r $i -e 0,24,50,1873,938
done
