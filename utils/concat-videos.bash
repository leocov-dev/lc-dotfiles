#!/usr/bin/env bash

__dir=${1}

if [[ ! -d $__dir ]]; then
    echo "not a directory ${__dir}"
    exit 1
fi

cd "${__dir}" || exit 123

__dir=${__dir%*/}
__dir="${__dir##*/}"

if [[ -f "${__dir}.mp4" ]]; then
    echo "! ==> already converted: ${__dir}"
    exit 0
fi

echo "Converting: ${__dir} ==>"
: >list.txt

mapfile -t __files < <(find . -type f -name '*.mp4')
readarray -t __files < <(for a in "${__files[@]}"; do echo "$a"; done | sort)

if [[ ${#__files[@]} -le 1 ]]; then
    echo "==> only one file, skipping"
    exit 0
fi

__filter_complex=""
__inputs=()

for i in "${!__files[@]}"; do
    # gather '-i <file>' arguments
    __inputs+=(-i)
    __inputs+=("${__files[i]}")
done

for i in "${!__files[@]}"; do
    # gather pre-scale filter statements
    __filter_complex+="[${i}:v:0]scale=1280:720:force_original_aspect_ratio=1[v${i}]; "
done

for i in "${!__files[@]}"; do
    # gather concat filter statements
    __filter_complex+="[v${i}][${i}:a:0] "
done

# final video-audio merge
__filter_complex+="concat=n=${#__files[@]}:v=1:a=1[outv][outa]"

echo
echo '-----------'
echo

set -x

# shellcheck disable=SC2068
ffmpeg ${__inputs[@]} -filter_complex "${__filter_complex}" \
    -map "[outv]" \
    -map "[outa]" \
    -c:v libx264 -preset fast \
    -c:a aac -b:a 128k \
    -crf 24 \
    -tune animation \
    -vsync vfr \
    "${__dir}.mp4"

echo "Done."
