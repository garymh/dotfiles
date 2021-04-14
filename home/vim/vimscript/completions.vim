set completeopt=menuone,noinsert,noselect
set shortmess+=c

let g:deoplete#enable_at_startup = 1
imap <expr><TAB>
      \ vsnip#available(1) ?
      \    "\<Plug>(vsnip-expand-or-jump)" :
      \  pumvisible() ? "\<C-n>" : "\<TAB>"
