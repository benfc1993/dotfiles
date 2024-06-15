#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    result=$(fd -d 8 -td . ~ | fzf-tmux -p --reverse)
else
    result=$(fdfind -d 8 -t d . ~ | fzf-tmux -p --reverse)
fi

if [ -z "$result" ]; then
    exit 0;
else
    cd "$result"
    nvim
fi
