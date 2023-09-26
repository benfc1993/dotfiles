#!/bin/bash

read wd

source ~/.profile

script_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

languages=`echo "typescript react java cs cpp" | tr ' ' '\n'`


language=`printf "$languages" | fzf-tmux -p`

if [[ -z $language ]];
then
    exit 0
fi

tmux display-popup -E -w 80% -h 80% "$script_path/$language/$language.sh "$wd""

