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

nmap <leader>lead :call ListLeaders()<cr>

" nmap <leader>sp :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

if has('nvim')
  tnoremap jj <C-\><C-n>
  tnoremap kk <C-\><C-n><c-^>
  nnoremap <silent> <c-t> <c-^>i
  inoremap <M-C-H> <C-w>
  cnoremap <M-C-H> <C-w>
  nnoremap <F6> <C-i>
endif

xnoremap <leader>g "zy:!open "http://www.google.com/search?q=<c-r>=substitute(@z,' ','%20','g')<cr>"<return>gv

" folding {{{ "
  nnoremap zr zr:echo &foldlevel<cr>
  nnoremap zm zm:echo &foldlevel<cr>
  nnoremap zR zR:echo &foldlevel<cr>
  nnoremap zM zM:echo &foldlevel<cr>

  nnoremap Z za
" }}} folding "

" mappings (sort me!) {{{ "
  " cnoremap jj <esc>
  " inoremap jj <esc>
  map // :nohlsearch<cr>
  map <leader>. :e ~/.vim/temp.rb<CR>
  map <leader><leader> <C-^>
  map <silent> <leader>= mqHmwgg=G`wzt`qzz
  map <silent> <leader>ev :e $MYVIMRC<cr>
  map <silent> <leader>sv :source $MYVIMRC<cr>
  map <silent> <leader>w :w<cr>
  xmap <leader>n :NR!<cr>
  map <space>e :Files <C-r>=expand("%:h")<CR>/<CR>

  nnoremap <space>j :m+<cr>==
  nnoremap <space>k :m-2<cr>==
  xnoremap <space>k :m-2<cr>gv=gv
  xnoremap <space>j :m'>+<cr>gv=gv
  "hmm

  " nnoremap <silent> <bs><bs> :Explore<cr>
  map Y y$
  nnoremap <LocalLeader>e :edit <C-R>=expand('%:p:h') . '/'<CR>
  nnoremap <silent><LocalLeader><LocalLeader> :TagbarToggle<CR>
  nnoremap <silent><LocalLeader>g :Goyo<CR>
  nnoremap <s-tab> <c-w>w
  nnoremap c# #NcgN
  nnoremap c* *Ncgn
  noremap <expr> j (v:count == 0 ? 'gj' : 'j')
  noremap <expr> k (v:count == 0 ? 'gk' : 'k')
  nnoremap <Del> :A<cr>

  noremap H ^
  noremap L $
  " vmap p "_dP

  vnoremap < <gv
  vnoremap > >gv
  vnoremap @ :norm@
  vnoremap L g_
  " map <silent> <space>e :silent edit <C-R>=empty(expand('%')) ? '.' : expand('%:p:h')<CR><CR>
  " map <space><space> za
  " workaround for using tab as a key
" }}} mappings (sort me!) "

command! ReneeNotes execute "e ~/Documents/Work/NU/renee-meeting"

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

" @wincent is very smart
" https://www.youtube.com/watch?v=0aEv1Nj0IPg
nnoremap <silent> <Leader>num :call mappings#cycle_numbering()<CR>
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

" system copy {{{ "
  noremap <Leader>y "*y
  noremap <Leader>p "*p
  noremap <Leader>Y "+y
  noremap <Leader>P "+p
" }}} system copy "
