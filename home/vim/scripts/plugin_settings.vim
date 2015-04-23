
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

" Commentary {{{ "
" map  gc  <Plug>Commentary
" nmap gcc <Plug>CommentaryLine
" nmap cgc <Plug>ChangeCommentary
" nmap gcu <Plug>Commentary<Plug>Commentary
" nmap <m-\> <Plug>CommentaryLine
" }}} Commentary "

" Completion & Snippets {{{ "
" let g:UltiSnipsListSnippets = "<C-g><Tab>"
let g:UltiSnipsExpandTrigger = "<Tab>"
let g:UltiSnipsJumpForwardTrigger = "<Tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

let g:ycm_filetype_blacklist = {
      \ 'qf' : 1,
      \ 'notes' : 1,
      \ 'markdown' : 1,
      \ }
" let g:ycm_complete_in_strings = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_key_list_select_completion = ['<Up>']
let g:ycm_key_list_previous_completion = ['<Down>']

" }}} Completion & Snippets "

" Airline {{{ "
let g:airline#extensions#tabline#enabled       = 1
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#tab_min_count = 0
let g:airline#extensions#tabline#tab_nr_type   = 2
let g:airline_exclude_preview                  = 1
let g:airline_powerline_fonts                  = 1
" let g:airline_left_sep='›'  " Slightly fancier than '>'
" let g:airline_right_sep='‹' " Slightly fancier than '<'
let g:airline_theme='gotham256'

" }}} Airline "

" Switch {{{ "
nnoremap <silent> - :Switch<CR>
" }}} Switch "

" SplitJoin {{{ "
" nnoremap sj :SplitjoinSplit<cr>
" nnoremap sk :SplitjoinJoin<cr>

function! s:try(cmd, default)
if exists(':' . a:cmd) && !v:count
  let tick = b:changedtick
  exe a:cmd
  if tick == b:changedtick
    execute 'normal! '.a:default
  endif
else
  execute 'normal! '.v:count.a:default
endif
endfunction

nnoremap <silent> sj :<C-U>call <SID>try('SplitjoinJoin', 'gJ')<CR>
nnoremap <silent>  J :<C-U>call <SID>try('SplitjoinJoin', 'mzJ`z')<CR>
nnoremap <silent> sk :SplitjoinSplit<CR>
nnoremap <silent>  S :<C-U>call <SID>try('SplitjoinSplit', "i\015")<CR>
" }}} SplitJoin "

" YUNOCommit {{{ "
let g:YUNOcommit_after = 20
" }}} YUNOCommit "

" CTRL-P {{{ "
" command! -nargs=1 Locate call fzf#run(
" \ {'source': 'locate <q-args>', 'sink': 'e', 'options': '-m'})

nnoremap <silent> <C-p> :FZF -m<CR>
" nmap <silent> <C-p> :CtrlP .<CR>
" let g:ctrlp_match_window_bottom   = 0
" let g:ctrlp_match_window_reversed = 0
" let g:ctrlp_abbrev = {
"       \ 'gmode': 't',
"       \ 'abbrevs': [
"       \   { 'pattern': '^a ', 'expanded': 'app/'            },
"       \   { 'pattern': '^b ', 'expanded': 'bin/'            },
"       \   { 'pattern': '^c ', 'expanded': 'app/controller/' },
"       \   { 'pattern': '^f ', 'expanded': 'config/'         },
"       \   { 'pattern': '^h ', 'expanded': 'app/helper/'     },
"       \   { 'pattern': '^l ', 'expanded': 'lib/'            },
"       \   { 'pattern': '^m ', 'expanded': 'app/model/'      },
"       \   { 'pattern': '^o ', 'expanded': 'log/'            },
"       \   { 'pattern': '^t ', 'expanded': 'test/'           },
"       \   { 'pattern': '^v ', 'expanded': 'app/views/'      },
"       \ ]}
" let g:ctrlp_open_new_file = 'r'
" let g:ctrlp_custom_ignore = {
" \ 'file': '\v\.(exe|so|dll|class)$',
" \ 'dir':  '\v<(\.git|\.hg|\.svn|\.vim|\.config)[\/]'
" \ }

