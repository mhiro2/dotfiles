call vimfiler#custom#profile('default', 'context', {
     \ 'safe' : 0,
     \ 'auto_expand' : 1,
     \ 'parent' : 0,
     \ })

let g:vimfiler_as_default_explorer = 1

nnoremap [vimfiler] <Nop>
nmap    <Space>v [vimfiler]
nnoremap <silent> [vimfiler]f
      \ :VimFiler -buffer-name=explorer -split -simple
      \ -winwidth=30 -toggle -no-quit<CR>

let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_readonly_file_icon = '✗'
let g:vimfiler_marked_file_icon = '✓'
