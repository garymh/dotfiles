" vim:fdm=marker

" vim-surround {{{ "
  nmap s  <Plug>Ysurround
  xmap s  <Plug>VSurround
  xmap S  <Plug>VgSurround
  let g:surround_{char2nr("d")} = "<div\1id: \r..*\r id=\"&\"\1>\r</div>"
" }}} vim-surround "

" system copy {{{ "
  nmap cpp cP
  noremap <Leader>y "*y
  noremap <Leader>p "*p
  noremap <Leader>Y "+y
  noremap <Leader>P "+p
" }}} system copy "

" yankring {{{ "
  if has('nvim')
    map p <Plug>(miniyank-autoput)
    map P <Plug>(miniyank-autoPut)
    map <c-c> <Plug>(miniyank-cycle)
  endif
" }}} yankring "

" Sideways {{{ "
  nnoremap [<Tab> :SidewaysLeft<cr>
  nnoremap ]<Tab> :SidewaysRight<cr>
  omap aa <Plug>SidewaysArgumentTextobjA
  xmap aa <Plug>SidewaysArgumentTextobjA
  omap ia <Plug>SidewaysArgumentTextobjI
  xmap ia <Plug>SidewaysArgumentTextobjI
" }}} Sideways "

" Airline {{{ "
  let g:airline#extensions#tabline#enabled = 1
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  " unicode symbols
  let g:airline_left_sep      = ''
  let g:airline_right_sep     = ''
  let g:airline_symbols.crypt = '🔒'
  let g:airline_section_z = '%2p%% %2l/%L:%2v'
" }}} Airline "

" ragtag {{{ "
  let g:ragtag_global_maps = 1
" }}} ragtag "

" indentLine {{{ "
  let g:indent_guides_start_level           = 2
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_guide_size            = 1
  let g:indent_guides_color_change_percent  = 15
" }}} indentLine "

" vim-peekabo {{{ "
  let g:peekaboo_window = 'vertical topleft 50new'
  let g:peekaboo_delay  = 750
" }}} vim-peekabo "

" vim-sayonara {{{ "
  let g:sayonara_confirm_quit = 1
" }}} vim-sayonara "

" Switch {{{ "
  nnoremap <silent> - :Switch<CR>
" }}} Switch "

" SplitJoin {{{ "
  function! BreakHere()
    s/\(.\{-}\)\(\s*\)\(\%#\)\(\s*\)\(.*\)/\1\r\3\5
    call histdel("/", -1)
  endfunction
  nnoremap <silent> J mzJ`z
  nnoremap <silent> S :call BreakHere()<CR>
" }}} SplitJoin "

" FZF settings {{{ "
  if has('nvim')
    let $FZF_DEFAULT_OPTS .= ' --inline-info'
  endif
  let g:fzf_files_options =
        \ '--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"'
  let g:fzf_tags_command = 'ctags -R'
" }}} FZF settings "

" FZF commands {{{ "
  fun! s:fzf_root()
          let path = finddir(".git", expand("%:p:h").";")
          return fnamemodify(substitute(path, ".git", "", ""), ":p:h")
  endfun
  nnoremap <silent> <c-p> :exe 'Files ' . <SID>fzf_root()<CR>
  nnoremap <silent> <c-p> :Files<CR>
  nnoremap <silent> <space>r :History<CR>
  nnoremap <silent> <c-t> :Tags<CR>
  nnoremap <silent> <space>. :Lines<CR>
  nnoremap <silent> <space>; :BLines<CR>
  nnoremap <silent> <space>a :Buffers<CR>
  nnoremap <silent> <space>o :BTags<CR>
  nnoremap <silent> <space>t :Tags<CR>
" }}} FZF commands "

" Testing {{{ "
  let g:test#strategy = 'neovim'
  nmap <silent> <leader>t :TestNearest<CR>
  nmap <silent> <leader>T :TestFile<CR>
  nmap <silent> <leader>a :TestSuite<CR>
  nmap <silent> <leader>l :TestLast<CR>
  nmap <silent> <leader>g :TestVisit<CR>
" }}} Testing "

" EasyAlign {{{ "
  vmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
" }}} EasyAlign "

" Tmux {{{ "
  " let g:tmux_navigator_no_mappings = 1
  " nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
  " nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
  " nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
  " nnoremap <silent> <M-l> :TmuxNavigateRight<cr>
  " nnoremap <silent> <M-\> :TmuxNavigatePrevious<cr>
  nnoremap <silent> <tab> <c-w>w
" }}} Tmux "

" ctrlsf {{{ "
  let g:ctrlsf_winsize = '100%'
  nmap <space>f <Plug>CtrlSFPrompt
  vmap F <Plug>CtrlSFVwordExec
  let g:ctrlsf_indent = 1
  let g:ctrlsf_mapping = {
      \ "next": "n",
      \ "prev": "N",
      \ }
  function! g:CtrlSFAfterMainWindowInit()
      setl wrap
      setl nonumber norelativenumber
  endfunction
" }}} ctrlsf "

" NERDtree {{{ "
  nnoremap <silent> <f1> :NERDTreeToggle<cr>
  nnoremap <silent> <bs><bs> :NERDTreeFind<cr>
  let g:NERDTreeQuitOnOpen        = 1
  let g:NERDTreeShowHidden        = 1
  let g:NERDTreeRespectWildIgnore = 1
  let g:NERDTreeDirArrows         = 0
  let g:NERDTreeMinimalUI         = 1
" }}} NERDtree "

