nnoremap [Denite]   <Nop>
nmap    <Space>u [Denite]

nnoremap [Denite]b :<C-u>Denite buffer -highlight-mode-insert=PmenuSel<CR>
nnoremap [Denite]f :<C-u>DeniteBufferDir file_rec -highlight-mode-insert=PmenuSel<CR>
nnoremap [Denite]r :<C-u>Denite file_mru -highlight-mode-insert=PmenuSel<CR>
nnoremap [Denite]g :<C-u>DeniteBufferDir grep -highlight-mode-insert=PmenuSel<CR>
nnoremap [Denite]y :<C-u>Denite -buffer-name=register unite:register neoyank -highlight-mode-insert=PmenuSel<CR>

