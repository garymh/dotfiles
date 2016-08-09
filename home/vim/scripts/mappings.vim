set spelllang=en_us
set nospell
nnoremap <silent> <F2> :set spell!<CR> :set spell?<CR>

let mapleader=","
let maplocalleader = "\\"

" folding + show level when you fold something
nnoremap zr zr:echo &foldlevel<cr>
nnoremap zm zm:echo &foldlevel<cr>
nnoremap zR zR:echo &foldlevel<cr>
nnoremap zM zM:echo &foldlevel<cr>

" workaround for using tab as a key
nnoremap <F6> <C-i>

map <leader><leader> <C-^>
" map <space><space> za

map <silent> // :nohlsearch<cr>
map <silent> <space>e :silent edit <C-R>=empty(expand('%')) ? '.' : expand('%:p:h')<CR><CR>

nnoremap <LocalLeader>e :edit <C-R>=expand('%:p:h') . '/'<CR>

nnoremap <silent> <space><space> :ArgWrap<CR>
map <silent> <leader>! :Neomake<cr>
map <silent> <leader>b :Bonly<cr>
map <silent> <leader>. :e ~/.vim/temp.rb<CR>
map <silent> <leader>= mqHmwgg=G`wzt`qzz
map <silent> <leader>c :RuboCop -a<cr>q
map <silent> <leader>d :<C-U>Git difftool %<cr>
map <silent> <leader>p :echo expand('%')<CR>
map <silent> <leader>w :w<cr>

" find file in git repo
function! ChooseFile()
  let dir = expand("%:h")
  if empty(dir) | let dir = getcwd() | endif

  let root = system("cd " . dir . " && git rev-parse --show-toplevel")
  if v:shell_error != 0 | echo "Not in a git repo" | return | endif
  let root = root[0:-2]

  let selection = system("cd " . root . " && git ls-files -co --exclude-standard | choose")
  if empty(selection) | echo "Canceled" | return | end

  echo "Finding file..."
  exec ":e " . root . "/" . selection
endfunction

" shortcut
nnoremap <leader>f :call ChooseFile()<cr>

map <leader>emap :e ~/.vim/scripts/mappings.vim<cr>
map <leader>eauto :e ~/.vim/scripts/autocommands.vim<cr>
map <leader>efunction :e ~/.zsh/functions.zsh<cr>
map <leader>ealias :e ~/.zsh/aliases.zsh<cr>
map <leader>emp :e ~/.vim/scripts/mappings.vim<cr>
map <leader>epl :e ~/.vim/scripts/plugin_settings.vim<cr>
map <leader>esho :!open ~/iCloud/Shorcuts/shortcuts.pages<cr>
map <leader>eid :e ~/.vim/scripts/ideas.vim<cr>
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
command! -bang Q q<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>

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
