set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

augroup random
  autocmd!
  " autocmd VimResized * execute "normal! \<c-w>="

  autocmd BufReadPost *
        \ if line("'\"") >= 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

  " Help mode bindings
  " <enter> to follow tag, <bs> to go back, and q to quit.
  " From http://ctoomey.com/posts/an-incremental-approach-to-vim/
  autocmd filetype help nnoremap <buffer><cr> <c-]>
  autocmd filetype help nnoremap <buffer><bs> <c-T>
  autocmd filetype help nnoremap <buffer>q :q<cr>
  autocmd filetype help set nonumber
  " autocmd filetype help wincmd _ " Maximze the help on open

  autocmd filetype gitcommit wincmd _
  autocmd filetype ctrlsf wincmd _

  autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END
