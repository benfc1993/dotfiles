#!/bin/bash

notes_dir=$(cat ~/.note-taker/notes_dir.txt)
current_note=$(cat ~/.note-taker/current.txt)
if [ ! -s $notes_dir/$current_note ];
then
    echo "No current note file!"
    read -n 1 -s -r -p "Press any key to continue"
    exit 1;
fi
echo "Adding to note: $current_note"
echo ""
read -p '>' newLine

echo $newLine >> "$notes_dir/$current_note"
