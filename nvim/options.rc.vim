"--------------------------------------------
" Basic:

" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=5

" Don't create backup.
set nowritebackup
set nobackup

" Don't create swap file.
 set noswapfile

" Auto reload when changed by external.
set autoread

" Display another buffer when current buffer isn't saved.
set hidden

" Input method is always off.
if has('multi_byte_ime')
  set iminsert=0 imsearch=0
endif

" Disable bell.
set t_vb=
set novisualbell

" Free move in Visual mode blockwise.
set virtualedit=block

" Wrap conditions.
set whichwrap=b,s,<,>,[,]

" Disable auto wrap.
autocmd MyAutoCmd FileType *
      \ if &l:textwidth != 99 && &filetype !=# 'help' |
      \    setlocal textwidth=0 |
      \ endif

" Highlight column after 'textwidth'.
if exists('&colorcolumn')
  set colorcolumn=+1
  autocmd FileType c,cpp,python setlocal textwidth=99
endif

" Enable folding.
set foldenable
set foldmethod=marker
set foldcolumn=5
set fillchars=vert:\|
if exists('*FoldCCtext')
  " Use FoldCCtext().
  set foldtext=FoldCCtext()
endif

" Splitting a window will put the new window below the current one.
set splitbelow
" Splitting a window will put the new window right the current one.
set splitright
" Set minimal width for current window.
set winwidth=30
" Set maximam maximam command line window.
set cmdwinheight=5
" No equal window size.
set noequalalways
" Adjust window size of preview and help.
set previewheight=8
set helpheight=12


"--------------------------------------------
" Search:

" Don't redraw while macro executing.
set lazyredraw

" Searches wrap around the end of the file.
set wrapscan

" Enable incremental search.
set incsearch

" Ignore the case of normal letters.
set ignorecase

" If the search pattern contains upper case characters, override ignorecase option.
set smartcase

" Highlight search result.
set hlsearch


"--------------------------------------------
" Edit:

" Smart insert tab setting.
set smarttab
" Exchange tab to spaces.
set expandtab

" Change default directory.
set browsedir=buffer

" Auto copy selected text to system clipboard.
if (!has('nvim') || $DISPLAY != '') && has('clipboard')
  if has('unnamedplus')
    set clipboard& clipboard+=unnamedplus
  else
    set clipboard& clipboard+=unnamed
  endif
endif

" Enable backspace delete indent and newline.
set backspace=indent,eol,start

" Enable modeline.
set modeline

" Ignore case on insert completion.
set infercase

" Disable automatically insert comment.
autocmd MyAutoCmd FileType *
      \ setl formatoptions-=ro | setl formatoptions+=mM


"--------------------------------------------
" Indent:

" Enable smart indent.
set autoindent
set smartindent

" Substitute <Tab> with blanks.
set tabstop=2
" Spaces instead <Tab>.
set softtabstop=2
" Autoindent width.
set shiftwidth=2

" Round indent by shiftwidth.
set shiftround


"--------------------------------------------
" Mouse:

" Enable mouse support.
set mouse=a

if has('gui_running')
  " Show popup menu if right click.
  set mousemodel=popup

  " Don't focus the window when the mouse pointer is moved.
  set nomousefocus
  " Hide mouse pointer on insert mode.
  set mousehide
endif


"--------------------------------------------
" Appearance:

" Enable syntax color.
syntax enable

" Show title.
set title
" Show line number.
set number
" Show the line and column number of the cursor position.
set ruler
" Always display a status line at the bottom of the window.
set laststatus=2
" Highlight Cursour Line
set cursorline
" Show command on statusline.
set showcmd
" Highlight parenthesis.
set showmatch
" Highlight a pair of < and >.
set matchpairs+=<:>
" Control cursor movement.
set matchtime=0

" Enhanced mode.
set wildmenu
set wildmode=list:longest,full

" Display invisible characters.
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

" Use 256 colors.
set t_Co=256

" Change colorscheme.
set background=dark
colorscheme molokai

hi Comment term=italic cterm=none ctermfg=darkgray ctermbg=none

" Popup color.
hi Pmenu ctermbg=white ctermfg=black
hi PmenuSel ctermbg=20 ctermfg=white
hi PmenuSbar ctermbg=1 ctermfg=0

" Floating window.
highlight NormalFloat ctermbg=0 ctermfg=white
