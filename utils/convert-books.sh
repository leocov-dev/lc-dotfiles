#!/usr/bin/env bash

__root_dir=${1}

if [[ ! -d $__root_dir ]]; then
    echo "not a directory ${__root_dir}"
    exit 1
fi

cd "${__root_dir}" || exit 1

for dir in ./*/; do      # list directories in the form "/tmp/dirname/"
    __dir=${dir%*/}      # remove the trailing "/"
    __dir="${__dir##*/}" # print everything after the final "/"

    if [[ -f "${__root_dir}/${__dir}.m4b" ]]; then
        echo "! ==> already converted: ${__dir}"
        continue
    fi

    echo "Converting: ${__dir}..."

    docker run \
        -it \
        --rm \
        -u $(id -u):$(id -g) \
        -v "$(pwd)":/mnt \
        sandreas/m4b-tool:latest \
        merge "${__dir}" --output-file "${__dir}.m4b"
done

echo "Done."
