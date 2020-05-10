#!/bin/sh

## check param
[ $# = 1 ] || { echo -e "\nPlease input the file(xxx.ext) which need to combine (xxx.mkv & xxx.srt)\n"; exit 0; }

filename=$1
name=$(echo ${filename%.*})

## check file is exist
[ -f "${name}.mkv" ] || { echo -e "\nThe mkv file is not exist!\n"; exit 0; }
[ -f "${name}.srt" ] || { echo -e "\nThe srt file is not exist!\n"; exit 0; }


echo -e "\nThe need combine's filename:\n${name}.mkv\n${name}.srt\n"


#check streams counts
count=$(ffprobe -v quiet -show_streams ${filename} | grep "index" | wc -l)
streams=""
for((i=0; i<${count}; i++)); do
streams="${streams} -map 0:${i}"
done

## add a extra stream for srt
streams="${streams} -map 1:0 "
total_count=$[${count}+1]

echo ${total_count}
## copy exist stream
streams="${streams} -c copy"


echo -e "Adding...\n"
#ffmpeg -i ${name}.mkv -i ${name}.srt -c copy ${name}.srt.mkv
#ffmpeg -i ${name}.mkv -i ${name}.srt ${streams} -c:s srt ${name}.srt.mkv

######
#ffmpeg -y -i Evita.mkv -f srt -i Evita-dan.srt -map 0:0 -map 0:1 -map 0:2 -map 0:3 -map 0:4 -map 0:5 -map 0:6 -map 0:7 -map 0:8 -map 1:0 -c copy -c:s srt -metadata:s:9 language=dan Evita-dan.mkv


ffmpeg -i ${name}.mkv -f srt -i ${name}.srt ${streams} -c:s srt -metadata:s:${total_count} language=chi ${name}.srt.mkv

echo -e "Finished to adding srt to $(basename $filename)"
