#!/usr/bin/env bash

__root_dir=${1}

if [[ ! -d $__root_dir ]]; then
    echo "not a directory ${__root_dir}"
    exit 1
fi

cd "${__root_dir}" || exit 1

for dir in ./*/; do
    __dir=${dir%*/}
    __dir="${__dir##*/}"

    if [[ -f "${__root_dir}/${__dir}/${__dir}.mp4" ]]; then
        echo "! ==> already converted: ${__dir}"
        continue
    fi

    echo "Converting: ${__dir} ==>"
    : > list.txt

    mapfile -t __files < <(find "$__dir" -type f)
    readarray -t __files < <(for a in "${__files[@]}"; do echo "$a"; done | sort)

    if [[ ${#__files[@]} -le 1 ]]; then
        echo "==> only one file, skipping"
        continue
    fi

    for f in "${__files[@]}"; do
#        f=${f##*/}
        echo "file '$f'" >> list.txt
    done

    ffmpeg -f concat -safe 0 -i list.txt -s 1280x720 -crf 22 -tune animation "${__dir}/${__dir}.mp4"

done

echo "Done."

rm list.txt

#for f in *.mp4; do
#    echo file \'$f\' >> list.txt
#done
#
#ffmpeg -f concat -safe 0 -i list.txt -s 1280x720 -crf 24 stitched-video.mp4
#
#rm list.txt
