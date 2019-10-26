" vim:fdm=marker

" ale? {{{ "

" }}} ale? "
" let g:ale_linters = {
"       \   'ruby': ['standardrb', 'rubocop'],
"       \   'javascript': ['eslint'],
"       \}
" let g:ale_fixers = {
"       \    'ruby': ['standardrb'],
"       \}
" nmap <silent> [e <Plug>(ale_previous_wrap)
" nmap <silent> ]e <Plug>(ale_next_wrap)

" hexokinase {{{ "
  let g:Hexokinase_optInPatterns = ['full_hex', 'triple_hex', 'rgb', 'rgba', 'colour_names']
  let g:Hexokinase_ftAutoload = ['*']
" }}} hexokinase "

" tagbar {{{ "
  let g:tagbar_compact = 1
" }}} tagbar "

" vim-which-key {{{ "
let g:mapleader = ","
let g:maplocalleader = '\'
let g:which_key_use_floating_win = 1
nnoremap <silent> <leader>      :<c-u>WhichKey ','<CR>
nnoremap <silent> <space>       :<c-u>WhichKey '<space>'<CR>
" let g:which_key_map =  {}
nnoremap <silent> <localleader> :<c-u>WhichKey '\'<CR>
" call which_key#register(',', "g:which_key_map")
" let g:which_key_map.f = { 'name' : '+file' }
" call which_key#register('<space>', "g:which_key_map")
" let g:which_key_map.y = { 'name' : 'lo :)' }
" call which_key#register('\', "g:which_key_map")
" let g:which_key_map.y = { 'name' : 'hmm' }

" autocmd! FileType which_key
" autocmd  FileType which_key set laststatus=0 noshowmode noruler
"   \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
" }}} vim-which-key "

" lightline {{{ "
  function! LightlineModified()
    let map = { 'V': 'n', "\<C-v>": 'n', 's': 'n', 'v': 'n', "\<C-s>": 'n', 'c': 'n', 'R': 'n'}
    let mode = get(map, mode()[0], mode()[0])
    let bgcolor = {'n': [240, '#585858'], 'i': [31, '#0087af']}
    let color = get(bgcolor, mode, bgcolor.n)
    exe printf('hi ModifiedColor ctermfg=196 ctermbg=%d guifg=#ff0000 guibg=%s term=bold cterm=bold',
          \ color[0], color[1])
    return &modified ? '+' : &modifiable ? '' : '-'
  endfunction

  function! LightlineReadonly()
    return &readonly ? '' : ''
  endfunction

  function! LightlineFugitive()
    if &ft !~? 'vimfiler' && exists('*fugitive#head')
      let branch = fugitive#head()
      return branch !=# '' ? ' '.branch : ''
    endif
    return ''
  endfunction

  let g:tagbar_status_func = 'TagbarStatusFunc'

  function! TagbarStatusFunc(current, sort, fname, ...) abort
      let g:lightline.fname = a:fname
    return lightline#statusline(0)
  endfunction

  set showtabline=2
  let g:lightline = {
        \ 'component': {
        \   'modified': '%#ModifiedColor#%{LightlineModified()}'
        \ },
        \ 'separator': { 'left': ' ', 'right': ' ' },
        \ 'subseparator': { 'left': ' ', 'right': ' ' },
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'fugitive': 'LightlineFugitive',
        \   'filename': 'LightlineFilename',
        \   'readonly': 'LightlineReadonly',
        \ }
        \ }
  let g:lightline#bufferline#enable_devicons = 1
  let g:lightline#bufferline#filename_modifier = ':t'
  let g:lightline#bufferline#unicode_symbols = 1
  let g:lightline#bufferline#read_only = ''
  let g:lightline.colorscheme = 'ayu_mirage'
  let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
  let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
  let g:lightline.component_type   = {'buffers': 'tabsel'}
" }}} lightline "

" multichange {{{ "
  let g:multichange_mapping        = 'sm'
  let g:multichange_motion_mapping = 'm'
" }}} multichange "

" vim-slime {{{ "
  let g:slime_target = "tmux"
  let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}
" }}} vim-slime "

" DidYouMean {{{ "
  let g:dym_use_fzf = 1
" }}} DidYouMean "

" Rainbow Parens {{{ "
  if exists(':RainbowParentheses')
    let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
    augroup rainbow_lisp
      autocmd!
      autocmd FileType * RainbowParentheses
    augroup END
  endif
" }}} Rainbow Parens "

" vim-slash {{{ "
  noremap <plug>(slash-after) zz
" }}} vim-slash "

" better whitespace {{{ "
  let g:better_whitespace_enabled=1
  let g:strip_whitespace_on_save=1
  let g:strip_whitespace_confirm=0
  let g:better_whitespace_filetypes_blacklist = ['diff', 'gitcommit', 'qf', 'help', 'markdown', 'vim-plug']
" }}} better whitespace "

" vim polygot individual settings {{{ "
  let g:vim_json_syntax_conceal = 0
" }}} vim polygot individual settings "

" Neoformat {{{ "
  let g:neoformat_basic_format_align = 1
  let g:neoformat_basic_format_retab = 1
  let g:neoformat_basic_format_trim = 1
  let g:neoformat_enabled_ruby = ['rubocop']
  let g:neoformat_enabled_scss = ['csscomb']
" }}} Neoformat "

" vim-surround {{{ "
  let g:surround_{char2nr("d")} = "<div\1class: \r..*\r class=\"&\"\1>\r</div>"
  if !exists('b:erb_loaded')
    let b:surround_{char2nr('i')} = "if \1if: \1 \r end"
    let b:surround_{char2nr('u')} = "unless \1unless: \1 \r end"
    let b:surround_{char2nr('w')} = "while \1while: \1 do \r end"
    let b:surround_{char2nr('e')} = "\1collection: \1.each do |\2item: \2| \r end"
    let b:surround_{char2nr('m')} = "module \r end"
    let b:surround_{char2nr('d')} = "do\n \r end"
  endif

  let b:surround_{char2nr('#')} = "#{\r}"
  let b:surround_indent = 1
