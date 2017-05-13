set spelllang=en_us
set nospell
nnoremap <silent> <F2> :set spell!<CR> :set spell?<CR>

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

vnoremap @ :norm@

nmap <leader>lead :call ListLeaders()<cr>

" folding + show level when you fold something
nnoremap zr zr:echo &foldlevel<cr>
nnoremap zm zm:echo &foldlevel<cr>
nnoremap zR zR:echo &foldlevel<cr>
nnoremap zM zM:echo &foldlevel<cr>

nnoremap Z za

nnoremap gV `[V`]

if has('nvim')
  nnoremap <Leader>e :cd %:h\|execute "term"\|cd -<cr>
endif

inoremap jj <esc>
cnoremap jj <esc>

nmap <leader>dc :t.<CR>k<Plug>CommentaryLinej

if has('nvim')
  tnoremap jj <C-\><C-n>
  tnoremap kk <C-\><C-n><c-^>
  nnoremap <silent> <c-t> <c-^>i
endif

" nnoremap ß
" nnoremap <bs>
nnoremap <s-tab> <c-w>w

" workaround for using tab as a key
nnoremap <F6> <C-i>

map <leader><leader> <C-^>
" map <space><space> za

map <silent> // :nohlsearch<cr>
map <silent> <space>e :silent edit <C-R>=empty(expand('%')) ? '.' : expand('%:p:h')<CR><CR>

nnoremap <LocalLeader>e :edit <C-R>=expand('%:p:h') . '/'<CR>

nnoremap <silent> <space><space> :ArgWrap<CR>
" map <silent> <leader>! :Neomake<cr>
map <silent> ! :Neomake<cr>
map <silent> <leader>b :Bonly<cr>
map <silent> <leader>. :e ~/.vim/temp.rb<CR>
map <silent> <leader>= mqHmwgg=G`wzt`qzz
map <silent> <leader>c :RuboCop -a<cr>q
map <silent> <leader>d :<C-U>Git difftool %<cr>
map <silent> <F5> :Neoformat<CR>
map <silent> <leader>p :echo expand('%')<CR>
map <silent> <leader>w :w<cr>
map <silent> <leader>gs :Gstatus<CR>:resize 25<CR>

function! EditAll()
  e ~/.vim/scripts/plugin_settings.vim
  e ~/.vim/scripts/autocommands.vim
  e ~/.vim/scripts/mappings.vim
endfunction

command! Ruby execute "set syntax=ruby"

command! Emap execute "e ~/.vim/scripts/mappings.vim"
command! Eauto execute "e ~/.vim/scripts/autocommands.vim"
command! Eplugin execute "e ~/.vim/scripts/plugin_settings.vim"
command! Eideas execute "e ~/.vim/scripts/ideas.vim"
command! Ecomp execute "e ~/.vim/scripts/completions.vim"
command! Eall execute "call EditAll()"


command! Efunction execute "e ~/.zsh/functions.zsh"
command! Ealiases execute "e ~/.zsh/aliases.zsh"
command! Esho execute "!open ~/iCloud/Shorcuts/shortcuts.pages"
map <leader>sid :source ~/.vim/scripts/ideas.vim<cr>

map <leader>ev :e $MYVIMRC<cr>
map <leader>sv :source $MYVIMRC<cr>

map <silent> <leader>ins :PlugInstall<cr>
map <silent> <leader>upd :PlugUpdate<cr>

noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
noremap H ^
noremap L $
map Y y$

vnoremap < <gv
vnoremap > >gv
vnoremap L g_

" quicker close window
nnoremap <silent>Q :Sayonara<cr>
" command! -bang Q q<bang>
" command! -bang QA qa<bang>
" command! -bang Qa qa<bang>

" @wincent is very smart
" https://www.youtube.com/watch?v=0aEv1Nj0IPg
nnoremap <silent> <Leader>r :call mappings#cycle_numbering()<CR>
function! mappings#cycle_numbering() abort
  if exists('+relativenumber')
    execute {
          \ '00': 'set relativenumber   | set number',
          \ '01': 'set norelativenumber | set number',
          \ '10': 'set norelativenumber | set nonumber',
          \ '11': 'set norelativenumber | set number' }[&number . &relativenumber]
  else
    " No relative numbering, just toggle numbers on and off.
    set number!<CR>
  endif
endfunction
