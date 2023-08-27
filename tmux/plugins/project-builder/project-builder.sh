#!/bin/bash

source ~/.profile

script_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

languages=`echo "typescript java cs cpp" | tr ' ' '\n'`


language=`printf "$languages" | fzf-tmux`

if [[ -z $language ]];
then
    exit 0
fi

read -p "project-name:" name

echo "$name"

if [[ -z "$name" ]];
then
    exit 0 
fi

$script_path/$language.sh $name

