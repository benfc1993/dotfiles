#!/bin/bash

if [ ! -f ~/.todo/conf ]; then
    mkdir -p ~/.todo
    touch ~/.todo/conf
fi

source ~/.todo/conf
todo_file_path=$FILEPATH

if [ -z $todo_file_path ]; then
    read -p 'Todo file path > ' todo_file_path;
    echo "FILEPATH=$todo_file_path">"$HOME/.todo/conf"
fi

read -p 'TODO > ' todo;

if [ -z "$todo" ]; then
    exit 0
fi

cat "$todo_file_path"

echo "" >>"$todo_file_path"
echo "- TODO $todo" >>"$todo_file_path"

exit 0;

