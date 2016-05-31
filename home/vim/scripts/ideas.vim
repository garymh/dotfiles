
" Duplicate and comment out duplicate.
nmap <leader>dc :t.<CR>k<Plug>CommentaryLinej

function! s:Pulse()
  setlocal cursorline
  redraw
  sleep 100m

  setlocal nocursorline
  redraw
  sleep 100m

  setlocal cursorline
  redraw
  sleep 100m

  setlocal nocursorline
  redraw
endfunction
autocmd FocusGained * call s:Pulse()

" https://github.com/kana/vim-textobj-user/wiki
