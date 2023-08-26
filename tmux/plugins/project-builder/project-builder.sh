#! /bin/bash

script_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

languages=`echo "typescript java cs cpp" | tr ' ' '\n'`

language=`printf "$languages" | fzf-tmux -p`
echo "$language"

read -p "project-name:" name

"$script_path/$language.sh" $name

