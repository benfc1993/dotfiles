let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +113 configs/tmux/plugins/cheatsheet/cheatsheet.md
badd +58 configs/tmux/tmux.conf
badd +1 configs/nvim/lua/custom/plugin/obsession.lua
badd +1 configs/tmux/plugins/v-session.sh
badd +42 configs/tmux/plugins/note-taker/note-taker.sh
badd +55 configs/setup-tmux.sh
badd +6 configs/tmux/plugins/note-taker/change-note-dir.sh
badd +1 configs/nvim/lua/custom/lsp/java/test-runner.lua
argglobal
%argdel
$argadd configs
edit configs/tmux/plugins/note-taker/change-note-dir.sh
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 73 + 65) / 131)
exe 'vert 2resize ' . ((&columns * 57 + 65) / 131)
argglobal
balt configs/tmux/plugins/cheatsheet/cheatsheet.md
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 6 - ((5 * winheight(0) + 21) / 43)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 6
normal! 06|
lcd ~/configs
wincmd w
argglobal
if bufexists(fnamemodify("~/configs/tmux/plugins/note-taker/note-taker.sh", ":p")) | buffer ~/configs/tmux/plugins/note-taker/note-taker.sh | else | edit ~/configs/tmux/plugins/note-taker/note-taker.sh | endif
if &buftype ==# 'terminal'
  silent file ~/configs/tmux/plugins/note-taker/note-taker.sh
endif
balt ~/configs/nvim/lua/custom/lsp/java/test-runner.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 43 - ((33 * winheight(0) + 21) / 43)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 43
normal! 010|
lcd ~/configs
wincmd w
2wincmd w
exe 'vert 1resize ' . ((&columns * 73 + 65) / 131)
exe 'vert 2resize ' . ((&columns * 57 + 65) / 131)
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
let g:this_session = v:this_session
let g:this_obsession = v:this_session
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
