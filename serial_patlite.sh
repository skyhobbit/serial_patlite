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
# ./serial_patlite.sh -g0 -y1 -r2


if [ $# -lt 1 ]; then
  echo "$# parameter." 1>&2
  echo "You need more than 1 parameter." 1>&2
  echo "Usage: $CMDNAME [-r VALUE] [-g VALUE] [-y VALUE]" 1>&2
  echo "0:off, 1:on, 2:blink" 1>&2
  exit 1
fi

while getopts r:g:y: OPT
do
  case $OPT in
    "r" ) FLG_R="TRUE" ; VALUE_R="$OPTARG" ;;
    "g" ) FLG_G="TRUE" ; VALUE_G="$OPTARG" ;;
    "y" ) FLG_Y="TRUE" ; VALUE_Y="$OPTARG" ;;
      * ) echo "Usage: $CMDNAME [-r VALUE] [-g VALUE] [-y VALUE]" 1>&2
          echo "0:off, 1:on, 2:blink" 1>&2
          exit 1 ;;
  esac
done


# pre command
stty 9600 cs8 < /dev/ttyS0
#
# (Official Sample) all lignts on and sound pipipi
#echo "@??12>!" > /dev/ttyS0

if [ "$VALUE_R" = "0" ]; then
    # red stop off
    echo "@??021!" > /dev/ttyS0
elif [ "$VALUE_R" = "1" ]; then
    # red on
    echo "@??101!" > /dev/ttyS0
elif [ "$VALUE_R" = "2" ]; then
    # red off
    echo "@??001!" > /dev/ttyS0
    # red blink 
    echo "@??120!" > /dev/ttyS0
fi


if [ "$VALUE_G" == "0" ]; then
    # green stop off
    echo "@??084!" > /dev/ttyS0
elif [ "$VALUE_G" == "1" ]; then
    # green on
    echo "@??104!" > /dev/ttyS0
elif [ "$VALUE_G" == "2" ]; then
    # green off
    echo "@??004!" > /dev/ttyS0
    # green blink
    echo "@??180!" > /dev/ttyS0
fi


if [ "$VALUE_Y" == "0" ]; then
    # yellow stop off
    echo "@??042!" > /dev/ttyS0
elif [ "$VALUE_Y" == "1" ]; then
    # yellow on
    echo "@??102!" > /dev/ttyS0
elif [ "$VALUE_Y" == "2" ]; then
    # yellow off
    echo "@??002!" > /dev/ttyS0
    # yellow blink
    echo "@??140!" > /dev/ttyS0
fi
