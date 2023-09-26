#!/bin/bash

read -p 'where are your notes stored? ' input; 
input="${input/#\~/$HOME}"
echo $input > ~/.note-taker/notes_dir.txt;
echo $input
