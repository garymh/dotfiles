" vim:fdm=marker

" Vim-plug {{{ "
  map <silent> <leader>ins :PlugInstall<cr>
  map <silent> <leader>upd :PlugUpdate<cr>
" }}} Vim-plug "

" unimpaired {{{ "
  map <space>[ <Plug>unimpairedBPrevious
  map <space>] <Plug>unimpairedBNext
" }}} unimpaired "

" buf-only {{{ "
  map <leader>b :Bonly<cr>
" }}} buf-only "

" fugitive {{{ "
  map <silent> <leader>gs :Gstatus<CR>
  map <leader>diff :<C-U>Git difftool %<cr>
" }}} fugitive "

" rubocop {{{ "
  map <leader>c :RuboCop -a<cr>q
" }}} rubocop "

" commentary {{{ "
  nmap <leader>dc :t.<CR>k<Plug>CommentaryLinej
" }}} commentary "

" DidYouMean {{{ "
  let g:dym_use_fzf = 1
" }}} DidYouMean "

" Rainbow Parens {{{ "
  let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
  augroup rainbow_lisp
    autocmd!
    autocmd FileType * RainbowParentheses
  augroup END
" }}} Rainbow Parens "

" vim-slash {{{ "
  noremap <plug>(slash-after) zz
" }}} vim-slash "

" ruby {{{ "
  let g:polyglot_disabled = ['ruby']
  let ruby_operators = 1
" }}} ruby "

" vim polygot individual settings {{{ "
  let g:vim_json_syntax_conceal = 0
" }}} vim polygot individual settings "

" Neoformat {{{ "
  " augroup fmt
  "   autocmd!
  "   autocmd BufWritePre * undojoin | Neoformat
  " augroup END
  let g:neoformat_basic_format_align = 1
  let g:neoformat_basic_format_retab = 1
  let g:neoformat_basic_format_trim = 1
  " let g:neoformat_only_msg_on_error = 1
  map <silent> ! :Neoformat<CR>
" }}} Neoformat "

" Multichange {{{ "
  " let g:multichange_mapping        = 'sm'
  " let g:multichange_motion_mapping = 'm'

nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)
nmap <leader>s <plug>(SubversiveSubvertRange)
xmap <leader>s <plug>(SubversiveSubvertRange)
nmap <leader>ss <plug>(SubversiveSubvertWordRange)
" nmap <leader><leader>ss <plug>(SubversiveSubvertWordRange)


" }}} Multichange "

" vim-surround {{{ "
  " nmap s  <Plug>Ysurround
  " xmap s  <Plug>VSurround
  " xmap S   <Plug>VgSurround
  let g:surround_{char2nr("d")} = "<div\1class: \r..*\r class=\"&\"\1>\r</div>"
" }}} vim-surround "

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

  omap ib <Plug>(textobj-brace-i)
  omap ab <Plug>(textobj-brace-a)
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
  let g:airline_symbols.branch = 'ᚬ'
" }}} Airline "

" ragtag {{{ "
  let g:ragtag_global_maps = 1
" }}} ragtag "

" indentLine {{{ "
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_start_level           = 1
  let g:indent_guides_guide_size            = 1
  let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'fzf']
" }}} indentLine "

" vim-sayonara {{{ "
  let g:sayonara_confirm_quit = 1
  nnoremap <silent>Q :Sayonara<cr>
    let g:sayonara_filetypes = {
        \ 'nerdtree': 'NERDTreeClose',
        \ }
" }}} vim-sayonara "

" Switch {{{ "
  nnoremap <silent> - :Switch<CR>
" }}} Switch "

" SplitJoin {{{ "
  nmap sj :SplitjoinSplit<cr>
  nmap sk :SplitjoinJoin<cr>
  let g:splitjoin_align = 1

  function! BreakHere()
    s/\(.\{-}\)\(\s*\)\(\%#\)\(\s*\)\(.*\)/\1\r\3\5
    call histdel("/", -1)
  endfunction
  nnoremap <silent> J mzJ`z
  nnoremap <silent> S :call BreakHere()<CR>
" }}} SplitJoin "

" FZF settings {{{ "
  " if has('nvim')
  "   let $FZF_DEFAULT_OPTS .= ' --inline-info'
  " endif
  " let g:fzf_layout = { 'window': '-tabnew' }
  " let g:fzf_tags_command = 'ctags -R'
  " }}} FZF settings "

  " FZF commands {{{ "
  fun! s:fzf_root()
    let path = finddir(".git", expand("%:p:h").";")
    return fnamemodify(substitute(path, ".git", "", ""), ":p:h")
  endfun

  let g:fzf_colors =
  \ { 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Clear'],
    \ 'hl':      ['fg', 'String'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }

  " does this work?
" :Ag foo
" :cdo %s/bar/baz/g | update 
" :cfdo :bd

    function! s:build_quickfix_list(lines)
      call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
      copen
      cc
    endfunction

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

  " nnoremap <silent> <space>f :Rg!<CR>
  nnoremap <silent> <space>r :History<CR>

  command! -bang -nargs=? -complete=dir Buffers
        \ call fzf#vim#buffers(<q-args>, fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)

nnoremap <silent> <space>a :Buffers<CR>

  nnoremap <silent> <space>g :GFiles?<CR>
  nnoremap <silent> <space>c :Commands<CR>
  nnoremap <silent> <space>h :Helptags<CR>

  noremap <silent> <space>1 :Files! app/controllers<CR>
  noremap <silent> <space>2 :Files! app/models<CR>
  noremap <silent> <space>3 :Files! app/views<CR>
  nnoremap <silent> <c-p> :exe 'Files! ' . <SID>fzf_root()<CR>
" }}} FZF commands "

" Testing {{{ "
  nmap <silent> <leader>t :TestNearest<CR>
  nmap <silent> <leader>T :TestFile<CR>
  nmap <silent> <leader>a :TestSuite<CR>
  nmap <silent> <leader>l :TestLast<CR>
  nmap <silent> <leader>g :TestVisit<CR>
  let test#strategy = "vimux"
  let g:VimuxOrientation = "v"
" }}} Testing "

" git-gutter {{{ "
  nmap <Leader>gu <Plug>GitGutterUndoHunk
  let g:gitgutter_sign_added= '■'
  let g:gitgutter_sign_modified= '■'
  let g:gitgutter_sign_removed= '■'
  let g:gitgutter_sign_removed_first_line= '■'
  let g:gitgutter_sign_modified_removed= '■'
" }}} git-gutter "

" EasyAlign {{{ "
  vmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
  vmap <cr> <Plug>(EasyAlign)
" }}} EasyAlign "

" ArgWrap {{{ "
  nnoremap <silent> <space><space> :ArgWrap<CR>
" }}} ArgWrap "

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

  let g:ctrlsf_auto_focus = {
      \ "at" : "done",
      \ "duration_less_than": 1000
      \ }
" }}} ctrlsf "

" NERDtree {{{ "
  nnoremap <silent> <f1> :NERDTreeToggle<cr>
nnoremap <silent> <C-_> :NERDTreeFind<cr>
  let g:NERDTreeQuitOnOpen        = 1
  let g:NERDTreeShowHidden        = 1
  let g:NERDTreeRespectWildIgnore = 1
  let g:NERDTreeDirArrows         = 0
  let g:NERDTreeMinimalUI         = 1
  let g:NERDTreeShowBookmarks     = 1
" }}} NERDtree "
