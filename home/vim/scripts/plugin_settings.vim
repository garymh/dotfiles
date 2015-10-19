" Airline {{{ "
  let g:airline#extensions#tabline#enabled       = 1
  let g:airline#extensions#tabline#show_tab_type = 1
  let g:airline#extensions#tabline#tab_min_count = 0
  let g:airline#extensions#tabline#tab_nr_type   = 2
  let g:airline_detect_crypt                     = 0
  let g:airline_exclude_preview                  = 1
  let g:airline_powerline_fonts                  = 0
  let g:airline_theme                            = 'hybridline'

  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

  " let g:airline_left_sep = '»'
  " let g:airline_left_sep = '▶'
  " let g:airline_right_sep = '«'
  " let g:airline_right_sep = '◀'
  let g:airline_left_sep  = '▓▒░'
  let g:airline_right_sep = '░▒▓'
  let g:airline_section_z = '%2p%% %2l/%L:%2v'
  let g:airline_symbols.crypt = '🔒'
  let g:airline_symbols.linenr = '↕'
  let g:airline_symbols.branch = ' 📖 '
  let g:airline_symbols.paste = 'ρ'
  let g:airline_symbols.whitespace = 'Ξ'
" }}} Airline "

" Git Gutter {{{ "
let g:gitgutter_sign_modified = '≈'

" }}} Git Gutter "

" CopyRTF {{{ "
  command! PrintToRTF call RTF()
  function! RTF()
    let colors_save = g:colors_name
    set background=light
    colorscheme base16-monokai
    CopyRTF
    set background=dark
    execute 'colorscheme' colors_save
  endfun
" }}} CopyRTF "

" Vim Oblique {{{ "
  autocmd! User Oblique       normal! zz
  autocmd! User ObliqueStar   normal! zz
  autocmd! User ObliqueRepeat normal! zz
" }}} Vim Oblique "

" Sideways.vim {{{ "
  nnoremap <silent> [<Tab> :SidewaysLeft<CR>
  nnoremap <silent> ]<Tab> :SidewaysRight<CR>

  omap aa <Plug>SidewaysArgumentTextobjA
  xmap aa <Plug>SidewaysArgumentTextobjA
  omap ia <Plug>SidewaysArgumentTextobjI
  xmap ia <Plug>SidewaysArgumentTextobjI
" }}} Sideways.vim "

" vim-peekabo {{{ "
  let g:peekaboo_window = 'vertical botright 50new'
" }}} vim-peekabo "

" Sayonara {{{ "
  let g:sayonara_confirm_quit = 1
" }}} Sayonara "

" Dash {{{ "
  nmap <silent> K <Plug>DashSearch
" }}} Dash "

