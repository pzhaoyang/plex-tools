#!/bin/sh

[ $# = 1 ] || { echo -n "Input the file name!\n"; exit 0; }

#cmd="ffprobe -v quiet -show_format -show_streams -print_format json"
cmd="ffprobe -v warning -show_streams -print_format json"


${cmd} "$1"
