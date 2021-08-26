#!/usr/bin/env bash

if (( $# >= 2 )); then
    image=$1
    shift 1

    command=$@
    echo "command: $command"

    #echo "Pulling dockcross/$image"
    #docker pull dockcross/"$image"

    echo "Make script dockcross-$image"
    docker run --rm dockcross/"$image" > ./dockcross-"$image"
    chmod +x ./dockcross-"$image"
    
    echo "Run command in dockcross-$image"
    ./dockcross-"$image" $command
else
    echo "Usage: ${0##*/} <docker imag (ex: linux-x64/linux-x64-clang/linux-arm64/windows-shared-x64/windows-static-x64...)> <command>"
    exit 1
fi
