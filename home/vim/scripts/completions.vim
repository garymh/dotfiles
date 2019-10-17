set completeopt=menuone,preview,noinsert,noselect
set shortmess+=c   " Shut off completion messages
set complete-=i

let g:ulti_expand_or_jump_res = 0
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#completion_delay = 50
let g:mucomplete#reopen_immediately = 0
let g:mucomplete#always_use_completeopt = 1
let g:LanguageClient_useFloatingHover=1
let g:LanguageClient_hoverPreview='Always'
" set completefunc=LanguageClient#complete
" set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()

let g:LanguageClient_serverCommands = {
    \ 'javascript': ["/usr/local/bin/javascript-typescript-stdio"],
    \ 'css': ['css-languageserver', '--stdio'],
    \ 'less': ['css-languageserver', '--stdio'],
    \ 'scss': ['css-languageserver', '--stdio'],
    \ 'ruby': ["$GEM_HOME/bin/solargraph", "stdio"],
    \ 'erb': ["$GEM_HOME/bin/solargraph", "stdio"],
    \ 'vim': ["vim-language-server", "--stdio"]
    \ }

" TAB STUFF {{{ "
  fun! MyTabAction()
    return g:ulti_expand_or_jump_res ? "" : "\<plug>(MyFwd)"
  endf

  imap <plug>(MyFwd) <plug>(MUcompleteFwd)
  inoremap <plug>(TryUlti) <c-r>=UltiSnips#ExpandSnippetOrJump()<cr>
  imap <expr> <silent> <plug>(TryMUcomplete) MyTabAction()
  imap <expr> <silent> <tab> "\<plug>(TryUlti)\<plug>(TryMUcomplete)"

  let g:UltiSnipsExpandTrigger = "<f5>"        " Do not use <tab>
  let g:UltiSnipsJumpForwardTrigger = "<c-b>"  " Do not use <c-j>
" }}} TAB STUFF "

let g:mucomplete#chains = {}
let g:mucomplete#chains.default    = ['path', 'omni', 'keyn', 'dict', 'uspl', 'ulti']
let g:mucomplete#chains.markdown   = ['path', 'keyn', 'dict', 'uspl']
" let g:mucomplete#chains.vim      = ['path', 'keyn', 'dict', 'uspl']
let g:mucomplete#chains.text       = ['path', 'keyn', 'dict', 'uspl']
let g:mucomplete#chains.javascript = ['path', 'keyn', 'dict', 'uspl', 'ulti']

let g:mucomplete#can_complete = {}
let g:mucomplete#can_complete.default = {
  \  'omni': { t -> strlen(&l:omnifunc) > 0 && t =~# '\%(\k\.\)$' }
  \ }

" let g:mucomplete#chains = {
"   \ 'default' : ['path', 'ulti', 'omni', 'keyn', 'dict', 'uspl'],
"   \ 'vim'     : ['path', 'omni', 'ulti', 'cmd', 'keyn'],
"   \ 'ruby'    : ['path', 'omni', 'ulti', 'tags', 'keyn'],
"   \ 'eruby'   : ['path', 'ulti', 'cmd', 'keyn']
"   \ }

function! s:Config()
  if has_key(g:LanguageClient_serverCommands, &filetype)
    if &filetype == 'reason'
      " Format selection with gq.
      setlocal formatexpr=LanguageClient#textDocument_rangeFormatting_sync()

      " <Leader>f -- Format buffer.
      nnoremap <buffer> <silent> <Leader>f :call LanguageClient_textDocument_formatting()<CR>
    endif

    " gd -- go to definition
    nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>

    " K -- lookup keyword
    nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<CR>

    if exists('+signcolumn')
      setlocal signcolumn=yes
    endif
  endif
endfunction

function! s:Bind()
  nnoremap <buffer> <silent> K :call LanguageClient#closeFloatingHover()<CR>
  nnoremap <buffer> <silent> <Esc> :call LanguageClient#closeFloatingHover()<CR>
endfunction

augroup WincentLanguageClientAutocmds
  autocmd!
  autocmd FileType * call s:Config()

  if has('nvim') && exists('*nvim_open_win')
    " Can use floating window.
    autocmd BufEnter __LanguageClient__ call s:Bind()
  endif
augroup END

augroup LanguageClient_config
    autocmd!
    autocmd User LanguageClientStarted setlocal signcolumn=yes
    autocmd User LanguageClientStopped setlocal signcolumn=auto
  augroup END
