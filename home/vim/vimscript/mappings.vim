" vim:fdm=marker

let mapleader=","
let mapLocalLeader = "\\"

let g:which_key_space = {
    \ 'name':  'Spacebar',
    \ '-':     'Horiz. Window',
    \ '1':     'Rails models',
    \ '2':     'Rails specs',
    \ '3':     'Lib directory',
    \ 'r':     'MRU history',
    \ '[':     'Previous File',
    \ ']':     'Next File',
    \ 'space': 'Arg Wrap/unwrap',
    \ '\':     'Veritcal Split',
    \ ';':     'Commands',
    \ 's':     'Snippets (fix)',
    \ 'h':     'Help tags',
    \ 'u':     'Undo Close Tab',
    \ 'f':     'Find in project...',
    \ }

let g:which_key_leader = {
    \ 'name': 'Leader',
    \ '.':    'Temp File',
    \ ',':    'Back a file',
    \ 'T':    'Test whole file',
    \ 'b':    'Only this buffer',
    \ 'c':    'Copy and comment line',
    \ 'g':    'Fugitive',
    \ 'r':    'System Resources',
    \ 'l':    'Repeat last test',
    \ 'p':    'Paste from clipboard',
    \ 'i':    'Add the last line from pry',
    \ 'sv':   'Reload .vimrc',
    \ 't':    'Run current test',
    \ 'v':    'Visit current test',
    \ 'w':    'Save',
    \ 'y':    'Copy line to clipboard',
    \ 'z':    'Floating ZSH',
    \ }

let g:which_key_leader.e = {
    \ 'name': 'Editing...',
    \ 'a':    'Auto Commands',
    \ 'c':    'Completions',
    \ 'd':    'Dotfiles',
    \ 'e':    '.zshenv',
    \ 'f':    'ZSH funcitons',
    \ 'i':    'Install Plugins',
    \ 'm':    'Edit Mappings',
    \ 'p':    'Edit Plugins',
    \ 'sd':   'File Type Detect',
    \ 'sp':   'File Type Plugins',
    \ 't':    'Edit Tmux',
    \ 'u':    'Plugin Update',
    \ 'v':    'Edit .vimrc',
    \ 'z':    'Edit .zshrc',
    \ }

let g:which_key_leader.a = {
    \ 'name': 'AeroJump...',
    \ 'a':    'From Cursor Bolt',
    \ 'b':    'Bolt',
    \ 'd':    'Default',
    \ 's':    'Space',
    \ }

let g:which_key_localleader = {
    \ 'name': 'Local Leader',
    \ '[':    'Vista Tag Bar',
    \ 'a':    'Files in directory',
    \ 'b':    'Git blame line',
    \ 'e':    'Open side ZSH',
    \ 'f':    'Search word in project',
    \ 'g':    'LazyGit',
    \ 'n':    'New file in directory',
    \ 'q':    'All project files',
    \ 'r':    'RuboCop auto fix',
    \ 'u':    'Undo git hunk',
    \ 'l':    'Promot to :let',
    \ 'v':    'Other files in this dir',
    \ 's':    'Find definition (anyjump)',
    \ 'y':    'Copy path to clipboard',
    \ 'z':    'FZF files in directory',
    \ '\':    'ctags FZF',
    \ }