" let g:ctrlp_cache_dir = $HOME."/.vim/tmp/cache/ctrlp"
" if !isdirectory(g:ctrlp_cache_dir) && exists("*mkdir")
"   call mkdir(g:ctrlp_cache_dir, "p", 0700)
" endif
" let g:ctrlp_extensions = [ "dir", "bookmarkdir" ]
" let g:ctrlp_user_command = 'ag %s --nocolor -l -g ""'

" }}} CTRL-P "

" Testing {{{ "
if has("nvim")
  let g:test#strategy = 'neovim'
else
  let g:test#strategy = 'dispatch'
endif
nnoremap <silent> <leader>t :TestNearest<CR>
nnoremap <silent> <leader>T :TestFile<CR>
nnoremap <silent> <leader>a :TestSuite<CR>
nnoremap <silent> <leader>l :TestLast<CR>
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

" Multiple Cursors {{{ "
vnoremap <Leader>v :MultipleCursorsFind <C-R><C-W><CR>
nnoremap <Leader>v :MultipleCursorsFind <C-R><C-W><CR>
" }}} Multiple Cursors "

" Ruby/Rubocop {{{ "
let g:vimrubocop_rubocop_extra_args = "aR"
let g:rails_projections = {
      \ "config/routes.rb": { "command": "routes" }
      \ }
let ruby_operators = 1
let ruby_space_errors = 1
" }}} Ruby/Rubocop "

" Whitespace {{{ "
let g:strip_whitespace_on_save = 1
let g:better_whitespace_enabled = 0
" }}} Whitespace "

" Projectionist {{{ "

let g:projectionist_heuristics = {
\   "*": {
\     "*.agsv": {"type": "doc", },
\ }
\ }

" }}} Projectionist "

" Semantic Highlights {{{ "
let g:semanticTermColors = [
      \ 28,
      \ 1,
      \ 2,
      \ 3,
      \ 4,
      \ 5,
      \ 6,
      \ 7,
      \ 178,
      \ 228,
      \ 87,
      \ 14,
      \ 13,
      \ 15,
      \ 122,
      \ 153,
      \ 126,
      \ 120,
      \ 189]
nnoremap <leader>t :SemanticHighlightToggle<cr>
let g:semanticUseCache = 1
let g:semanticPersistCache = 1
let g:semanticEnableFileTypes = ['ruby', 'vim']
" }}} Semantic Highlights "

" Rainbow Parentheses {{{ "
augroup parentheses
  autocmd!
  au VimEnter * RainbowParenthesesToggle
  au Syntax * RainbowParenthesesLoadRound
  au Syntax * RainbowParenthesesLoadSquare
  au Syntax * RainbowParenthesesLoadBraces
augroup END
" }}} Rainbow Parentheses "

" Quickfix Toggle {{{ "
let g:toggle_list_no_mappings = 1
" nmap <script> <silent> <leader>l :call ToggleLocationList()<CR>
nmap <script> <silent> qf :call ToggleQuickfixList()<CR>
nmap <script> <silent> qq :call ToggleQuickfixList()<CR>
" }}} Quickfix Toggle "

" Choosewin {{{ "
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W
" let g:choosewin_overlay_enable = 1
" nmap  <tab> :ChooseWin<CR>
"       let g:choosewin_color_overlay = {
" \ 'gui': ['DodgerBlue3', 'DodgerBlue3' ],
" \ 'cterm': [ 25, 25 ]
" \ }
" let g:choosewin_color_overlay_current = {
" \ 'gui': ['firebrick1', 'firebrick1' ],
" \ 'cterm': [ 124, 124 ]
" \ }

" let g:choosewin_blink_on_land      = 1 " dont' blink at land
" let g:choosewin_statusline_replace = 0 " don't replace statusline
" let g:choosewin_tabline_replace    = 0 " don't replace tabline
" }}} Choosewin "

" vim-ags {{{ "
let g:ags_agexe = 'ag --nocolor'
nmap <script> <silent> qs :AgsQuit<CR>
" }}} vim-ags "

" Identline {{{ "
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#09AA08'
let g:indentLine_char = '│'
let g:indentLine_fileTypeExclude = ['help', 'text', 'agsv']
" }}} Identline "

" CamelCase motion (replaces w, b, e) {{{ "
" map <silent> w <Plug>CamelCaseMotion_w
" map <silent> b <Plug>CamelCaseMotion_b
" map <silent> e <Plug>CamelCaseMotion_e
" sunmap w
" sunmap b
" sunmap e
" }}} CamelCase motion (replaces w, b, e) "
