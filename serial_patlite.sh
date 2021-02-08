#!/bin/sh
#
# Patlite RS232C (PHE-3FB) Sample Program
#
# http://www.patlite.jp/product/phe_3fb.html
#
# Linux has multiple RS232 port.
# The special device file is using for RS232C,
# so input-and-output processing is performed.
# /dev/ttyS0 is used to the port 0.
# Pre command ocessing sets line speed and
# the control information on a signal to RS232C port.
# send direct binary data of the signal to PHE-3FB
# through a RS232C port.
# Opening System plays port open and closing,
# unnecessary this shell. It carries out on OS level.



#sample
# ./serial_patlite.sh -g0 -y0 -r0
# ./serial_patlite.sh -g1 -y1 -r1
# ./serial_patlite.sh -a2


if [ $# -lt 1 ]; then
  echo "$# parameter." 1>&2
  echo "You need more than 1 parameter." 1>&2
  echo "Usage: $CMDNAME [-aVALUE] [-r VALUE] [-g VALUE] [-y VALUE]" 1>&2
  exit 1
fi

while getopts r:g:y:a: OPT
do
  case $OPT in
    "r" ) FLG_R="TRUE" ; VALUE_R="$OPTARG" ;;
    "g" ) FLG_G="TRUE" ; VALUE_G="$OPTARG" ;;
    "y" ) FLG_Y="TRUE" ; VALUE_Y="$OPTARG" ;;
    "a" ) FLG_A="TRUE" ; VALUE_A="$OPTARG" ;;
      * ) echo "Usage: $CMDNAME [-aVALUE] [-r VALUE] [-g VALUE] [-y VALUE]" 1>&2
          exit 1 ;;
  esac
done


# pre command
stty 9600 cs8 < /dev/ttyS0
#
# (Official Sample) all lignts on and sound pipipi
#echo "@??12>!" > /dev/ttyS0

if [ "$1" == "-a0" ]; then
    # all off
    echo "@??0??!" > /dev/ttyS0
    exit
fi

if [ "$1" == "-a1" ]; then
    # all lights on
    echo "@??107!" > /dev/ttyS0
    exit
fi

if [ "$1" == "-a2" ]; then
    # all off
    echo "@??0??!" > /dev/ttyS0
    # all blink
    echo "@??1>0!" > /dev/ttyS0
    exit
fi




if [ "$VALUE_R" = "0" ]; then
    # red off
    echo "@??001!" > /dev/ttyS0
fi
if [ "$VALUE_R" = "1" ]; then
    # red on
    echo "@??101!" > /dev/ttyS0
fi


if [ "$VALUE_G" == "0" ]; then
# green off
    echo "@??004!" > /dev/ttyS0
fi
if [ "$VALUE_G" == "1" ]; then
    # green on
    echo "@??104!" > /dev/ttyS0
fi


if [ "$VALUE_Y" == "0" ]; then
    # yellow off
    echo "@??002!" > /dev/ttyS0
fi

if [ "$VALUE_Y" == "1" ]; then
    # yellow on
    echo "@??102!" > /dev/ttyS0
fi
