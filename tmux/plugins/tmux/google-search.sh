#!/bin/bash

read -p 'search | url >' search;

if [[ "$search" =~ ^https://.*$ ]]; then
    python3 -m webbrowser -t "$search"
elif [[ "$search" =~ ^[a-zA-Z0-9\/]*\.[a-zA-Z0-9]*(\.[a-z]*)?$ ]]; then
   python3 -m webbrowser -t "https://$search"    
else

    search="${search// /+}"

    python3 -m webbrowser -t "https://google.com/search?q=$search" 
fi

exit 0;