let g:which_key_leftbracket = {
      \ 'name': 'Left Bracket',
      \ '<C-L>': 'which_key_ignore',
      \ '<C-Q>': 'which_key_ignore',
      \ '<C-T>': 'which_key_ignore',
      \ '!':     'which_key_ignore',
      \ '"':     'which_key_ignore',
      \ "'":     'which_key_ignore',
      \ '%':     'which_key_ignore',
      \ '-':     'which_key_ignore',
      \ '<TAB>': 'which_key_ignore',
      \ '=':     'which_key_ignore',
      \ '[':     'which_key_ignore',
      \ ']':     'which_key_ignore',
      \ '`':     'which_key_ignore',
      \ 'A':     'which_key_ignore',
      \ 'a':     'which_key_ignore',
      \ 'B':     'which_key_ignore',
      \ 'b':     'which_key_ignore',
      \ 'c':     'which_key_ignore',
      \ 'e':     'which_key_ignore',
      \ 'f':     'which_key_ignore',
      \ 'L':     'which_key_ignore',
      \ 'l':     'which_key_ignore',
      \ 'n':     'which_key_ignore',
      \ 'P':     'which_key_ignore',
      \ 'p':     'which_key_ignore',
      \ 'Q':     'which_key_ignore',
      \ 'q':     'which_key_ignore',
      \ 's':     'which_key_ignore',
      \ 'T':     'which_key_ignore',
      \ 't':     'which_key_ignore',
      \ 'u':     'which_key_ignore',
      \ 'uu':    'which_key_ignore',
      \ 'v':     'which_key_ignore',
      \ 'x':     'which_key_ignore',
      \ 'xx':    'which_key_ignore',
      \ 'y':     'which_key_ignore',
      \ 'yy':    'which_key_ignore'
      \ }

let g:which_key_leftbracket.o = {
      \ 'name': 'Turn on...',
      \ '+': 'Cusor Line AND Column',
      \ '-': 'Cursor Line',
      \ '_': 'Cursor Line',
      \ 'b': 'Light Background',
      \ 'c': 'Cursor Line',
      \ 'd': 'Diff This',
      \ 'h': 'Search',
      \ 'i': 'Ignore Case',
      \ 'l': 'List Characters',
      \ 'n': 'Numbers',
      \ 'p': 'Paste Mode',
      \ 'r': 'Relative Numbers',
      \ 's': 'Spelling',
      \ 'u': 'Cursor Column',
      \ 'v': 'Virtual Edit',
      \ 'w': 'Wrap',
      \ 'x': 'Cusor Line AND Column',
      \ '|': 'Cursor Column',
      \ }

let g:which_key_rightbracket = {
      \ 'name':  'Right Bracket',
      \ '<C-L>': 'which_key_ignore',
      \ '<C-Q>': 'which_key_ignore',
      \ '<C-T>': 'which_key_ignore',
      \ '!':     'Next syntax issue (ALE)',
      \ '"':     'which_key_ignore',
      \ '%':     'Next matchit operator',
      \ "'":     'Next marker?',
      \ '-':     'Next marker?',
      \ '<TAB>': 'Sideways right',
      \ '=':     'Next marker?',
      \ '[':     'Next function end',
      \ ']':     'Next function start',
      \ '`':     'Next marker?',
      \ 'A':     'Last buffer?',
      \ 'a':     'which_key_ignore',
      \ 'B':     'which_key_ignore',
      \ 'b':     'which_key_ignore',
      \ 'c':     'which_key_ignore',
      \ 'e':     'which_key_ignore',
      \ 'f':     'which_key_ignore',
      \ 'L':     'which_key_ignore',
      \ 'l':     'which_key_ignore',
      \ 'n':     'which_key_ignore',
      \ 'P':     'which_key_ignore',
      \ 'p':     'which_key_ignore',
      \ 'Q':     'which_key_ignore',
      \ 'q':     'which_key_ignore',
      \ 's':     'which_key_ignore',
      \ 'T':     'which_key_ignore',
      \ 't':     'which_key_ignore',
      \ 'u':     'which_key_ignore',
      \ 'uu':    'which_key_ignore',
      \ 'v':     'which_key_ignore',
      \ 'x':     'which_key_ignore',
      \ 'xx':    'which_key_ignore',
      \ 'y':     'which_key_ignore',
      \ 'yy':    'which_key_ignore'
      \ }

