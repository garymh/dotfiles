" vim:fdm=marker

" vim-slash {{{ "
noremap <plug>(slash-after) zz
" }}} vim-slash "

" vim polygot individual settings {{{ "
  let g:vim_json_syntax_conceal = 0
  " Requires 'jq' (brew install jq)
  function! s:PrettyJSON()
    %!jq .
    set filetype=json
  endfunction
  command! PrettyJSON :call <sid>PrettyJSON()
" }}} vim polygot individual settings "

" Arpeggio {{{ "
  call arpeggio#map('i', '', 0, 'jk', '<Esc>')
  call arpeggio#map('i', '', 0, 'fj', '<Esc>')
" }}} Arpeggio "

" neomake {{{ "
let g:neomake_list_height = 2
let g:neomake_open_list = 2
let g:neomake_verbose = 3
" let g:neomake_javascript_eslint_exe = './node_modules/.bin/eslint_d'
" let g:neomake_javascript_enabled_makers = ['eslint']
" autocmd! BufWritePost *.js silent! Neomake
" https://www.reddit.com/r/neovim/comments/50678h/switched_to_neovim_asking_tips_about_javascript/
" }}} neomake "

" vim-surround {{{ "
  nmap s  <Plug>Ysurround
  xmap s  <Plug>VSurround
  xmap S  <Plug>VgSurround
  let g:surround_{char2nr("d")} = "<div\1id: \r..*\r id=\"&\"\1>\r</div>"

  let [s:single_quote, s:double_quote, s:no_match] = [1,2,0]
  function! SurroundRequote()
    let matched_quote = s:no_match
    let [column, line] = [virtcol('.'), getline('.')]
    let offset = 1
    while offset < 30
      let matched_quote = s:QuoteStyle(line, column, offset)
      if matched_quote
        call s:SwapSurroundingQuotes(matched_quote)
        break
      endif
      let offset += 1
    endwhile
  endfunction

  function! s:SwapSurroundingQuotes(current_quote)
    if a:current_quote != s:single_quote && a:current_quote != s:double_quote
      return
    endif
    call s:CacheCursorLocation()
    let quote_sequence = a:current_quote == s:single_quote ? "'\"" : "\"'"
    execute "normal cs" . quote_sequence
    call s:RestoreCursorLocation()
  endfunction

  function! s:QuoteStyle(line, column, offset)
    let left_character = a:line[a:column - a:offset - 1]
    let right_character = a:line[a:column + a:offset - 1]
    if left_character == "'" || right_character == "'"
      return s:single_quote
    elseif left_character == '"' || right_character == '"'
      return s:double_quote
    endif
    return s:no_match
  endfunction

  function! s:CacheCursorLocation()
    execute "normal mm"
  endfunction

  function! s:RestoreCursorLocation()
    execute "normal `m"
  endfunction

  nmap <leader>c' :call SurroundRequote()<cr>
" }}} vim-surround "

" system copy {{{ "
  nmap cpp cP
  noremap <Leader>y "*y
  noremap <Leader>p "*p
  noremap <Leader>Y "+y
  noremap <Leader>P "+p
" }}} system copy "

" Sideways {{{ "
  nnoremap [<Tab> :SidewaysLeft<cr>
  nnoremap ]<Tab> :SidewaysRight<cr>
  omap aa <Plug>SidewaysArgumentTextobjA
  xmap aa <Plug>SidewaysArgumentTextobjA
  omap ia <Plug>SidewaysArgumentTextobjI
  xmap ia <Plug>SidewaysArgumentTextobjI
" }}} Sideways "

" Text objects {{{ "
	let g:textobj_comment_no_default_key_mappings = 1
	xmap ax <Plug>(textobj-comment-a)
	omap ax <Plug>(textobj-comment-a)
	xmap aX <Plug>(textobj-comment-big-a)
	omap aX <Plug>(textobj-comment-big-a)
	xmap ix <Plug>(textobj-comment-i)
	omap ix <Plug>(textobj-comment-i)
	xmap iX <Plug>(textobj-comment-big-i)
	omap iX <Plug>(textobj-comment-big-i)
" }}} Text objects "

" Airline {{{ "
  let g:airline#extensions#tabline#enabled = 1
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

  " unicode symbols
  let g:airline_left_sep       = ''
  let g:airline_right_sep      = ''
  let g:airline_symbols.crypt  = '🔒'
  let g:airline_section_z      = '%2l/%L:%2v'
  let g:airline_symbols.branch = ''
" }}} Airline "

" ragtag {{{ "
  let g:ragtag_global_maps = 1
" }}} ragtag "

" indentLine {{{ "
  let g:indentLine_showFirstIndentLevel = 1
  let g:indentLine_faster = 1
" }}} indentLine "

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
  let g:fzf_layout = { 'window': '-tabnew' }
  let g:fzf_tags_command = 'ctags -R'
" }}} FZF settings "

" FZF commands {{{ "
  fun! s:fzf_root()
          let path = finddir(".git", expand("%:p:h").";")
          return fnamemodify(substitute(path, ".git", "", ""), ":p:h")
  endfun

  command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('up:40%'), <bang>0)

  command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
    \   <bang>0 ? fzf#vim#with_preview('up:60%')
    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    \   <bang>0)

  nnoremap <silent> <space>r :History<CR>
  nnoremap <silent> <space>a :Buffers<CR>
  nnoremap <silent> <space>o :BTags<CR>
  nnoremap <silent> <space>t :Tags<CR>
  nnoremap <silent> <space>g :GFiles?<CR>

  " find file in git repo
  function! ChooseFile()
    let dir = expand("%:h")
    if empty(dir) | let dir = getcwd() | endif

    let root = system("cd " . dir . " && git rev-parse --show-toplevel")
    if v:shell_error != 0 | echo "Not in a git repo" | return | endif
    let root = root[0:-2]

    let selection = system("cd " . root . " && git ls-files -co --exclude-standard | choose")
    if empty(selection) | echo "Canceled" | return | end

    echo "Finding file..."
    exec ":e " . root . "/" . selection
  endfunction

  if has('nvim')
    nnoremap <silent> <c-p> :exe 'Files ' . <SID>fzf_root()<CR>
  else
    nnoremap <silent> <c-p> :call ChooseFile()<cr>
  endif
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
  vmap <cr> <Plug>(EasyAlign)
" }}} EasyAlign "

" ctrlsf {{{ "
  let g:ctrlsf_ackprg = '/usr/local/bin/rg'
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
  let g:NERDTreeShowBookmarks     = 1
" }}} NERDtree "
