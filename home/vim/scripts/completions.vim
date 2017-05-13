Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
Plug 'ervandew/supertab'

set completeopt=longest,menuone,preview
let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 0
let g:deoplete#max_list = 10

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif

let g:SuperTabDefaultCompletionType = "<C-n>"
let g:UltiSnipsExpandTrigger        = "<tab>"
let g:UltiSnipsJumpForwardTrigger   = "<tab>"
let g:UltiSnipsJumpBackwardTrigger  = "<s-tab>"

" Plug 'honza/vim-snippets'
" Plug 'SirVer/ultisnips'
" Plug 'lifepillar/vim-mucomplete'
" set showmode shortmess+=c
" set completeopt+=menuone,noinsert,noselect

" let g:mucomplete#enable_auto_at_startup = 1
" let g:mucomplete#chains = {
"                   \ 'default' : ['ulti', 'path', 'omni', 'incl', 'uspl', 'tags']
"                   \ }

" let g:UltiSnipsExpandTrigger = "<c-space>"
" let g:UltiSnipsJumpForwardTrigger = "<tab>"
" let g:UltiSnipsJumpBackwardTrigger = "<tab>"
