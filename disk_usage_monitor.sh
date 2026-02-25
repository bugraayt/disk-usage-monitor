#!/bin/bash

disklogs="disk_usage.log"
while true; do
warnings=""
 while read filesystem usage mountpoint;
do
usagee=${usage%\%} #removes % sign

echo "Current disk usage for $mountpoint ($filesystem): $usagee%"
	if [ "$usagee" -gt 80 ];
	then
		warningm="$mountpoint disk usage is above 80 it's ($usagee%)!!"
		warnings="$warnings$warningm"$'\n'
		echo "WARNING!! $warningm"
		echo "WARNING!! $warningm $(date)" >> "$disklogs"
	else
		echo "$mountpoint disk usage is normal ($usagee%)."
	fi
done < <(df -h | awk 'NR>1 && $1 != "devfs" {print $1, $5, $9}')
read -p "Do you want to see the disks over the treshold? (y/n)" warning_only
        if [ "$warning_only" = "y" ] && [ -n "$warnings" ];
        then
            	echo "$warnings"
	elif [ "$warning_only" = "y" ]; then
		echo "No disks are over the threshold."
        fi
read -p "Check again? (y/n): " choice
    if [ "$choice" = "n" ]; then
        break
    fi
done