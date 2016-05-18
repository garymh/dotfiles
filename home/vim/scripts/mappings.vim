" folding + show level when you fold something
nnoremap zr zr:echo &foldlevel<cr>
nnoremap zm zm:echo &foldlevel<cr>
nnoremap zR zR:echo &foldlevel<cr>
nnoremap zM zM:echo &foldlevel<cr>
nnoremap <space><space> za
nnoremap <leader>. :e ~/.vim/temp.rb<CR>
nnoremap gg ggzv
nnoremap G Gzv
nnoremap <F6> <C-i>
nnoremap <silent> ! :silent edit <C-R>=empty(expand('%')) ? '.' : expand('%:p:h')<CR><CR>
nnoremap <Leader>p :echo expand('%')<CR>

set spelllang=en_us
set nospell
nnoremap <silent> <F2> :set spell!<CR> :set spell?<CR>

let mapleader=","
let maplocalleader = "\\"

nnoremap <leader>! :Neomake<cr>
nnoremap <leader>c :RuboCop -a<cr>

" netrw
nnoremap <space>e :e.<CR>

" i never use H or L's defaults, might as well make them useful!
noremap H ^
noremap L $
vnoremap L g_

" make Y behave right
nnoremap Y y$

" fix movement
nnoremap j gj
nnoremap k gk

" vimrc editing and sourcing
nnoremap <leader>sv :source $MYVIMRC<cr>
" nnoremap <leader>sv :source $MYVIMRC<cr> | :AirlineRefresh
nnoremap <leader>qev :vsplit $MYVIMRC<cr>
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>emp :e ~/.vim/scripts/mappings.vim<cr>
nnoremap <leader>emap :e ~/.vim/scripts/mappings.vim<cr>
nnoremap <leader>epl :e ~/.vim/scripts/plugin_settings.vim<cr>
nnoremap <leader>esho :e ~/iCloud/Shorcuts/shortcuts<cr>
nnoremap <leader>qemp :vsplit ~/.vim/scripts/mappings.vim<cr>
nnoremap <leader>qepl :vsplit ~/.vim/scripts/plugin_settings.vim<cr>
nnoremap <leader>ins :PlugInstall<cr>
nnoremap <leader>upd :PlugUpdate<cr>

" who on earth can reach C-^?
nnoremap <leader><leader> <C-^>
nnoremap <silent> // :nohlsearch<cr>
nnoremap <leader>= mqHmwgg=G`wzt`q

" quicker close window
nnoremap <silent>Q :Sayonara<cr>
command! -bang Q q<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>

" quicker save
nnoremap <leader>w :w<cr>

" reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

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

nnoremap <leader>d :<C-U>Git difftool %<cr>
