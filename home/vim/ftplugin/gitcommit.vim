if has('folding')
  setlocal nofoldenable
endif

if has('syntax')
  setlocal spell
endif

normal gg

au FileType gitcommit inoremap # #<c-x><c-o>
au FileType gitcommit inoremap @ @<c-x><c-o>
