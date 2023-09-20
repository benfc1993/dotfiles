#!/bin/bash

echo "Create new note"
echo ""
read -p 'Note name:' noteName

if test -f "~/.note-taker/$noteName.md"; then
    exit 1
fi

touch ~/.note-taker/notes/$noteName.md

echo "$noteName.md" > ~/.note-taker/current.txt
