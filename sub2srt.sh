#!/bin/sh

## check param
[ $# -ge 1 ] || { echo -n "\nPlease input the DTS file, which need to convert to 2.1 channel!\n"; exit 0; }

params=($*)



for file in ${params[@]}; do
echo "Start Convert ${file}"


## check file is exist
[ -f "$file" ] || { echo -e "The file is not exist!\n\n"; continue; }

## get finename
name="$(echo ${file%.*})"
ext="$(echo ${file##*.})"


### check audio stream channel
chn=$(ffprobe -v quiet -show_streams -print_format flat "${file}" | grep "audio" | wc -l)


streams="-map 0 -c copy"
## change audio codec
for((i=0; i<${chn}; i++)); do
streams="${streams} -c:a:${i} aac -b:a:${i} 48k "
done


ffmpeg  -y -v info -i "${file}" ${streams} "${name}"_aac.${ext}


if [ $? -eq 0 ]; then
echo    rm -rvf "${file}"
echo    mv -v "${name}_aac.${ext}" "${file}"
    echo -e "DTS to AAC Succeed!\n"
else
echo    rm -rvf "${name}_aac.${ext}"
    echo -e "Convert Failed!\n"
fi

done
echo -e "All files converted finished!\n"
