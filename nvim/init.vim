if &compatible
  set nocompatible
endif

" Set augroup.
augroup MyAutoCmd
  autocmd!
augroup END

" Use <Leader> in global plugin.
let g:mapleader = ','

if has('nvim')
  let s:dein_cache_path = expand('~/.cache/nvim/dein')
else
  let s:dein_cache_path = expand('~/.cache/vim/dein')
endif

let s:dein_dir = s:dein_cache_path
                 \ .'/repos/github.com/Shougo/dein.vim'

if &runtimepath !~ '/dein.vim'
  if !isdirectory(s:dein_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
  endif
  execute 'set runtimepath+=' . fnamemodify(s:dein_dir, ':p')
endif

if dein#load_state(s:dein_cache_path)
  call dein#begin(s:dein_cache_path, [expand('<sfile>')]
              \ + split(glob('~/.config/nvim/*.toml'), '\n'))

  call dein#load_toml('~/.config/nvim/dein.toml', {'lazy' : 0})
  call dein#load_toml('~/.config/nvim/deinlazy.toml', {'lazy' : 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on

runtime! options.rc.vim
runtime! mappings.rc.vim

let g:python_host_prog = $PYENV_ROOT . '/versions/neovim2/bin/python'
let g:python3_host_prog = $PYENV_ROOT . '/versions/neovim3/bin/python'
