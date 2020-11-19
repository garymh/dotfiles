if has('folding')
  setlocal nofoldenable
endif

if has('syntax')
  setlocal spell
endif

normal gg

function! s:StartInsertIfEmpty()
  if (empty(getline(1)))
    startinsert!
  endif
endfunction

" " great stuff from https://github.com/jonsmithers/dotfiles/blob/master/vim/vimrc
call s:StartInsertIfEmpty()

let b:ale_linters = ['vale']

" " setlocal textwidth=51
setlocal textwidth=51
" setlocal colorcolumn=73
setlocal colorcolumn=51,73
