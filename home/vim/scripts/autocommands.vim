augroup random
  autocmd!
  autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END

augroup vimrc_help
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd o | endif
  autocmd BufEnter *.txt if &buftype == 'help' | setlocal nonumber buflisted | endif
augroup END

augroup grabbag
  autocmd!
  " autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
  autocmd FileType vista,vista_kind nnoremap <buffer> <silent> \/ :<c-u>call vista#finder#fzf#Run()<CR>
  autocmd FileType vista,vista_kind nnoremap <buffer> <silent> o :<c-u>call vista#cursor#FoldOrJump()<CR>
  autocmd FileType * setlocal formatoptions-=cro

  if exists('##TextYankPost')
    autocmd TextYankPost * silent! lua return (not vim.v.event.visual) and require'vim.highlight'.on_yank('Substitute', 200)
  endif
augroup END