let g:which_key_rightbracket.o = {
      \ 'name': 'Turn off...',
      \ '+': 'Cusor Line AND Column',
      \ '-': 'Cursor Line',
      \ '_': 'Cursor Line',
      \ 'b': 'Light Background',
      \ 'c': 'Cursor Line',
      \ 'd': 'Diff This',
      \ 'h': 'Search',
      \ 'i': 'Ignore Case',
      \ 'l': 'List Characters',
      \ 'n': 'Numbers',
      \ 'p': 'Paste Mode',
      \ 'r': 'Relative Numbers',
      \ 's': 'Spelling',
      \ 'u': 'Cursor Column',
      \ 'v': 'Virtual Edit',
      \ 'w': 'Wrap',
      \ 'x': 'Cusor Line AND Column',
      \ '|': 'Cursor Column',
      \ }

command! PrettyJSON execute "%!python -m json.tool"
function! GoogleSearch()
    " let searchterm = escape(getreg("g"))
    let searchterm = substitute(join(split(getreg("g")),"+"),'"',"","g")
     silent! exec "silent! !open \"http://google.com/search?q=" . searchterm . "\" &"
endfunction

function! LuckySearch()
     let searchterm = substitute(join(split(getreg("g")),"+"),'"',"","g")
    silent! exec "silent! !open \"https://duckduckgo.com/?q=\\!ducky+" . searchterm . "&ia=web\""
endfunction

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({
    \ 'options': ['--info=inline','--preview-window', 'right:50%:hidden'],
    \}), <bang>0)

command! -bang -nargs=? -complete=dir Buffers
    \ call fzf#vim#buffers(<q-args>, fzf#vim#with_preview({
    \ 'options': ['--preview-window', 'right:50%:hidden'],
    \}), <bang>0)

