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

" great stuff from https://github.com/jonsmithers/dotfiles/blob/master/vim/vimrc
call s:StartInsertIfEmpty()
