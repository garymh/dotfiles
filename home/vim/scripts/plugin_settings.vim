
" Dash {{{ "
nmap <silent> K <Plug>DashSearch
" }}} Dash "

" vim-gtfo {{{ "
let g:gtfo#terminals = { 'mac' : 'iterm' }
" }}} vim-gtfo "

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

" Airline {{{ "
let g:airline_detect_crypt=0
let g:airline#extensions#tabline#enabled       = 1
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#tab_min_count = 0
let g:airline#extensions#tabline#tab_nr_type   = 2
let g:airline_exclude_preview                  = 1
let g:airline_powerline_fonts                  = 0
let g:airline_theme='badwolf'

" }}} Airline "

" Switch {{{ "
nnoremap <silent> - :Switch<CR>
" }}} Switch "

" SplitJoin {{{ "
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

nnoremap <silent> sk :SplitjoinSplit<CR>
nnoremap <silent> sj :SplitjoinJoin<CR>
nnoremap <silent> J mzJ`z
nnoremap <silent> S i<CR><esc>k$
" }}} SplitJoin "

" YUNOCommit {{{ "
let g:YUNOcommit_after = 20
" }}} YUNOCommit "

" CTRL-P {{{ "
" command! -nargs=1 Locate call fzf#run(
" \ {'source': 'locate <q-args>', 'sink': 'e', 'options': '-m'})


if has('nvim')
  let $FZF_DEFAULT_OPTS .= ' --inline-info'
endif
nnoremap <silent> <C-p> :FZF<CR>

" Choose a color scheme with fzf
nnoremap <silent> <Leader>C :call fzf#run({
\   'source':
\     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
\         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
\   'sink':     'colo',
\   'options':  '+m',
\   'left':     20,
\   'launcher': 'xterm -geometry 20x30 -e bash -ic %s'
\ })<CR>

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
nnoremap <silent> <C-w>h :TmuxNavigateLeft<cr>
nnoremap <silent> <C-w>j :TmuxNavigateDown<cr>
nnoremap <silent> <C-w>k :TmuxNavigateUp<cr>
nnoremap <silent> <C-w>l :TmuxNavigateRight<cr>
" nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
" nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
" nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
" nnoremap <silent> <M-l> :TmuxNavigateRight<cr>
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
nnoremap <leader>h :SemanticHighlightToggle<cr>
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
nnoremap <C-i> g;
nnoremap <C-o> g,
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W
" }}} Choosewin "

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

