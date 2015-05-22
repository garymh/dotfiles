" folding + show level when you fold something
nnoremap zr zr:echo &foldlevel<cr>
nnoremap zm zm:echo &foldlevel<cr>
nnoremap zR zR:echo &foldlevel<cr>
nnoremap zM zM:echo &foldlevel<cr>
nnoremap <space><space> za

nnoremap gg           ggzv
nnoremap G            Gzv

" Unimpaired.vim-like toggles
nnoremap [oo :set colorcolumn=+1<CR>
nnoremap ]oo :set colorcolumn=0<CR>
nnoremap coo :let &colorcolumn = ( &colorcolumn == "+1" ? "0" : "+1" )<CR>

nnoremap [<Tab> :SidewaysLeft<CR>
nnoremap ]<Tab> :SidewaysRight<CR>

omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI

" ------------------------------------------------------------------

let mapleader=","
let maplocalleader = "\\"

nnoremap ! :Make<cr>

" delete next line
nnoremap dn majdd`a

" double returns select a block
nnoremap <CR><CR> vip

" netrw
nnoremap <space>e :e.<CR>
"map <leader><tab> :e.<cr>

" replace word under cursor
nnoremap <leader>r :%s/\<<C-r>=expand('<cword>')<CR>\>/

" ack/ag
nnoremap <space>f :Ags<space>

" i never use H or L's defaults, might as well make them useful!
noremap H ^
noremap L $
vnoremap L g_

" make Y behave right
nnoremap Y y$

" fix movement
nnoremap j gj
nnoremap k gk

" sort lines
nnoremap <leader>s vip:!sort<cr>
vnoremap <leader>s :!sort<cr>

" vimrc editing and sourcing
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>ins :PlugInstall<cr>
nnoremap <leader>upd :PlugUpdate<cr>

" who on earth can reach C-^?
nnoremap <leader><leader> <C-^>

" fugitive/git
nnoremap <leader>gac :Gcommit -m -a ""<left>
nnoremap <leader>gc :Gcommit -m ""<left>
nnoremap <silent> <leader>gp :Git push<cr>
nnoremap <silent> <leader>gs :Gstatus<cr><C-w>20+

nnoremap <silent> // :nohlsearch<cr>

" make " quotes into '
nmap <leader>fq cs"'

" <leader>hp = html preview
" map <silent> <leader>hp :!open -a Safari %<cr><cr>

nnoremap <leader>. :Scratch<cr>
" vnoremap <leader>tidy :!tidy -q -i --show-errors 0<cr>
nnoremap <leader>= mqHmwgg=G`wzt`q

" copy current filename into system clipboard - mnemonic: (c)urrent(f)ilename
" this is helpful to paste someone the path you're looking at
nnoremap <silent> <leader>cf :let @* = expand("%:~")<cr>
nnoremap <silent> <leader>cn :let @* = expand("%:t")<cr>

" better copy and paste
vnoremap <leader>y "+y
nnoremap <leader>y "+y
nnoremap <leader>p :set paste<cr>o<esc>"*]p:set nopaste<cr>
nnoremap <leader>P :set paste<cr>O<esc>"*]P:set nopaste<cr>

" splits
nnoremap <leader><bar> <C-w>v<C-w>l
nnoremap <leader>- <C-w>s

" quicker close window
nnoremap <silent>Q :Sayonara<cr>
command! -bang Q q<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>

" quicker save
nnoremap <leader>w :w<cr>

" " auto center after certain commands
" nnoremap <silent> n nzz
" nnoremap <silent> N Nzz
" nnoremap <silent> * *zz
" nnoremap <silent> # #zz
" nnoremap <silent> g* g*zz
" nnoremap <silent> g# g#zz
" nnoremap <silent> <C-o> <C-o>zz
" nnoremap <silent> <C-i> <C-i>zz

" reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" git blame
" vmap <Leader>b :<C-U>!git blame <C-R>=expand("%:p") <cr> \| sed -n <C-R>=line("'<") <cr>,<C-R>=line("'>") <cr>p <cr>

" " keep the cursor in place while joining lines
" nnoremap J mzJ`z

" " split lines, opposite of J
" nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" expands %% to current file's directory in command-line mode
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>

nnoremap <leader>ch :<C-U>Git difftool %<cr>

