"--------------------------------------------
" Key Mappings:

" Move cursor by display line. (see also accelerated_jk)
"nnoremap j gj
"nnoremap k gk

" <C-a>, A: move to head.
inoremap <C-a> <Home>
nnoremap <C-a> <Home>
"
" <C-e>, E: move to end.
inoremap <C-e> <End>
nnoremap <C-e> <End>
"
" Move window.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Centering search result and open fold.
noremap n nzzzv
noremap N Nzzzv
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap g* g*zzzv
nnoremap g# g#zzzv

" Clear highlight.
nnoremap <Esc><Esc> :nohlsearch<CR>

" Disable "ZZ".
nnoremap ZZ <Nop>

" Swap ";" to ":".
noremap ; :
noremap : ;

" Easy escape.
inoremap jj <Esc>

" Select to end of line in visual mode.
vnoremap v $h

" Continuous indent block in visualmode
vnoremap < <gv
vnoremap > >gv
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Yank to end of line.
nnoremap Y y$

" Don't store register.
nnoremap x "_x

" Escape backslash automatically while searching.
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" Close help and git window by pressing q.
autocmd FileType help,git-status,git-log,qf,J6uil_say,vimconsole,
       \gitcommit,quickrun,qfreplace,ref,vcs-commit,vcs-status
       \ nnoremap <buffer><silent> q :<C-u>call <sid>smart_close()<CR>
autocmd FileType * if (&readonly || !&modifiable) && !hasmapto('q', 'n')
        \ | nnoremap <buffer><silent> q :<C-u>call <sid>smart_close()<CR>| endif

" <C-a>, A: move to head.
cnoremap <C-a> <Home>

" <C-b>: previous char.
"cnoremap <C-b> <Left>

" <C-d>: delete char.
"cnoremap <C-d> <Del>

" <C-e>, E: move to end.
cnoremap <C-e> <End>

" <C-f>: next char.
"cnoremap <C-f> <Right>

" <C-n>: next history.
"cnoremap <C-n> <Down>

" <C-p>: previous history.
"cnoremap <C-p> <Up>

" <C-k>, K: delete to end.
"cnoremap <C-k> <C-\>e getcmdpos() == 1 ?
"      \ '' : getcmdline()[:getcmdpos()-2]<CR>

" <C-y>: paste.
"cnoremap <C-y> <C-r>*
