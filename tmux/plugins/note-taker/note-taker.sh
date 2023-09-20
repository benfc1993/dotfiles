#!/bin/zsh

script_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

while getopts ":nlavd" option; do
  case $option in
    n)
        tmux display-popup -h 5 -E "$script_path/create.sh" 
        exit 0
      ;;
    l)
        cd ~/.note-taker/notes
        file_name=$(fzf-tmux -p -w 60% -h 80% --layout reverse --header "Current note: $(cat ~/.note-taker/current.txt)" --preview 'glow {}')
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
        file_name=$(fzf-tmux -p -w 60% -h 80% --layout reverse --header "Select note to delete" --preview 'glow {}')
        if [ -z $file_name ];
        then
            exit 0
        else
            rm -rf ~/.note-taker/notes/$file_name
            exit 0
        fi
        ;;
    *)
      echo "Usage: note-taker [-n create new note | -l list all notes | -a add line to current note | -v view current note] [-d directory_name]"
      exit 1
      ;;
  esac
done

echo "Usage: note-taker [-n create new note | -l list all notes | -a add line to current note | -v view current note] [-d directory_name]"
exit 1

