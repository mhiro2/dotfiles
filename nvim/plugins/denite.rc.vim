nnoremap [Denite]   <Nop>
nmap    <Space>u [Denite]

nnoremap [Denite]b :<C-u>Denite buffer<CR>
nnoremap [Denite]f :<C-u>DeniteBufferDir file_rec<CR>
nnoremap [Denite]r :<C-u>Denite file_mru<CR>
nnoremap [Denite]g :<C-u>DeniteBufferDir grep<CR>
nnoremap [Denite]y :<C-u>Denite -buffer-name=register unite:register neoyank<CR>
"nnoremap <silent> / :<C-u>Denite -buffer-name=search line<CR>

autocmd FileType denite hi CursorLine ctermbg=blue
