#!/bin/bash

echo "Create new note"
echo ""
read -p 'Note title:' noteName

if test -f "~/.note-taker/$noteName.md"; then
    exit 1
fi

cleaned="${noteName// /_}"

touch ~/.note-taker/notes/$cleaned.md
echo "# $noteName" > ~/.note-taker/notes/$cleaned.md
echo "" >> ~/.note-taker/notes/$cleaned.md

echo "$cleaned.md" > ~/.note-taker/current.txt
