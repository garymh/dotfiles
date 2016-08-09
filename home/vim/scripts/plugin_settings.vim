" vim:fdm=marker

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
  " let g:indentLine_char = '░'
  " let g:indentLine_first_char = '▓'
  let g:indent_guides_start_level = 2
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_guide_size = 1
  let g:indent_guides_color_change_percent = 5
" }}} indentLine "

" vim-peekabo {{{ "
  let g:peekaboo_window = 'vertical topleft 50new'
" }}} vim-peekabo "

" vim-sayonara {{{ "
  let g:sayonara_confirm_quit = 1
" }}} vim-sayonara "

" Dash {{{ "
  nmap <silent> K <Plug>DashSearch
" }}} Dash "

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
  function! SearchWordWithAg()
    execute 'Ag' expand('<cword>')
  endfunction
  function! SearchVisualSelectionWithAg() range
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    let old_clipboard = &clipboard
    set clipboard&
    normal! ""gvy
    let selection = getreg('"')
    call setreg('"', old_reg, old_regtype)
    let &clipboard = old_clipboard
    execute 'Ag' selection
  endfunction
  command! Plugs call fzf#run({
  \ 'source':  map(sort(keys(g:plugs)), 'g:plug_home."/".v:val'),
  \ 'options': '--delimiter / --nth -1',
  \ 'down':    '~50%',
  \ 'sink':    'Explore'})
" }}} FZF settings "

" FZF commands {{{ "
  autocmd VimEnter * command! Colors
        \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'})
  nmap <leader><tab> <plug>(fzf-maps-n)
  fun! s:fzf_root()
          let path = finddir(".git", expand("%:p:h").";")
          return fnamemodify(substitute(path, ".git", "", ""), ":p:h")
  endfun

  nnoremap <silent> <c-p> :exe 'Files ' . <SID>fzf_root()<CR>
  " nnoremap <silent> <c-p> :Files<CR>

  nnoremap <silent> <c-e> :History<CR>
  nnoremap <silent> <space>r :History<CR>
  nnoremap <silent> <c-t> :Tags<CR>
  nnoremap <silent> <space>. :Lines<CR>
  nnoremap <silent> <space>; :BLines<CR>
  nnoremap <silent> <space>; :Commands<CR>
  nnoremap <silent> <space>a :Buffers<CR>
  nnoremap <silent> <space>d :call SearchWordWithAg()<CR>
  nnoremap <silent> <space>o :BTags<CR>
  nnoremap <silent> <space>t :Tags<CR>
  omap <leader><tab> <plug>(fzf-maps-o)
  vnoremap <silent> <space>d :call SearchVisualSelectionWithAg()<CR>
  xmap <leader><tab> <plug>(fzf-maps-x)
  " nnoremap <silent> <leader><space> :Files<CR>
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
  let g:tmux_navigator_no_mappings = 1
  nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
  nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
  nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
  nnoremap <silent> <M-l> :TmuxNavigateRight<cr>
  nnoremap <silent> <M-\> :TmuxNavigatePrevious<cr>
  nnoremap <silent> <tab> <c-w>w
" }}} Tmux "

" ctrlsf {{{ "
  let g:ctrlsf_winsize = '100%'
  nnoremap <space>f :CtrlSF<space>
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
  nnoremap <silent> <bs> :NERDTreeFind<cr>
  let g:NERDTreeQuitOnOpen = 1
  let g:NERDTreeShowHidden = 1
  let g:NERDTreeRespectWildIgnore = 1
  let g:NERDTreeDirArrows=1
  let g:NERDTreeMinimalUI=1
" }}} NERDtree "