" mappings {{{ "
  " command line {{{ "
    cabbr <expr> %% expand('%:p:h')
  " }}} command line "

  " visual mode {{{ "
    " xmap          <cr> <Plug>(EasyAlign)
    " xmap          ga <Plug>(EasyAlign)
    " xmap <silent> ! :Neoformat<CR>
    xmap <silent> ?! "gy<Esc>:call LuckySearch()<CR>
    xmap <silent> ?? "gy<Esc>:call GoogleSearch()<CR>
    " xmap <silent> <leader>c :t.<CR>k<Plug>CommentaryLinej
    xmap <silent> S sa
  " }}} visual mode "

  " normal mode {{{ "
    " leader - usually runs a command {{{ "
      map <silent> <leader>. :e ~/.vim/temp.rb<CR>
      map <silent> <leader><leader> <C-^>
      " map <silent> <leader>as <Plug>(AerojumpSpace)
      " map <silent> <leader>ab <Plug>(AerojumpBolt)
      " map <silent> <leader>aa <Plug>(AerojumpFromCursorBolt)
      " map <silent> <leader>ad <Plug>(AerojumpDefault) " Boring mode
      " map <silent> <leader>T :TestFile<CR>
      " map <silent> <leader>b :BufferCloseAllButCurrent<cr>
      " map <silent> <leader>g :G<cr>
      " map <silent> <leader>i :<c-u>let pc = (v:count1 ? v:count1 : 1)<cr>:read !tail -<c-r>=pc<cr> ~/.irb_history<cr>:.-<c-r>=pc-1<cr>:norm <c-r>=pc<cr>==<cr>
      " map <silent> <leader>c :t.<CR>k<Plug>CommentaryLinej
      " map <silent> <leader>l :TestLast<CR>
      map <silent> <leader>sv :source $MYVIMRC<cr>
      " map <silent> <leader>t :TestNearest<CR>
      " map <silent> <leader>v :TestVisit<CR>
      map <silent> <leader>w :w<cr>

      " if has('nvim')
      "   map <silent> <leader>r :FloatermNew --wintype=floating ytop<CR>
      "   map <silent> <leader>z :FloatermNew --wintype=floating zsh<CR>
      " endif
    " }}} leader "

    " local leader {{{ "
      nmap          <LocalLeader>n :e <C-R>=expand('%:p:h') . '/'<CR>
      " nmap <silent> <LocalLeader>a :Fern . -drawer -reveal=% -width=35 -toggle<CR><C-w>=
      " nmap <silent> <LocalLeader>b <Plug>(git-messenger)
      " nmap <silent> <LocalLeader>e :call openterm#vertical('zsh', 0.5)<CR>
      " nmap <silent> <LocalLeader>f <Plug>CtrlSFCwordPath<CR>
      " nmap <silent> <LocalLeader>g :call openterm#horizontal('lazygit', 0.95)<CR>
      " nmap <silent> <LocalLeader>q :Fern . -drawer -width=35 -toggle<CR><C-w>=
      " nmap <silent> <LocalLeader>r :RuboCop -a<CR>
      " nmap <silent> <LocalLeader>s :AnyJump<CR>
      " nmap <silent> <LocalLeader>u <Plug>(GitGutterUndoHunk)
      " nmap <silent> <LocalLeader>v :Fern %:h -drawer -width=35 -toggle<CR><C-w>=
      nmap <silent> <LocalLeader>y :let @* = expand('%:p')<CR>
      " nmap <silent> <LocalLeader>z :Files <C-r>=expand("%:h")<CR>/<CR>
      " nmap <silent> <LocalLeader>l :PromoteToLet<cr>
      " nmap <silent> <LocalLeader><tab> <Plug>SidewaysArgumentAppendAfter

      nmap <silent> <LocalLeader>x <Plug>(mkdx-checkbox-next-n)
      vmap <silent> <LocalLeader>x <Plug>(mkdx-checkbox-next-v)

      " vmap <silent> <LocalLeader>f <Plug>CtrlSFVwordPath<CR>
      " vmap <silent> <LocalLeader>v <Plug>NameAssign
      " vmap <silent> <LocalLeader>w :AnyJumpVisual<CR>
    " }}} local leader "

    " space bar {{{ "
      " nmap <silent> <space>1 :Files all_models<CR>
      " nmap <silent> <space>2 :Files all_specs<CR>
      " nmap <silent> <space>3 :Files all_lib<CR>
      " nmap <silent> <space><space> :ArgWrap<CR>
      nmap <silent> <space>[ <Plug>unimpairedBPrevious
      nmap <silent> <space>] <Plug>unimpairedBNext
      " nmap <silent> <space>\ :call Vsplit()<CR>
      " nmap <silent> <space>- :call Split()<CR>
      " nmap <silent> <space>; :Commands<CR>
      " nmap <silent> <space>s :Snippets<CR>
      " nmap <silent> <space>c :Commits<CR>
      " nmap <silent> <space>g :GFiles?<CR>
      nmap <silent> <space>h :Helptags<CR>
      " nmap <silent> <space>r :FZFMru<CR>
      " nmap          <space>f <Plug>(esearch)
  " }}} space bar "

    nmap <silent> <C-P> :Files<CR>
    " nmap <silent> <c-g> :InfoWindowCustomToggle<cr>
    nmap <silent> ! :ALEFix<CR>
    " nmap <silent> - :Switch<CR>
    nmap <silent> ; :Buffers<CR>
    " nmap <silent> <Del> :A<cr>
    nmap <silent> <s-tab> <c-w>w
    nmap <silent> Q :Sayonara<cr>
    nmap <silent> S :call BreakHere()<CR>
    " nmap <silent> [<Tab> :SidewaysLeft<cr>
    " nmap <silent> ]<Tab> :SidewaysRight<cr>
    " nmap <silent> [n :call mappings#cycle_numbering()<CR>
    " nmap <silent> ]n :call mappings#cycle_numbering()<CR>
    " nmap <silent> dh :Deleft<CR>
    " nmap <silent> ga <Plug>(EasyAlign)
    " nmap <silent> gbc :GBranches create<SPACE>
    " nmap <silent> gbd :GBranches delete<CR>
    " nmap <silent> gbm :GBranches merge<CR>
    " nmap <silent> gbo :GBrowse<CR>
    " nmap <silent> gby :GBrowse!<CR>
    " nmap <silent> gbt :GBranches track<CR>
    " nmap <silent> ghf :GitGutterFold<CR>
    " nmap <silent> ghp :GitGutterPreviewHunk<CR>
    " nmap <silent> ghq :GitGutterQuickFix<CR>
    " nmap <silent> ghs :GitGutterStageHunk<CR>
    " nmap <silent> ghu :GitGutterUndoHunk<CR>
    " nmap <silent> gtc :GTags create<SPACE>
    " nmap <silent> gtd :GTags delete<CR>
    " nmap <silent> gto :GTags checkout<CR>
    " nmap <silent> yog :GitGutterLineHighlightsToggle<CR>
    " nmap <silent> sj :SplitjoinSplit<cr>
    " nmap <silent> sk :SplitjoinJoin<cr>
    " nmap <silent> sJ :SplitjoinSplit<cr>
    " nmap <silent> sK :SplitjoinJoin<cr>
    " " nmap <silent> K :call <SID>show_documentation()<CR>
    " nmap <silent> ]c <Plug>(GitGutterNextHunk)
    " nmap <silent> [c <Plug>(GitGutterPrevHunk)
    nmap <silent> [! <Plug>(ale_previous_wrap)
    nmap <silent> ]! <Plug>(ale_next_wrap)
    nmap <silent> ]s <Plug>VimyouautocorrectNext
    nmap <silent> [s <Plug>VimyouautocorrectPrevious
    nmap <silent> ]> <Plug>SidewaysArgumentAppendAfter
    nmap <silent> [< <Plug>SidewaysArgumentInsertBefore
    " nmap <leader>sI <Plug>SidewaysArgumentInsertFirst
    " nmap <leader>sA <Plug>SidewaysArgumentAppendLast
    " nmap <silent> dsf <Plug>DsfDelete
    " nmap <silent> csf <Plug>DsfChange
    " nmap <silent> dsnf <Plug>DsfNextDelete
    " nmap <silent> csnf <Plug>DsfNextChange
    " nmap <silent> <C-G><C-G> :GBranches --locals<CR>
    nnoremap      zM zM:echo &foldlevel<cr>
    nnoremap      zR zR:echo &foldlevel<cr>
    nnoremap      zm zm:echo &foldlevel<cr>
    nnoremap      zr zr:echo &foldlevel<cr>
    " nnoremap <silent> <Down>  :call animate#window_delta_height(15)<CR>
    " nnoremap <silent> <Up>    :call animate#window_delta_height(-15)<CR>
    " nnoremap <silent> <Right> :call animate#window_delta_width(30)<CR>
    " nnoremap <silent> <Left>  :call animate#window_delta_width(-30)<CR>
  " }}} normal mode "

  " let g:undoquit_mapping = '<space>u'

  " inoremap jj <Esc>

  " }}} insert mode "
" }}} mappings "

" open previous opened file (after jump)
" nnoremap <leader>ab :AnyJumpBack<CR>
" open last closed search window again
" nnoremap <leader>al :AnyJumpLastResults<CR>

" xmap <c-c><c-c>
" <Plug>(ale_fix)
" <Plug>(ale_toggle_buffer)

" ctrl-w H - Change horizontal splits to vertical
" ctrl-w K - Change vertical splits to horizontal

" Text objects {{{ "
  " omap af <Plug>DsfTextObjectA
  " omap if <Plug>DsfTextObjectI
  " xmap af <Plug>DsfTextObjectA
  " xmap if <Plug>DsfTextObjectI

  " " Define a text object for block arguments (do |...|) via @AndrewRadev
  " onoremap <buffer> i\| :<c-u>normal! T\|vt\|<cr>
  " onoremap <buffer> a\| :<c-u>normal! F\|vf\|<cr>
  " xnoremap <buffer> i\| :<c-u>normal! T\|vt\|<cr>
  " xnoremap <buffer> a\| :<c-u>normal! F\|vf\|<cr>

  " omap ig <Plug>(GitGutterTextObjectInnerPending)
  " omap ag <Plug>(GitGutterTextObjectOuterPending)
  " xmap ig <Plug>(GitGutterTextObjectInnerVisual)
  " xmap ag <Plug>(GitGutterTextObjectOuterVisual)
" " }}} Text objects "

