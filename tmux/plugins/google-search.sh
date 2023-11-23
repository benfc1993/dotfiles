#!/bin/bash

read -p 'search | url >' search;

if [[ "$search" =~ ^[a-zA-Z0-9\/]*\.[a-zA-Z0-9\/]*$ ]]; then
   python3 -m webbrowser -t "https://$search"    
else

    search="${search// /+}"

    python3 -m webbrowser -t "https://google.com/search?q=$search";
fi

exit 0;

