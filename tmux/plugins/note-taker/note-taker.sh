#!/bin/bash

script_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

note_taker_dir=~/.note-taker

if [ ! -f $note_taker_dir/notes_dir.txt ];
then
    tmux display-popup -h 5 -E "$script_path/change-note-dir.sh"

fi

notes_dir=$(cat $note_taker_dir/notes_dir.txt)

options=`echo "a - add line,e - edit note,n - new note,l - list notes,v - view note,or - open note right,ol - open note left,d - delete note" | tr ',' '\n'`

selected_option=`printf "$options" | fzf-tmux -p -w 40% --layout reverse --header "Note Taker: $notes_dir" | awk '{print $1}'`


  case $selected_option in
    n)
        tmux display-popup -h 5 -E "$script_path/create.sh" 
        exit 0
      ;;
    l)
        cd $notes_dir
        file_name=`fd "" . -e md | fzf-tmux -p -w 60% -h 80% --layout reverse --header "Current note: $(cat ~/.note-taker/current.txt)" --preview 'glow {}'`
        if [ -z $file_name ];
        then
            exit 0
        else
            echo "$file_name" > ~/.note-taker/current.txt
            exit 0
        fi
        ;;
    a)
        tmux display-popup -h 5 -E "$script_path/add.sh"
        exit 0
        ;;
    v)
        file=$(cat ~/.note-taker/current.txt)
        tmux display-popup -h 90% -E "glow \"${notes_dir}/${file}\";read -p 'press ENTER to quit' t;"
        ;;
    d)
        cd $notes_dir 
        file_name=`fd "" . -e md | fzf-tmux -p -w 60% -h 80% --layout reverse --header "Select note to delete" --preview 'glow {}'`
        if [ -z $file_name ];
        then
            exit 0
        else
            rm -rf $notes_dir/$file_name
            exit 0
        fi
        ;;
    e)
        file=$(cat ~/.note-taker/current.txt)

        tmux display-popup -h 80% -E "nvim \"${notes_dir}/${file}\""
        exit 0
        ;;
    or)

        file=$(cat ~/.note-taker/current.txt)
        tmux split-window -hf -p 31 "nvim \"${notes_dir}/${file}\""
        exit 0
        ;;
    ol)
        file=$(cat ~/.note-taker/current.txt)
        tmux split-window -hbf -p 30 "nvim \"${notes_dir}/${file}\"" 
        exit 0
        ;;
    *)
        exit 0
        ;;
  esac


