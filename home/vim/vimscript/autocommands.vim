function! GoyoBefore()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! GoyoAfter()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

let g:goyo_callbacks = [function('GoyoBefore'), function('GoyoAfter')]

function! MyHighlights() abort
    highlight Whitespace               guibg=None                  ctermbg=None
    highlight Comment                                              cterm=italic gui=italic
    highlight Type                                                 cterm=bold gui=bold
    highlight SpecialComment                                       cterm=italic gui=italic
    highlight BufferCurrent            guibg=#506591 guifg=#ffffff
    highlight BufferCurrentMod         guibg=#506591 guifg=#FF7570
    highlight BufferCurrentSign        guibg=#506591 guifg=#ffffff
    " highlight IndentBlankLine1         guibg=#373737
    " highlight IndentBlankLine2         guibg=#474747
    " highlight IndentBlankLine3         guibg=#575757
    " highlight IndentBlankLine4         guibg=#676767
    " highlight IndentBlankLine5         guibg=#777777
    highlight IndentBlankLine1       guibg=#1c212c
    highlight IndentBlankLine2       guibg=#1f232c
    highlight IndentBlankLine3       guibg=#21242c
    highlight IndentBlankLine4       guibg=#23262c
    highlight IndentBlankLine5       guibg=#26272c
    highlight IndentBlankLine6       guibg=#28292c
    highlight IndentBlankLine7       guibg=#2a2a2c
    highlight IndentBlankLine8       guibg=#2c2c2c
    highlight IndentBlankLineContext guibg=#506591  guifg=#506591
    " highlight GitSignsAddLn          guibg=#608b4e  guifg=#d4d4d4
    " highlight GitSignsAddNr          guibg=#608b4e  guifg=#d4d4d4
    " highlight GitSignsChangeLn        guifg=#dcdcaa
    " highlight GitSignsChangeNr        guifg=#dcdcaa
    " highlight GitSignsDeleteLn       guibg=#d16969  guifg=#d4d4d4
    " highlight GitSignsDeleteNr       guibg=#d16969  guifg=#d4d4d4
    highlight GitSignsAdd            guifg=#608b4e
    highlight GitSignsChange          guifg=#dcdcaa
    highlight GitSignsDelete          guifg=#d16969
  endfunction

augroup colors
    autocmd!
    autocmd ColorScheme * call MyHighlights()
  augroup END

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
  autocmd FileType * setlocal formatoptions-=cro
  autocmd! User GoyoEnter Limelight
  autocmd! User GoyoLeave Limelight!
augroup END