" Surround.vim {{{ "
  " below stolen from YADR (@skwp)
  " <leader># Surround a word with #{ruby interpolation}
  map <leader># ysiw#
  vmap <leader># S#

  " <leader>" Surround a word with "quotes"
  map <leader>" ysiw"
  vmap <leader>" S"

  " <leader>' Surround a word with 'single quotes'
  map <leader>' ysiw'
  vmap <leader>' c'<C-R>"'<ESC>

  " <leader>) or <leader>( Surround a word with (parens)
  " The difference is in whether a space is put in
  map <leader>( ysiw(
  map <leader>) ysiw)
  vmap <leader>( c( <C-R>" )<ESC>
  vmap <leader>) c(<C-R>")<ESC>

  " <leader>[ Surround a word with [brackets]
  map <leader>] ysiw]
  map <leader>[ ysiw[
  vmap <leader>[ c[ <C-R>" ]<ESC>
  vmap <leader>] c[<C-R>"]<ESC>

  " <leader>{ Surround a word with {braces}
  map <leader>} ysiw}
  map <leader>{ ysiw{
  vmap <leader>} c{ <C-R>" }<ESC>
  vmap <leader>{ c{<C-R>"}<ESC>

  " <leader>- and <leader>= for ERB
  map <leader>e- ysil-
  map <leader>e= ysil=
  vmap <leader>e- S-
  vmap <leader>e= S=

  let g:surround_113 = "#{\r}"
  let g:surround_35  = "#{\r}"
  let g:surround_45  = "<% \r %>"
  let g:surround_61  = "<%= \r %>"
" }}} Surround.vim "

" Switch {{{ "
  nnoremap <silent> - :Switch<CR>
" }}} Switch "

" SplitJoin {{{ "
  function! BreakHere()
    s/\(.\{-}\)\(\s*\)\(\%#\)\(\s*\)\(.*\)/\1\r\3\5
    call histdel("/", -1)
  endfunction

  nnoremap <silent> sk :SplitjoinSplit<CR>
  nnoremap <silent> sj :SplitjoinJoin<CR>
  nnoremap <silent> J mzJ`z
  nnoremap <silent> S :call BreakHere()<CR>
" }}} SplitJoin "

" CTRL-P {{{ "
  if has('nvim')
    let $FZF_DEFAULT_OPTS .= ' --inline-info'
  endif
  nnoremap <silent> <c-p> :Files<CR>
  nnoremap <silent> <c-e> :History<CR>
  nnoremap <silent> <c-t> :Tags<CR>

  " nnoremap <silent> <leader><space> :Files<CR>
" nnoremap <silent> <leader>a :Buffers<CR>
" nnoremap <silent> <leader>; :BLines<CR>
" nnoremap <silent> <leader>. :Lines<CR>
" nnoremap <silent> <leader>o :BTags<CR>
" nnoremap <silent> <leader>O :Tags<CR>
" nnoremap <silent> <leader>: :Commands<CR>
" nnoremap <silent> <leader>? :History<CR>
" nnoremap <silent> K :call SearchWordWithAg()<CR>
" vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>

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


" }}} CTRL-P "

" Testing {{{ "
    let g:rubytest_cmd_test = "zeus test %p"
    let g:rubytest_cmd_testcase = "zeus test %p -n '/%c/'"
    " let g:rubytest_in_quickfix = 1
  " let g:test#strategy = 'vimux'
  " nmap <silent> <leader>t :TestNearest<CR>
  " nmap <silent> <leader>T :TestFile<CR>
  " nmap <silent> <leader>a :TestSuite<CR>
  " nmap <silent> <leader>l :TestLast<CR>
  " nmap <silent> <leader>g :TestVisit<CR>
  " let test#ruby#minitest#executable = 'm'
" }}} Testing "

" EasyAlign {{{ "
  vmap <Enter> <Plug>(EasyAlign)
  nmap <Leader>aa <Plug>(EasyAlign)ii<CR>
  let g:easy_align_delimiters = {
        \ '>': { 'pattern': '>>\|=>\|>' },
        \ '\': { 'pattern': '\\' },
        \ '/': { 'pattern': '//\+\|/\*\|\*/', 'delimiter_align': 'l', 'ignore_groups': ['!Comment'] },
        \ ']': {
        \     'pattern':       '[[\]]',
        \     'left_margin':   0,
        \     'right_margin':  0,
        \     'stick_to_left': 0
        \   },
        \ ')': {
        \     'pattern':       '[()]',
        \     'left_margin':   0,
        \     'right_margin':  0,
        \     'stick_to_left': 0
        \   },
        \ 'f': {
        \     'pattern': ' \(\S\+(\)\@=',
        \     'left_margin': 0,
        \     'right_margin': 0
        \   },
        \ 'd': {
        \     'pattern': ' \(\S\+\s*[;=]\)\@=',
        \     'left_margin': 0,
        \     'right_margin': 0
        \   }
        \ }
" }}} EasyAlign "

" Tmux {{{ "
  " let g:tmux_navigator_no_mappings = 1
  nnoremap <silent> <C-w>h :TmuxNavigateLeft<cr>
  nnoremap <silent> <C-w>j :TmuxNavigateDown<cr>
  nnoremap <silent> <C-w>k :TmuxNavigateUp<cr>
  nnoremap <silent> <C-w>l :TmuxNavigateRight<cr>
  nnoremap <C-i> g;
  nnoremap <C-o> g,
  " nnoremap <silent> <tab> :TmuxNavigatePrevious<cr>
  " nnoremap <tab>   <c-w>w
  nnoremap <S-tab> <c-w>W
" }}} Tmux "

" Multiple Cursors {{{ "
  vnoremap <Leader>v :MultipleCursorsFind <C-R><C-W><CR>
  nnoremap <Leader>v :MultipleCursorsFind <C-R><C-W><CR>
" }}} Multiple Cursors "

" Ruby/Rubocop {{{ "
  let g:vimrubocop_rubocop_extra_args = "aR"
  let g:rails_projections = {
        \ "config/routes.rb": { "command": "routes" }
        \ }
" }}} Ruby/Rubocop "

" Quickfix Toggle {{{ "
  let g:toggle_list_no_mappings = 1
  " nmap <script> <silent> <leader>l :call ToggleLocationList()<CR>
  nmap <script> <silent> qf :call ToggleQuickfixList()<CR>
  nmap <script> <silent> qq :call ToggleQuickfixList()<CR>
" }}} Quickfix Toggle "

" ctrlsf {{{ "
  " let g:ags_agexe = 'ag --nocolor'
  " nmap <script> <silent> qs :CtrlSFToggle<CR>
  nnoremap <space>f :CtrlSF<space>
  let g:ctrlsf_position = 'right'
  let g:ctrlsf_indent = 1
  let g:ctrlsf_mapping = {
      \ "next": "n",
      \ "prev": "N",
      \ }
" }}} ctrlsf "

" Identline {{{ "
  " let g:indentLine_color_term = 239
  " let g:indentLine_color_gui = '#09AA08'
  " let g:indentLine_char = '│'
  " let g:indentLine_fileTypeExclude = ['help', 'text', 'agsv']
  " let g:indent_guides_color_change_percent  = 2
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_exclude_filetypes     = ['help', 'diff', 'nerdtree']
" }}} Identline "

" NERDtree {{{ "
  nnoremap <f1> :NERDTreeToggle<cr>
  let g:NERDTreeQuitOnOpen = 1
  let g:NERDTreeShowHidden = 1
  let g:NERDTreeRespectWildIgnore = 1
  let g:NERDTreeDirArrows=1
  let g:NERDTreeMinimalUI=1

" }}} NERDtree "

" custom text objects {{{ "
  xmap q iq
  omap q iq
" }}} custom text objects "
