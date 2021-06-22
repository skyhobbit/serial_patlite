#!/bin/sh


#sample
# ./serial_patlite.sh -g0 -y1 -r0


IP=192.168.10.1

if [ $# -lt 1 ]; then
  echo "$# parameter." 1>&2
  echo "You need more than 1 parameter." 1>&2
  echo "Usage: $CMDNAME [-r VALUE] [-g VALUE] [-y VALUE]" 1>&2
  #echo "0:off, 1:on, 2:blink" 1>&2
  echo "0:off, 1:on" 1>&2
  exit 1
fi

while getopts r:g:y: OPT
do
  case $OPT in
    "r" ) FLG_R="TRUE" ; VALUE_R="$OPTARG" ;;
    "g" ) FLG_G="TRUE" ; VALUE_G="$OPTARG" ;;
    "y" ) FLG_Y="TRUE" ; VALUE_Y="$OPTARG" ;;
      * ) echo "Usage: $CMDNAME [-r VALUE] [-g VALUE] [-y VALUE]" 1>&2
          #echo "0:off, 1:on, 2:blink" 1>&2
          echo "0:off, 1:on" 1>&2
          exit 1 ;;
  esac
done



echo -ne '\x57\x'$(echo "obase=16;ibase=2;00000${VALUE_G}${VALUE_Y}${VALUE_R}" | bc) | nc ${IP} 10000
