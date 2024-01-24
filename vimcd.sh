#! /bin/bash

if [[ -d $1 ]];

then
    cd $1 && nvim .
else
    cd "$(dirname "$1")"
    echo pwd
    nvim $(basename "$1")
fi