" }}} vim-surround "

" Sideways {{{ "
  omap aa <Plug>SidewaysArgumentTextobjA
  xmap aa <Plug>SidewaysArgumentTextobjA
  omap ia <Plug>SidewaysArgumentTextobjI
  xmap ia <Plug>SidewaysArgumentTextobjI
" }}} Sideways "

" Text objects {{{ "
  let g:textobj_comment_no_default_key_mappings = 1
  omap ib <Plug>(textobj-brace-i)
  omap ab <Plug>(textobj-brace-a)
  " Define a text object for block arguments (do |...|)  thx @AndrewRadev
  onoremap <buffer> i\| :<c-u>normal! T\|vt\|<cr>
  xnoremap <buffer> i\| :<c-u>normal! T\|vt\|<cr>
  onoremap <buffer> a\| :<c-u>normal! F\|vf\|<cr>
  xnoremap <buffer> a\| :<c-u>normal! F\|vf\|<cr>
" }}} Text objects "

" Airline {{{ "
  " let g:airline#extensions#tabline#enabled = 1
  " let g:airline#extensions#tabline#fnamemod = ':t'
  " let g:airline#extensions#tabline#fnametruncate = 10
  " let g:airline#extensions#neomake#enabled = 1
  " let g:airline#extensions#nrrwrgn#enabled = 1
  " let g:airline#extensions#csv#enabled = 1

  " if !exists('g:airline_symbols')
  "   let g:airline_symbols = {}
  " endif

  " " unicode symbols
  " let g:airline_left_sep       = ''
  " let g:airline_right_sep      = ''
  " let g:airline_symbols.crypt  = '🔒'
  " let g:airline_section_z      = '%2l/%L:%2v'
  " let g:airline_symbols.branch = 'ᚬ'
" }}} Airline "

" ragtag {{{ "
  let g:ragtag_global_maps = 1
" }}} ragtag "

" indentLine {{{ "
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_start_level           = 1
  let g:indent_guides_guide_size            = 1
  let g:indent_guides_exclude_filetypes = ['help', 'netrw', 'fzf']
" }}} indentLine "

" vim-pasta {{{ "
  let g:pasta_disabled_filetypes = ['netrw', 'dirvish']
" }}} vim-pasta "

" vim-sayonara {{{ "
  let g:sayonara_confirm_quit = 1
" }}} vim-sayonara "

" Switch {{{ "
  let g:switch_custom_definitions =
    \ [
    \   ['assert', 'refute']
    \ ]
" }}} Switch "

" SplitJoin {{{ "
  let g:splitjoin_align = 1

  function! BreakHere()
    s/\(.\{-}\)\(\s*\)\(\%#\)\(\s*\)\(.*\)/\1\r\3\5
    call histdel("/", -1)
  endfunction
" }}} SplitJoin "

" FZF settings {{{ "
  " FZF commands {{{ "
    function! s:fzf_root()
      let path = finddir(".git", expand("%:p:h").";")
      return fnamemodify(substitute(path, ".git", "", ""), ":p:h")
    endfun

    function! s:build_quickfix_list(lines)
      call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
      copen
      cc
    endfunction
    nmap <silent> <c-p> :exe 'Files! ' . <SID>fzf_root()<CR>

    let g:fzf_action = {
      \ 'ctrl-q': function('s:build_quickfix_list'),
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }

    command! -bang -nargs=? -complete=dir Files
          \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

    command! -bang -nargs=* Rg
          \ call fzf#vim#grep(
          \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
          \   <bang>0 ? fzf#vim#with_preview('up:60%')
          \           : fzf#vim#with_preview('right:50%:hidden', '?'),
          \   <bang>0)

    command! -bang -nargs=? -complete=dir Buffers
          \ call fzf#vim#buffers(<q-args>, fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)

  " }}} FZF commands "
" }}} FZF settings "

" Testing {{{ "
  let test#strategy = "vimux"
  let g:VimuxOrientation = "v"
  let test#ruby#rails#options = {
  \ 'all':   '-f -p'
\}
" }}} Testing "

" git-gutter {{{ "
  " let g:gitgutter_sign_added= '█'
  " let g:gitgutter_sign_modified= '█'
  " let g:gitgutter_sign_removed= '█'
  " let g:gitgutter_sign_removed_first_line= '█'
  " let g:gitgutter_sign_modified_removed= '█'
  let g:gitgutter_sign_added= "·"
  let g:gitgutter_sign_modified= "·"
  let g:gitgutter_sign_removed= "·"
  let g:gitgutter_sign_removed_first_line= "·"
  let g:gitgutter_sign_modified_removed= "·"
" }}} git-gutter "

" ctrlsf {{{ "
  let g:ctrlsf_ackprg = '/usr/local/bin/rg'
  let g:ctrlsf_search_mode = 'async'
  let g:ctrlsf_indent = 2
  let g:ctrlsf_mapping = {
        \ "next": "n",
        \ "prev": "N",
        \ }
  function! g:CtrlSFAfterMainWindowInit()
    setl nonumber norelativenumber
  endfunction

  let g:ctrlsf_auto_focus = {
      \ "at" : "done",
      \ "duration_less_than": 1000
      \ }
" }}} ctrlsf "

" Dirvish {{{ "
  let g:loaded_netrwPlugin = 1
  command! -nargs=? -complete=dir Explore Dirvish <args>
  command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
  command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>
" }}} Dirvish "
