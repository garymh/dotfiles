augroup random
  autocmd!

  autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

  " autocmd filetype ctrlsf wincmd o
  " autocmd filetype gitcommit wincmd o

  autocmd BufReadPost fugitive://* set bufhidden=delete

  " autocmd BufNewFile,BufReadPost vim,eruby let b:tagbar_ignore = 1
  " autocmd VimEnter * nested :call tagbar#autoopen(1)
  " autocmd FileType * nested :call tagbar#autoopen(0)
augroup END

augroup vimrc_help
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd o | endif
  autocmd BufEnter *.txt if &buftype == 'help' | setlocal nonumber buflisted | endif
augroup END
