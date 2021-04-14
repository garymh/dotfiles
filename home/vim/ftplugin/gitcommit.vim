setlocal nofoldenable
setlocal spell

normal gg

function! s:StartInsertIfEmpty()
  if (empty(getline(1)))
    startinsert!
  endif
endfunction

" " great stuff from https://github.com/jonsmithers/dotfiles/blob/master/vim/vimrc
call s:StartInsertIfEmpty()

let b:ale_linters = ['vale']

setlocal textwidth=51
setlocal colorcolumn=51,73
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
