augroup random
  autocmd!

  autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

  " autocmd filetype ctrlsf wincmd o
  " autocmd filetype gitcommit wincmd o

  autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END

augroup vimrc_help
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd o | endif
  autocmd BufEnter *.txt if &buftype == 'help' | setlocal nonumber buflisted | endif
augroup END
