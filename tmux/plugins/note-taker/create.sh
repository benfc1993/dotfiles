#!/bin/bash

echo "Create new note"
echo ""
read -p 'Note title:' noteName

notes_dir=$(cat ~/.note-taker/notes_dir.txt)

if test -f "${notes_dir}/${noteName}.md"; then
    exit 1
fi

cleaned="${noteName// /_}"
mkdir -p "$(dirname "$notes_dir/$noteName")" && touch "${notes_dir}/${noteName}.md"
echo "# $noteName" > "${notes_dir}/${noteName}.md"
echo "" >> "${notes_dir}/${noteName}.md"

echo "${noteName}.md" > ~/.note-taker/current.txt
