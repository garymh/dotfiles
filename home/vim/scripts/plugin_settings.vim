" Airline {{{ "
let g:airline#extensions#tabline#enabled       = 1
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#tab_min_count = 0
let g:airline#extensions#tabline#tab_nr_type   = 2
let g:airline_detect_crypt                     = 0
let g:airline_exclude_preview                  = 1
let g:airline_powerline_fonts                  = 0
let g:airline_theme                            = 'hybridline'
" }}} Airline "

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

" YUNOCommit {{{ "
let g:YUNOcommit_after = 20
" }}} YUNOCommit "

" CTRL-P {{{ "
if has('nvim')
  let $FZF_DEFAULT_OPTS .= ' --inline-info'
endif
nnoremap <silent> <c-p> :Files<CR>
nnoremap <silent> <c-e> :History<CR>
nnoremap <silent> <c-t> :Tags<CR>

" }}} CTRL-P "

" Testing {{{ "
let g:test#strategy = 'vimux'
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
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
nnoremap <silent> <tab> :TmuxNavigatePrevious<cr>
" nnoremap <tab>   <c-w>w
" nnoremap <S-tab> <c-w>W
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

" " Whitespace {{{ "
" let g:strip_whitespace_on_save = 1
" let g:better_whitespace_enabled = 0
" " }}} Whitespace "

" " Semantic Highlights {{{ "
" let g:semanticTermColors = [
"       \ 28,
"       \ 1,
"       \ 2,
"       \ 3,
"       \ 4,
"       \ 5,
"       \ 6,
"       \ 7,
"       \ 178,
"       \ 228,
"       \ 87,
"       \ 14,
"       \ 13,
"       \ 15,
"       \ 122,
"       \ 153,
"       \ 126,
"       \ 120,
"       \ 189]
" nnoremap <leader>h :SemanticHighlightToggle<cr>
" let g:semanticUseCache = 1
" let g:semanticPersistCache = 1
" let g:semanticEnableFileTypes = ['ruby', 'vim']
" " }}} Semantic Highlights "

" " Rainbow Parentheses {{{ "
" augroup parentheses
"   autocmd!
"   au VimEnter * RainbowParenthesesToggle
"   au Syntax * RainbowParenthesesLoadRound
"   au Syntax * RainbowParenthesesLoadSquare
"   au Syntax * RainbowParenthesesLoadBraces
" augroup END
" " }}} Rainbow Parentheses "

" Quickfix Toggle {{{ "
let g:toggle_list_no_mappings = 1
" nmap <script> <silent> <leader>l :call ToggleLocationList()<CR>
nmap <script> <silent> qf :call ToggleQuickfixList()<CR>
nmap <script> <silent> qq :call ToggleQuickfixList()<CR>
" }}} Quickfix Toggle "

" " Choosewin {{{ "
" nnoremap <C-i> g;
" nnoremap <C-o> g,
" nnoremap <tab>   <c-w>w
" nnoremap <S-tab> <c-w>W
" " }}} Choosewin "

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
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#09AA08'
let g:indentLine_char = '│'
let g:indentLine_fileTypeExclude = ['help', 'text', 'agsv']
" }}} Identline "

" NERDtree {{{ "
nnoremap <f1> :NERDTreeToggle<cr>
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeRespectWildIgnore = 1
" }}} NERDtree "

