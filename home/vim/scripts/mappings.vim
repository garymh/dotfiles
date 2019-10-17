let mapleader=","
let maplocalleader = "\\"

function! ListLeaders()
  silent! redir @a
  silent! nmap <LEADER>
  silent! redir END
  silent! new
  silent! put! a
  silent! g/^s*$/d
  silent! %s/^.*,//
  silent! normal ggVg
  silent! sort
  silent! let lines = getline(1,"$")
endfunction

function! GoogleSearch()
     let searchterm = getreg("g")
     silent! exec "silent! !open \"http://google.com/search?q=" . searchterm . "\" &"
endfunction

function! LuckySearch()
     let searchterm = getreg("g")
     silent! exec "silent! !open \"http://google.com/search?q=" . searchterm . "&btnI\" &"
endfunction

" @wincent is very smart
" https://www.youtube.com/watch?v=0aEv1Nj0IPg
function! mappings#cycle_numbering() abort
  if exists('+relativenumber')
    execute {
          \ '00': 'set relativenumber   | set number',
          \ '01': 'set norelativenumber | set number',
          \ '10': 'set norelativenumber | set nonumber',
          \ '11': 'set norelativenumber | set number' }[&number . &relativenumber]
  else
    set number!<CR>
  endif
endfunction

" mappings {{{ "
  cabbr <expr> %% expand('%:p:h')

  nmap <silent> <LocalLeader><LocalLeader> :TagbarToggle<CR>
  nmap <silent> <LocalLeader>t :TestVisit<CR>
  nmap <silent> <LocalLeader>r :ReneeNotes<CR>
  nmap <silent> <LocalLeader><space> :WorkTodos<CR>
  nnoremap <LocalLeader>e :e <C-R>=expand('%:p:h') . '/'<CR>

  map <silent> <leader>. :e ~/.vim/temp.rb<CR>
  map <silent> <leader><leader> <C-^>
  map <silent> <leader>= mqHmwgg=G`wzt`qzz
  map <silent> <leader>b :Bonly<cr>
  map <silent> <leader>ev :e $MYVIMRC<cr>
  map <silent> <leader>gd :Gdiffsplit<cr>
  map <silent> <leader>gs :Gstatus<CR>
  map <silent> <leader>ins :PlugInstall<cr>
  map <silent> <leader>sv :source $MYVIMRC<cr>
  map <silent> <leader>upd :PlugUpdate<cr>
  map <silent> <leader>w :w<cr>
  nmap <silent> <leader>T :TestFile<CR>
  nmap <silent> <leader>a :TestSuite<CR>
  nmap <silent> <leader>dc :t.<CR>k<Plug>CommentaryLinej
  nmap <silent> <leader>gu <Plug>GitGutterUndoHunk
  nmap <silent> <leader>l :TestLast<CR>
  nmap <silent> <leader>t :TestNearest<CR>
  inoremap <C-_> <C-R>=GetCloseTag()<CR>
  xmap <c-c><c-c> <Plug>SlimeRegionSend
  nmap <c-c><c-c> <Plug>SlimeParagraphSend
  nmap <c-c>v     <Plug>SlimeConfig

  inoremap ;1 <c-o>ma
  nmap <silent> <space>1 :Files! app/controllers<CR>
  nmap <silent> <space>2 :Files! app/models<CR>
  nmap <silent> <space>3 :Files! app/views<CR>
  nmap <silent> <space><space> :ArgWrap<CR>
  nmap <silent> <space>[ <Plug>unimpairedBPrevious
  nmap <silent> <space>] <Plug>unimpairedBNext
  nmap <silent> ; :Buffers<CR>
  nmap <silent> <space>c :Commands<CR>
  nmap <silent> <space>3 :Files! app/views<CR>
  nmap <silent> <space>g :GFiles?<CR>
  nmap <silent> <space>h :Helptags<CR>
  nmap <silent> <space>r :History<CR>
  nmap <space>e :Files <C-r>=expand("%:h")<CR>/<CR>
  nmap <space>f <Plug>CtrlSFPrompt

  nmap <silent> <s-tab> <c-w>w
  nmap <silent> ! :Neoformat<CR>
  nmap [<Tab> :SidewaysLeft<cr>
  nmap ]<Tab> :SidewaysRight<cr>
  nmap <silent> [n :call mappings#cycle_numbering()<CR>
  nnoremap <silent> - :Switch<CR>
  " nmap <silent> J mzJ`z
  nmap <silent> Q :Sayonara<cr>
  nmap <silent> S :call BreakHere()<CR>
  nmap <silent> ga <Plug>(EasyAlign)
  nmap <silent><Del> :A<cr>

  vnoremap <silent> ?? "gy<Esc>:call GoogleSearch()<CR>
  vnoremap <silent> ?! "gy<Esc>:call LuckySearch()<CR>
  vmap <cr> <Plug>(EasyAlign)
  vmap F <Plug>CtrlSFVwordExec<CR>
  vmap ga <Plug>(EasyAlign)
" }}} mappings "

if has('nvim')
  tnoremap jj <C-\><C-n>
  tnoremap kk <C-\><C-n><c-^>
  nnoremap <silent> <c-t> <c-^>i
  inoremap <M-C-H> <C-w>
  cnoremap <M-C-H> <C-w>
  nnoremap <F6> <C-i>
endif

" folding {{{ "
  nnoremap zr zr:echo &foldlevel<cr>
  nnoremap zm zm:echo &foldlevel<cr>
  nnoremap zR zR:echo &foldlevel<cr>
  nnoremap zM zM:echo &foldlevel<cr>

  nnoremap Z za
" }}} folding "

" vim should-be-defaults {{{ "
  nnoremap <space>j :m+<cr>==
  nnoremap <space>k :m-2<cr>==
  xnoremap <space>k :m-2<cr>gv=gv
  xnoremap <space>j :m'>+<cr>gv=gv
  nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
  nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
  map <silent> // :nohlsearch<cr>
  map Y y$
  noremap H ^
  noremap L $
  vnoremap < <gv
  vnoremap > >gv
  vnoremap @ :norm@
  vnoremap L g_
" }}} should-be-defaults  "

" commands {{{ "
  command! ReneeNotes execute "e ~/Documents/Work/renee-meeting"
  command! WorkTodos execute "e ~/Documents/Work/work_todos"
  command! Leaders call ListLeaders()
" }}} commands "

" Edit dotfiles {{{ "
  command! Emap execute "e ~/.vim/scripts/mappings.vim"
  command! Eauto execute "e ~/.vim/scripts/autocommands.vim"
  command! Eplugin execute "e ~/.vim/scripts/plugin_settings.vim"
  command! Ecomp execute "e ~/.vim/scripts/completions.vim"
  command! Efunction execute "e ~/.zsh/functions.zsh"
  command! Ealiases execute "e ~/.zsh/aliases.zsh"
  command! Edotfiles execute "Files! $DOTFILES"
  command! Ezsh execute "Files! $DOTFILES/home/zsh"
  command! Esnip execute "Files! $DOTFILES/home/vim/UltiSnips"
" }}} Edit dotfiles "

" system copy {{{ "
  noremap <Leader>y "*y
  noremap <Leader>p "*p
  noremap <Leader>Y "+y
  noremap <Leader>P "+p
" }}} system copy "
