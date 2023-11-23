#!/bin/bash

read -p 'Search >' search;

search="${search// /+}"

python3 -m webbrowser -t "https://google.com/search?q=$search";

exit 0;

