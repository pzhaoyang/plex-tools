#!/bin/sh


params=($*)

for file in ${params[@]}; do
echo "Start Convert ${file}"

## check file is exist
[ -f "$file" ] || { echo -e "The file is not exist!\n\n"; continue; }


## get finename
name="$(echo ${file%.*})"
origin_ext="$(echo ${file##*.})"
new_ext=mkv


streams="-map 0 -c copy"

ffmpeg  -y -v info -i "${file}" ${streams} "${name}".${new_ext}

if [ $? -eq 0 ]; then
    rm -rvf "${file}"
    echo -e "$(echo ${file##*.}) to mkv Succeed!\n"
else
    rm -rvf "${name}".${new_ext}
    echo -e "Convert Failed!\n"
fi
done
echo -e "All files converted finished!\n"
