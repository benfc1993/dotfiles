result=$(fdfind -t d . ~ | fzf-tmux -p --reverse)

if [ -z "$result" ]; then
    exit 0;
else
    cd "$result"
    nvim
fi
