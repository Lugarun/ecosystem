#!/usr/bin/env bash

systemctl --user import-environment

while : ; do
    vdirsyncer sync
    now=$(echo $(date +"%H%M")) # define current time in 24H format
    hr=$(echo $(date +"%H%M") + 100 | bc) # define time + 1H in 24H format
    # Check all today's events
    khal list now 12h | tail -n +2 | while read -r line ; do # make sure to use a khal config file where the date format is in 24H format
    # this is done by adding "timeformat = %H:%M %p" in the [locale] section
    apt=$(echo $line | awk '{print $1}' | sed 's/://g' | bc)
    # Check if each event will occur within the next hour
    if [ $apt -le $hr ] && [ $apt -ge $now ]; then
	action=$(dunstify -u low --action="default,Reply" "$line") # I use dunst here but you can use any other notification daemon
	echo $line
	case "$action" in
	    "default")
		alacritty -e "ikhal" # I use alacritty here but you can use any terminal
		;;
	esac
    fi
done
    # Kill this script if time > 8pm (matches 2000 here)
    if [  $now -ge 2000 ]; then
	exit 
    else
	sleep 600 # sleep 10 min before repating
    fi
done
