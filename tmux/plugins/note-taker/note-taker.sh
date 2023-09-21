#!/bin/bash

script_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

options=`echo "a - add line,e - edit note,n - new note,l - list notes,v - view note,or - open note right,ol - open note left,d - delete note" | tr ',' '\n'`

selected_option=`printf "$options" | fzf-tmux -p -w 40% --layout reverse --header "Note Taker" | awk '{print $1}'`


  case $selected_option in
    n)
        tmux display-popup -h 5 -E "$script_path/create.sh" 
        exit 0
      ;;
    l)
        cd ~/.note-taker/notes
        file_name=`ls | fzf-tmux -p -w 60% -h 80% --layout reverse --header "Current note: $(cat ~/.note-taker/current.txt)" --preview 'glow {}'`
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
        tmux display-popup -h 80% -E "glow ~/.note-taker/notes/$(cat ~/.note-taker/current.txt); read -n 1 -s -r -p 'Press any key to exit'"
        exit 0
        ;;
    d)
        cd ~/.note-taker/notes
        file_name=`ls | fzf-tmux -p -w 60% -h 80% --layout reverse --header "Select note to delete" --preview 'glow {}'`
        if [ -z $file_name ];
        then
            exit 0
        else
            rm -rf ~/.note-taker/notes/$file_name
            exit 0
        fi
        ;;
    e)

        tmux display-popup -h 80% -E "nvim ~/.note-taker/notes/$(cat ~/.note-taker/current.txt)"
        exit 0
        ;;
    or)
        tmux split-window -hf -p 31 "nvim ~/.note-taker/notes/$(cat ~/.note-taker/current.txt)" 
        exit 0
        ;;
    ol)
        tmux split-window -hbf -p 30 "nvim ~/.note-taker/notes/$(cat ~/.note-taker/current.txt)" 
        exit 0
        ;;
    *)
        exit 0
        ;;
  esac


