#!/bin/bash

languages=`echo "typescript cs cpp nodejs java" | tr ' ' '\n'`

selected=`printf "$languages\nother" | fzf-tmux -p`

type=""

if [[ -z $selected ]];
then
    exit 0
fi

if [[ $selected = "other" ]];
then
    type=`printf "language\ncore util" | fzf-tmux -p`
    if [ $type = "language" ];
    then
        read -p "language: " selected
    else
        read -p "core util: " selected
    fi
fi

read -p "Query: " query

if  [[  $type = "language" ]]  || [[ $(printf $languages | grep -qs $selected) = "" ]];
then
    curl "cht.sh/$selected/`echo $query | tr ' ' '+'`"
else
    curl "cht.sh/$selected~$query"
fi