" " neovim terminal {{{ "
  " if has('nvim')
  "   cnoremap <M-C-H> <C-w>
  "   inoremap <M-C-H> <C-w>
  "   nnoremap <F6> <C-i>
  "   nnoremap <silent> <c-t> <c-^>i
  "   tmap <silent> <s-tab> <c-w>w
  "   " tnoremap jj <C-\><C-n>
  "   " tnoremap kk <C-\><C-n><c-^>
  " endif
" }}} neovim terminal "

" vim should-be-defaults {{{ "
  nnoremap <expr> } foldclosed(search('^$', 'Wn'))  == -1 ? '}' : '}j}'
  nnoremap <expr> { foldclosed(search('^$', 'Wnb')) == -1 ? '{' : '{k{'
  nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
  nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
  nnoremap <silent> // :nohlsearch<cr>
  nnoremap Z za
  nnoremap Y y$
  nnoremap H ^
  nnoremap L $
  xnoremap Y y$
  xnoremap H ^
  xnoremap L $
  xnoremap [e :m-2<cr>gv=gv
  xnoremap ]e :m'>+<cr>gv=gv
  xnoremap < <gv
  xnoremap > >gv
  xnoremap @ :norm@
  " nmap s <Nop>
  " xmap s <Nop>
  noremap <leader>y "*y
  noremap <leader>p "*p
" }}} should-be-defaults  "

" Edit dotfiles {{{ "
  command! Emap      execute "e $DOTFILES/home/vim/vimscript/mappings.vim"
  command! Eauto     execute "e $DOTFILES/home/vim/vimscript/autocommands.vim"
  command! Eplugin   execute "e $DOTFILES/home/vim/vimscript/plugin_settings.vim"
  command! Ecomp     execute "e $DOTFILES/home/vim/vimscript/completions.vim"
  command! Efunction execute "e $DOTFILES/home/zsh/functions.zsh"
  command! Eprivate  execute "e $DOTFILES/home/zsh/private/private.zsh"
  command! Ealiases  execute "e $DOTFILES/home/zsh/aliases.zsh"
  command! Etmux     execute "e $DOTFILES/home/tmux.conf"
  command! Ezshrc    execute "e $DOTFILES/home/zshrc"
  command! Edotfiles execute "Files $DOTFILES"
  command! Ezsh      execute "Files $DOTFILES/home/zsh"
  command! Esnip     execute "Files $DOTFILES/home/vim/UltiSnips"

  map <silent> <space>ea :Eauto<cr>
  map <silent> <space>ec :Ecomp<cr>
  map <silent> <space>ed :Edotfiles<cr>
  map <silent> <space>ee :Ezshenv<cr>
  map <silent> <space>ef :Efunction<cr>
  map <silent> <space>eg :execute 'normal viq"gy' <bar> :call LuckySearch()<CR>
  map <silent> <space>ei :PlugInstall<cr>
  map <silent> <space>em :Emap<cr>
  map <silent> <space>ep :Eplugin<cr>
  map <silent> <space>et :Etmux<cr>
  map <silent> <space>eu :PlugUpdate<cr>
  map <silent> <space>ev :e $MYVIMRC<cr>
  map <silent> <space>ez :Ezshrc<cr>
" }}} Edit dotfiles "
