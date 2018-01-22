augroup random

  set noerrorbells visualbell t_vb=
  if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
  endif

  autocmd!
  " autocmd VimResized * execute "normal! \<c-w>="

  autocmd BufReadPost *
        \ if line("'\"") >= 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

  autocmd filetype help nnoremap <buffer><cr> <c-]>
  autocmd filetype help nnoremap <buffer><bs> <c-T>
  autocmd filetype help nnoremap <buffer>q :q<cr>
  autocmd filetype help set nonumber

  autocmd filetype gitcommit wincmd _
  autocmd filetype ctrlsf wincmd _

  autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END
