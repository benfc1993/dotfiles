#!/bin/bash

if [ ! -s ~/.note-taker/current.txt ];
then
    echo "No current note file!"
    read -n 1 -s -r -p "Press any key to continue"
    exit 1;
fi
echo "Adding to note: $(cat ~/.note-taker/current.txt)"
echo ""
read -p '>' newLine

echo $newLine >> ~/.note-taker/notes/$(cat ~/.note-taker/current.txt)
