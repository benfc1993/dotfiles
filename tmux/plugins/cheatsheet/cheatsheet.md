# Cheat sheet

# Sessions

### new sessions

tmux
tmux new
tmux new-session
tmux new -s sessionname

### attach sessions

tmux a
tmux att
tmux attach
tmux attach-session
tmux a -t sessionname

### remove sessions

tmux kill-ses
tmux kill-session -t sessionname

### key bindings	

Leader = C-a

| binding  | description        |
|:---------|:-------------------|
| Leader $ |  	rename session  | 
| Leader d |  	detach session  |
| Leader ) |  	next session    |
| Leader ( |  	previous session|
| Leader S |    new session     |

## Window

### key bindings	


| binding  | description        |
|:---------|:-------------------|
| Leader C  	| create window |
| Leader N  	| move to next window |
| Leader P  	| move to previous window |
| Leader L  	| move to window last used |
| Leader 0 … 9	| select window by number |
| Leader ‘  	| select window by name |
| Leader .  	| change window number |
| Leader ,  	| rename window |
| Leader F  	| search windows |
| Leader &  	| kill window |
| Leader W  	| list windows |

## Panes

### key bindings	


| binding  | description        |
|:---------|:-------------------|
| Leader v  	| vertical split |
| Leader h  	| horizontal split |
| Leader →  	| move to pane to the right |
| Leader ←  	| move to pane to the left |
| Leader ↑  	| move up to pane |
| Leader ↓  	| move down to pane |
| Leader O  	| go to next pane |
| Leader ;  	| go to last active pane |
| Leader }  	| move pane right |
| Leader {  	| move pane left |
| Leader !  	| convent pane to window |
| Leader X  	| kill pane |

## copy mode

### key bindings	


| binding  | description        |
|:---------|:-------------------|
| Leader [  	| enter copy mode |
| Leader ]	    | paste from buffer |

## Copy mode commands	


| binding  | description        |
|:---------|:-------------------|
| v	            | start selection |
| enter	        | copy selection |
| esc	        |     clear selection |
| CTRL + v      |   toggle rectagle selection |
| y             |   copy selection |
| g	            | go to top |
| G           	| go to bottom |
| h           	| move cursor left |
| j           	| move cursor down |
| k           	| move cursor up |
| l           	| move cursor right |
| /           	| search |
| _           	| list paste buffers |
| q           	| quit |

## Plugins

| binding  | description        |
|:---------|:-------------------|
| C-f       | search in /home   |
| Leader F2 | sessions list |
| Alt + s   | file search |
| Alt + t | toolkit |
| F1        | tmux bindings help |
| Leader + N | project builder |
| CTRL + n | note taker |

