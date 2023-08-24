#! /bin/bash


selected_session=$(ls ~/.vim/sessions | fzf-tmux -p)
if $selected_session; then 
echo "exit" > ~/test.txt
    exit 1
fi
echo "continue" > ~/test.txt

selected_session=~/.vim/sessions/$selected_session

while getopts 'dha:' OPTION; do
  case "$OPTION" in
    d)
      rm -rf $selected_session
      exit 0 
      ;;
  esac
done
shift "$(($OPTIND -1))"

nvim -S $selected_session 

