
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
map  gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine
" nmap cgc <Plug>ChangeCommentary
" nmap gcu <Plug>Commentary<Plug>Commentary
" nmap <m-\> <Plug>CommentaryLine
" }}} Commentary "

" Completion & Snippets {{{ "
" let g:UltiSnipsListSnippets = "<C-g><Tab>"
let g:UltiSnipsExpandTrigger = "<Tab>"
let g:UltiSnipsJumpForwardTrigger = "<Tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"

" let g:ycm_filetype_blacklist = {
"       \ 'qf' : 1,
"       \ 'notes' : 1,
"       \ 'markdown' : 1,
"       \ }
" let g:ycm_complete_in_strings = 0
" let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_key_list_select_completion = ['<Up>']
let g:ycm_key_list_previous_completion = ['<Down>']
" }}} Completion & Snippets "

" Airline {{{ "
let g:airline_theme='jellybeans'
let g:airline#extensions#tabline#enabled       = 1
let g:airline#extensions#tabline#tab_min_count = 0
" }}} Airline "

" Switch {{{ "
nnoremap <silent> - :Switch<CR>
" }}} Switch "

" SplitJoin {{{ "
nnoremap sj :SplitjoinSplit<cr>
nnoremap sk :SplitjoinJoin<cr>
" }}} SplitJoin "

" YUNOCommit {{{ "
let g:YUNOcommit_after = 20
" }}} YUNOCommit "

" CTRL-P {{{ "
nmap <silent> <C-p> :CtrlP<CR>
let g:ctrlp_match_window_bottom   = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_abbrev = {
      \ 'gmode': 't',
      \ 'abbrevs': [
      \   { 'pattern': '^a ', 'expanded': 'app/'            },
      \   { 'pattern': '^b ', 'expanded': 'bin/'            },
      \   { 'pattern': '^c ', 'expanded': 'app/controller/' },
      \   { 'pattern': '^f ', 'expanded': 'config/'         },
      \   { 'pattern': '^h ', 'expanded': 'app/helper/'     },
      \   { 'pattern': '^l ', 'expanded': 'lib/'            },
      \   { 'pattern': '^m ', 'expanded': 'app/model/'      },
      \   { 'pattern': '^o ', 'expanded': 'log/'            },
      \   { 'pattern': '^t ', 'expanded': 'test/'           },
      \   { 'pattern': '^v ', 'expanded': 'app/views/'      },
      \ ]}
let g:ctrlp_open_new_file = 'r'
" }}} CTRL-P "

" Testing {{{ "
let g:test#strategy = 'dispatch'
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
