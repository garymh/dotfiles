augroup random
  autocmd!

  " autocmd filetype ctrlsf wincmd o
  " autocmd filetype gitcommit wincmd o

  autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END

augroup vimrc_help
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd o | endif
  autocmd BufEnter *.txt if &buftype == 'help' | setlocal nonumber buflisted | endif
augroup END

	" Outline the contents of the buffer
command! -nargs=* Outline call s:Outline(<f-args>)
function! s:Outline(...)
  if a:0 > 0
    let pattern = join(a:000, '\|')
  elseif exists('b:outline_pattern')
    let pattern = b:outline_pattern
  elseif !exists('b:outlined')
    echoerr "No b:outline_pattern for this buffer"
  endif

  if exists('b:outlined') " Un-outline it
    FoldEndFolding
    unlet b:outlined
  else
    exe "FoldMatching ".pattern." -1"
    let b:outlined = 1
    setlocal foldenable
  endif
endfunction
