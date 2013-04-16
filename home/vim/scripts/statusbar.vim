if has('nvim')
  " Cool bubble design blatantly ripped off from @elenapan's brilliant dotfiles:
  " https://github.com/elenapan/dotfiles

  function! SetColors(dark, light, text) " {{{
    execute 'highlight BubbleLeft guifg=' . a:dark . ' guibg=bg'
    execute 'highlight BubbleInner1 guifg=' . a:text . ' guibg=' . a:dark
    execute 'highlight BubbleInner2 guifg=' . a:text . ' guibg=' . a:light
    execute 'highlight BubbleInner3 guifg=' . a:text . ' guibg=' . a:dark
    execute 'highlight BubbleRight guifg=' . a:light . ' guibg=bg'
  endfunction

  function! RedrawModeColors(mode)
    if a:mode == 'n'
      call SetColors('#4E6591', '#6582b9', "#ffffff")
    elseif a:mode == 'i'
      call SetColors('#e27878', '#e98989', "#ffffff")
    elseif a:mode == 'v' || a:mode == 'V' || a:mode == "\<C-V>"
      call SetColors('#E2A578', '#9F7455', "#ffffff")
    elseif a:mode == 'c'
      call SetColors('#B4BF82', '#616747', "#ffffff")
    elseif a:mode == 't'
      call SetColors('#A092C7', '#534C68', "#ffffff")
    endif
    return ''
  endfunction

  function! StatusBubble(text_color, text, ...)
    let background      = get(a:, 1, '#2c2c31')
    let highlight       = substitute(a:text,    '%l', 'StatusbarLineNumber', '')
    let highlight       = substitute(highlight, '(', '', 'g')
    let highlight       = substitute(highlight, ')', '', 'g')
    let highlight       = substitute(highlight, '{', '', 'g')
    let highlight       = substitute(highlight, '}', '', 'g')
    let highlight       = substitute(highlight, '%',  '', 'g')

    execute 'highlight ' . highlight . ' guifg=' . a:text_color . ' guibg=' . background
    execute 'highlight ' . highlight . 'Left guifg=' . background . ' guibg=bg'
    execute 'highlight ' . highlight . 'Right guifg=' . background . ' guibg=bg'

    return "%#" . highlight . "Left#\ %#" . highlight . "#" . a:text . "%#" . highlight . "Right#\"
  endfunction

  let g:plugin_filetypes = 'help\|unite\|vimfiler\|gundo'

  function! StatusbarReadonly()
    return &readonly ? '' : ''
  endfunction

  function! EeCheck()
    return match(expand('%:F'),'ee/') == -1 ? '' : 'EE'
  endfunction

  function! StatusbarFilename()
    return (StatusbarRawFilename() !=# '' ? (StatusbarRawFilename()) : 'newfile') .
          \ (StatusbarReadonly() !=# '' ? StatusbarReadonly() . ' ' : '')
  endfunction

  function! ModifiedCharacter()
    return "●"
  endfunction

  function! StatusbarBranch()
    let branch = ""
    if gitbranch#name() !=# ''
      if winwidth(0) > 70
        let branch = gitbranch#name()[0:15]
      else
        let branch = gitbranch#name()[0:5]
      endif
      return " " . branch
    else
      return ""
  endif
  endfunction

  function! LinterStatus() abort
      let l:counts = ale#statusline#Count(bufnr(''))

      let l:all_errors = l:counts.error + l:counts.style_error
      let l:all_non_errors = l:counts.total - l:all_errors

      return l:counts.total == 0 ? '✓' : printf(
      \   '%d %d ✖',
      \   all_non_errors,
      \   all_errors
      \)
  endfunction

  function! StatusbarRawFilename()
    return winwidth(0) < 90 ? expand('%:t') : expand('%')
  endfunction

  function! StatusbarFileencoding()
    return winwidth(0) > 70 && &ft !~# g:plugin_filetypes ? (strlen(&fenc) ? &fenc : &enc) : ''
  endfunction

  function! StatusbarFileformat()
    return WebDevIconsGetFileFormatSymbol() . '  '
  endfunction

  function! LspStatus() abort
    if luaeval('#vim.lsp.buf_get_clients() > 0')
      return luaeval("require('lsp-status').status()")
    endif

    return ''
  endfunction

  function! StatusbarCocStatus()
    return LspStatus()
  endfunction

  function! DrawStatusbar()
    let statusline = "%{RedrawModeColors(mode())}"
    let statusline .= StatusBubble('#000000', "%l", "#cccccc")

    let statusline .= "%#BubbleLeft#\ "
    let statusline .= "%#BubbleInner3#"
    let statusline .= '%{WebDevIconsGetFileTypeSymbol()?"":WebDevIconsGetFileTypeSymbol()}'"
    let statusline .= "%#BubbleInner3#\ %*"
    let statusline .= "%#BubbleInner3#\ %*"
    let statusline .= "%#BubbleInner2#\ "

    if EeCheck() == "EE"
      let statusline .= "%#EEHighlight#\ EE\ %#BubbleInner2#\ "
    endif

    let statusline .= "%{StatusbarFilename()}\ "
    let statusline .= "%#BubbleRight#\"

    if &modified
      let statusline .= StatusBubble('#ff0000', "%{ModifiedCharacter()}")
    endif

    if LinterStatus() == "✓"
      let statusline .= StatusBubble('#00ff00', "%{LinterStatus()}")
    else
      let statusline .= StatusBubble('#ff0000', "%{LinterStatus()}")
    endif

    if NearestMethodOrFunction() != ""
      let statusline .= StatusBubble('#d2d4de', "%{NearestMethodOrFunction()}()")
    endif

    if StatusbarFileformat() != "  " " I only care if the fileformat isn't my normal one
      let statusline .= StatusBubble('#ffffff', "%{StatusbarFileformat()}")
    endif

    if StatusbarFileencoding() != "utf-8" " I only care if this isn't utf-8
      let statusline .= StatusBubble('#E2A578', "%{StatusbarFileencoding()}")
    endif

    let statusline .= "%#Scrollbar#\  %{ScrollStatus()}"

    let statusline .= "%="

    if has('nvim') && StatusbarCocStatus() != ""
      let statusline .= StatusBubble('#00ffff', "%{StatusbarCocStatus()}")
    endif

    if StatusbarBranch() != ""
      let statusline .= StatusBubble('#859FC6', "%{StatusbarBranch()}")
    endif

    let statusline .= StatusBubble('#ffffff', "%{WincentRhs()}")

    let statusline .= "\ %*"

    return statusline
  endfunction

  function! WincentRhs() abort
    let l:rhs=''
    let l:column=virtcol('.')

    if winwidth(0) > 80
      let l:width=virtcol('$')
      let l:rhs.=' '
      let l:rhs.=l:column
      let l:rhs.='/'
      let l:rhs.=l:width

      if len(l:column) < 2
        let l:rhs.=' '
      endif
      if len(l:width) < 2
        let l:rhs.=' '
      endif
    else
      let l:rhs=l:column
    endif

    return l:rhs
  endfunction

  function! NearestMethodOrFunction() abort
    return get(b:, 'vista_nearest_method_or_function', '')
  endfunction

  function! StatusLineColors()
    setglobal laststatus=2

    hi BubbleEdge guifg=#ff0000 guibg=bg
    hi BubbleLeft guifg=#6582b9 guibg=bg
    hi BubbleLeft2 guifg=#7698d6 guibg=bg
    hi BubbleInner1 guifg=bg guibg=#6582b9
    hi BubbleInner2 guifg=bg guibg=#7698d6
    hi BubbleInner3 guifg=#ffffff guibg=#6582b9
    hi BubbleRight guifg=#7698d6 guibg=bg
    hi EEhighlight guifg=#ffffff guibg=#E2A478
    hi Scrollbar guifg=#52658E guibg=bg

    hi GreyInner guifg=#ffffff guibg=#2c2c31
    hi GreyBubbleLeft guifg=#2c2c31 guibg=bg
    hi GreyBubbleRight guifg=#2c2c31 guibg=bg

    set statusline=%!DrawStatusbar()
  endfunction

  call StatusLineColors()
else
  " https://dustri.org/b/lightweight-and-sexy-status-bar-in-vim.html
  set statusline=
  set statusline+=%#DiffAdd#%{(mode()=='n')?'\ \ NORMAL\ ':''}
  set statusline+=%#DiffChange#%{(mode()=='i')?'\ \ INSERT\ ':''}
  set statusline+=%#DiffDelete#%{(mode()=='r')?'\ \ RPLACE\ ':''}
  set statusline+=%#Cursor#%{(mode()=='v')?'\ \ VISUAL\ ':''}
  set statusline+=\ %n\         " buffer number
  set statusline+=%#Visual#     " colour
  set statusline+=%{&paste?'\ PASTE\ ':''}
  set statusline+=%{&spell?'\ SPELL\ ':''}
  set statusline+=%#CursorIM#   " colour
  set statusline+=%R            " readonly flag
  set statusline+=%M            " modified [+] flag
  set statusline+=%#Cursor#     " colour
  set statusline+=%#CursorLine# " colour
  set statusline+=\ %t\         " short file name
  set statusline+=%=            " right align
  set statusline+=%#CursorLine# " colour
  set statusline+=\ %Y\         " file type
  set statusline+=%#CursorIM#   " colour
  set statusline+=\ %3l:%-2c\   " line + column
  set statusline+=%#Cursor#     " colour
  set statusline+=\ %3p%%\      " percentage
endif
