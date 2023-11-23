#!/bin/bash

read -p 'Search >' search;

search="${search// /+}"

vivaldi "https://google.com/search?q=$search";

exit 0;

