#!/usr/bin/env bash

help(){
  echo "Usage: $0 TIME"
  echo
  echo " Find the network hog!"
  echo "   -h		display this help and exit"
  echo
  echo " Examples:"
  echo "  To scan for 10 seconds run:"
  echo "   $0 10"
}

# Get names of ip addresses
function getIpAddr {
nmap -sn 192.168.1.0/24 -oG - 2> /dev/null| tr -d '()' | awk '{print $2,$3}'
}


# Get bandwidth usage
function getBandwidth {
  timeout $TIME tshark -q -z "endpoints,ip" 2> /dev/null | head -n -1 | tail -n+5 |  awk '{a[$1] += $3} {b[$1] += $5} {c[$1] += $7}  END {for (i in a) print i, a[i], b[i], c[i]}'
}

function combineResults {
  join -i -a 2 2> /dev/null <(getIpAddr | sort -f) <(getBandwidth | sort -f)
}

function formatResults {
  echo Total Up Down Ip Name
  combineResults | awk '/^[^ ]+ [^ ]+ [^ ]+ [^ ]+ [^ ]+$/ { print $3,$4,$5,$1,$2 } /^[^ ]+ [^ ]+ [^ ]+ [^ ]+$/ { print $2,$3,$4,$1 }' | sort -nr
}


if [ "$#" -ne 1 ]
then
  help
  exit 1
fi

TIME=$1

formatResults | column -t

