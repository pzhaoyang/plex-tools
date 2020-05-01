#!/bin/sh

#debug enable
#debug=echo 

[ $# -ge 1 ] || { echo -e "Input the file name & channels that need to be removed !\n"; exit 0; }

params=($*)

for i in ${params[@]}; do
if [ "$i" -ge 0 ] 2>/dev/null
then
 removed_channels[${#removed_channels[@]}]=$i
else
 files[${#files[@]}]="$i"
fi
done

for file in ${files[@]}; do
echo "Start Convert ${file}"
## check file is exist
[ -f "$file" ] || { echo -e "The file is not exist!\n\n"; continue; }

## get filename
name="$(echo ${file%.*})"
ext="$(echo ${file##*.})"

## all channels that the video existed
allchannels=($(ffprobe -v quiet -show_streams -print_format flat "${file}" | grep "codec_type" | sed 's;.*\([0-9]\).*\"\([a-z]\).*\";\1:\2;g' ))

# remove the channel that need to be removed from allchannels
for j in ${removed_channels[@]}; do
    unset allchannels[$j];
done

streams=""
for i in ${allchannels[@]}; do
num=$(echo $i | sed 's;.*\([0-9]\).*;\1;g')
tpe=$(echo $i | sed 's;.*\([a-z]\).*;\1;g')
streams="${streams} -map 0:${num} -c:${tpe} copy "
done


$debug ffmpeg -y -i "${file}" ${streams} "${name}".lite.${ext}

[ $? -eq 0 ] || { echo -e Convert Failed!\n\n; $debug rm -rvf "${name}.lite.${ext}"; continue; }

$debug rm -rvf "${file}" && $debug mv -v "${name}.lite.${ext}" "${file}"
[ $? -eq 0 ] && { echo -e "Remove channels Succeed!\n\n"; } || { echo -e "Rename file Failed,Please rename manually!\n\n"; continue; } 

done
echo -e "All files converted finished!\n"