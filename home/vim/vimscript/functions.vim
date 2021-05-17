function! BreakHere()
  s/^\(\s*\)\(.\{-}\)\(\s*\)\(\%#\)\(\s*\)\(.*\)/\1\2\r\1\4\6
  call histdel('/', -1)
endfunction
command! BreakHere :call BreakHere()

function! GoogleSearch()
    let searchterm = substitute(join(split(getreg("g")),"+"),'"',"","g")
     silent! exec "silent! !open \"http://google.com/search?q=" . searchterm . "\" &"
endfunction

function! LuckySearch()
     let searchterm = substitute(join(split(getreg("g")),"+"),'"',"","g")
    silent! exec "silent! !open \"https://duckduckgo.com/?q=\\!ducky+" . searchterm . "&ia=web\""
endfunction

" Edit my filetype/syntax plugin files for current filetype.
command! -nargs=? -complete=filetype EditFileTypeDetect
            \ exe 'keepj vsplit $DOTFILES/home/vim/ftdetect/' . (empty(<q-args>) ? &filetype : <q-args>) . '.vim'

command! -nargs=? -complete=filetype EditFileTypePlugin
            \ exe 'keepj vsplit $DOTFILES/home/vim/ftplugin/' . (empty(<q-args>) ? &filetype : <q-args>) . '.vim'

command! -bang -nargs=? -complete=dir Dotfiles
    \ call fzf#vim#files('$DOTFILES', {'options': ['--no-preview', '--info=inline']}, <bang>0)

" command! LuaFiles lua require("fzf-commands").files()
" command! Helptags lua require("fzf-commands").helptags()

" From http://got-ravings.blogspot.com/2008/07/vim-pr0n-visual-search-mappings.html

function! VisualStarSearchSet(cmdtype,...)
  let temp = @"
  normal! gvy
  if !a:0 || a:1 != 'raw'
    let @" = escape(@", a:cmdtype.'\*')
  endif
  let @/ = substitute(@", '\n', '\\n', 'g')
  let @/ = substitute(@/, '\[', '\\[', 'g')
  let @/ = substitute(@/, '\~', '\\~', 'g')
  let @/ = substitute(@/, '\.', '\\.', 'g')
  let @" = temp
endfunction

" replace vim's built-in visual * and # behavior
xnoremap * :<C-u>call VisualStarSearchSet('/')<CR>/<C-R>=@/<CR><CR>N
xnoremap # :<C-u>call VisualStarSearchSet('?')<CR>?<C-R>=@/<CR><CR>n

" recursively vimgrep for word under cursor or selection
if maparg('<leader>*', 'n') == ''
  nnoremap <leader>* :execute 'noautocmd vimgrep /\V' . substitute(escape(expand("<cword>"), '\'), '\n', '\\n', 'g') . '/ **'<CR>
endif
if maparg('<leader>*', 'v') == ''
  vnoremap <leader>* :<C-u>call VisualStarSearchSet('/')<CR>:execute 'noautocmd vimgrep /' . @/ . '/ **'<CR>
endif

 xnoremap * :<C-U>call VisualStarSearchSet('/')<CR>/<C-R>=@/<CR><CR>N
 xnoremap # :<C-U>call VisualStarSearchSet('?')<CR>?<C-R>=@/<CR><CR>n

function! BracketMotion(motion, count)
  if a:motion == "down"
    let l:bracket   = "}"
    let l:direction = "j"
    let l:commands  = "Wn"
  else
    let l:bracket   = "{"
    let l:direction = "k"
    let l:commands  = "Wnb"
  end

  if foldclosed(search('^$', l:commands)) == -1
    execute 'keepjumps norm! ' . a:count . l:bracket
  else
    execute 'keepjumps norm! ' . a:count . l:bracket . l:direction . l:bracket
  end
endfunction
