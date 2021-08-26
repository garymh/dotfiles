" Originally from https://github.com/knubie/vim-kitty-navigator

" Maps <C-h/j/k/l> to switch vim splits in the given direction. If there are
" no more windows in that direction, forwards the operation to kitty.

if exists("g:loaded_kitty_navigator") || &cp || v:version < 700
  finish
endif
let g:loaded_kitty_navigator = 1

function! s:VimNavigate(direction)
  try
    execute 'wincmd ' . a:direction
  catch
    echohl ErrorMsg | echo 'E11: Invalid in command-line window; <CR> executes, CTRL-C quits: wincmd k' | echohl None
  endtry
endfunction

command! KittyNavigateLeft     call s:KittyAwareNavigate('h')
command! KittyNavigateDown     call s:KittyAwareNavigate('j')
command! KittyNavigateUp       call s:KittyAwareNavigate('k')
command! KittyNavigateRight    call s:KittyAwareNavigate('l')
command! KittyNavigatePrev     call s:KittyAwareNavigate('W')
command! KittyNavigateNext     call s:KittyAwareNavigate('w')

function! s:KittyCommand(args)
  let cmd = 'kitty @ ' . a:args
  return system(cmd)
endfunction

function! s:KittyAwareNavigate(direction)
  let nr = winnr()
  let at_first_window = (nr == 1)
  let at_last_window = (nr == winnr('$'))
  let mappings = {
        \   "h": "left",
        \   "j": "bottom",
        \   "k": "top",
        \   "l": "right",
        \   "w": "next",
        \   "W": "prev"
        \ }
  let args = 'kitten neighboring_window.py' . ' ' . mappings[a:direction]

  if (a:direction == "l") || (mappings[a:direction] == "next") || (a:direction == "j")
    if at_last_window
      call s:KittyCommand(args)
    else
      call s:VimNavigate(a:direction)
    endif
  elseif (a:direction == "h") || (mappings[a:direction] == "prev") || (a:direction == "k")
    if at_first_window
      call s:KittyCommand(args)
    else
      call s:VimNavigate(a:direction)
    endif
  endif
endfunction
