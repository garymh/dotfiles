if has('folding')
  setlocal nofoldenable
endif

if has('syntax')
  setlocal spell
endif

normal gg

au FileType gitcommit inoremap # #<c-x><c-o>
au FileType gitcommit inoremap @ @<c-x><c-o>

" set colorcolumn=81
" set textwidth=80
" autocmd FileType gitcommit set colorcolumn=73
" autocmd FileType gitcommit set textwidth=72
