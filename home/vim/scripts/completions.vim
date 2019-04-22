" if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"   Plug 'Shougo/deoplete.nvim'
"   Plug 'roxma/nvim-yarp'
"   Plug 'roxma/vim-hug-neovim-rpc'
" endif

" Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
" Plug 'SevereOverfl0w/deoplete-github'
" Plug 'honza/vim-snippets'
" Plug 'SirVer/ultisnips'
" Plug 'ervandew/supertab'

" set completeopt=longest,menuone,preview
" let g:deoplete#enable_at_startup = 1
" let g:deoplete#disable_auto_complete = 0
" let g:deoplete#max_list = 10

" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" if !exists('g:deoplete#omni#input_patterns')
"   let g:deoplete#omni#input_patterns = {}
" endif

" let g:SuperTabDefaultCompletionType = "<C-n>"
" let g:UltiSnipsExpandTrigger        = "<tab>"
" let g:UltiSnipsJumpForwardTrigger   = "<tab>"
" let g:UltiSnipsJumpBackwardTrigger  = "<s-tab>"

set completeopt=menuone,preview,noinsert,noselect

Plug 'lifepillar/vim-mucomplete'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

let g:mucomplete#enable_auto_at_startup = 1
let g:ulti_expand_or_jump_res = 0
let g:airline#extensions#languageclient#enabled = 1

let g:mucomplete#chains = {
  \ 'default' : ['path', 'ulti', 'omni', 'keyn', 'dict', 'uspl'],
  \ 'vim'     : ['path', 'omni', 'ulti', 'cmd', 'keyn'],
  \ 'ruby'    : ['path', 'omni', 'ulti', 'tags', 'keyn'],
  \ 'eruby'   : ['path', 'ulti', 'cmd', 'keyn']
  \ }

"c-n" : keywords in 'complete' (search forwards);
"c-p" : keywords in 'complete' (search backwards);
"cmd" : Vim command line;
"defs": definitions or macros;
"dict": keywords in 'dictionary';
"file": file names;
"incl": keywords in the current and included files;
"keyn": keywords in the current file (search forwards);
"keyp": keywords in the current file (search backwards);
"line": whole lines;
"omni": omni completion ('omnifunc');
"spel": spelling suggestions;
"tags": tags;
"thes": keywords in 'thesaurus';
"user": user defined completion ('completefunc').
"path": file names (MUcomplete's implementation).
"uspl": spelling suggestions (MUcomplete's implementation).

set completefunc=LanguageClient#complete
set shortmess+=c   " Shut off completion messages

let g:mucomplete#completion_delay = 50
let g:mucomplete#reopen_immediately = 0
" hey
let g:LanguageClient_serverCommands = {
    \ 'javascript': ["/usr/local/bin/javascript-typescript-stdio"],
    \ 'ruby': ["$GEM_HOME/bin/solargraph", "stdio"],
    \ }

" nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" " Or map each action separately
nnoremap <silent> <leader>k :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <leader>d :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <leader>r :call LanguageClient#textDocument_rename()<CR>

let g:ulti_expand_or_jump_res = 0
let g:mucomplete#always_use_completeopt = 1

fun! MyTabAction()
  return g:ulti_expand_or_jump_res ? "" : "\<plug>(MyFwd)"
endf

imap <plug>(MyFwd) <plug>(MUcompleteFwd)
inoremap <plug>(TryUlti) <c-r>=UltiSnips#ExpandSnippetOrJump()<cr>
imap <expr> <silent> <plug>(TryMUcomplete) MyTabAction()
imap <expr> <silent> <tab> "\<plug>(TryUlti)\<plug>(TryMUcomplete)"

let g:UltiSnipsExpandTrigger = "<f5>"        " Do not use <tab>
let g:UltiSnipsJumpForwardTrigger = "<c-b>"  " Do not use <c-j>
