"--------------------------------------------
" Key Mappings:

" Move cursor by display line. (see also accelerated_jk)
"nnoremap j gj
"nnoremap k gk

" <C-a>, A: move to head.
inoremap <C-a> <Home>
nnoremap <C-a> <Home>
cnoremap <C-a> <Home>

" <C-e>, E: move to end.
inoremap <C-e> <End>
nnoremap <C-e> <End>
cnoremap <C-e> <End>

" <C-k>, K: delete to end.
cnoremap <C-k> <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>

" <C-p>: previous history.
cnoremap <C-p> <Up>

" <C-n>: next history.
cnoremap <C-n> <Down>

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
cnoremap jj <C-c>
inoremap j<Space> j
cnoremap j<Space> j

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

function! s:smart_close()
  if winnr('$') != 1
    close
  endif
endfunction

" Close help and git window by pressing q.
autocmd FileType help,git-status,git-log,qf,vimconsole,gitcommit,quickrun,qfreplace,ref,vcs-commit,vcs-status
  \ nnoremap <buffer><silent> q :<C-u>call <sid>smart_close()<CR>
autocmd FileType * if (&readonly || !&modifiable) && !hasmapto('q', 'n')
  \ | nnoremap <buffer><silent> q :<C-u>call <sid>smart_close()<CR>| endif
