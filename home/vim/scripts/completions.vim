set completeopt=menuone,preview,noinsert,noselect
set shortmess+=c   " Shut off completion messages
set complete-=i


let g:ulti_expand_or_jump_res = 0
let g:airline#extensions#languageclient#enabled = 1
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#completion_delay = 50
let g:mucomplete#reopen_immediately = 0
let g:mucomplete#always_use_completeopt = 1
" set completefunc=LanguageClient#complete
" set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()

" let g:LanguageClient_serverCommands = {
"     \ 'javascript': ["/usr/local/bin/javascript-typescript-stdio"],
"     \ 'css': ['css-languageserver', '--stdio'],
"     \ 'less': ['css-languageserver', '--stdio'],
"     \ 'scss': ['css-languageserver', '--stdio'],
"     \ 'ruby': ["$GEM_HOME/bin/solargraph", "stdio"],
"     \ 'erb': ["$GEM_HOME/bin/solargraph", "stdio"],
"     \ 'vim': ["vim-language-server", "--stdio"]
"     \ }

" TAB STUFF {{{ "
  fun! MyTabAction()
    return g:ulti_expand_or_jump_res ? "" : "\<plug>(MyFwd)"
  endf

  imap <plug>(MyFwd) <plug>(MUcompleteFwd)
  inoremap <plug>(TryUlti) <c-r>=UltiSnips#ExpandSnippetOrJump()<cr>
  imap <expr> <silent> <plug>(TryMUcomplete) MyTabAction()
  imap <expr> <silent> <tab> "\<plug>(TryUlti)\<plug>(TryMUcomplete)"

  let g:UltiSnipsExpandTrigger = "<f5>"        " Do not use <tab>
  let g:UltiSnipsJumpForwardTrigger = "<c-b>"  " Do not use <c-j>
" }}} TAB STUFF "

let g:mucomplete#chains = {}
let g:mucomplete#chains.default    = ['path', 'omni', 'keyn', 'dict', 'uspl', 'ulti']
let g:mucomplete#chains.markdown   = ['path', 'keyn', 'dict', 'uspl']
" let g:mucomplete#chains.vim      = ['path', 'keyn', 'dict', 'uspl']
let g:mucomplete#chains.text       = ['path', 'keyn', 'dict', 'uspl']
let g:mucomplete#chains.javascript = ['path', 'keyn', 'dict', 'uspl', 'ulti']

" let g:mucomplete#chains = {
"   \ 'default' : ['path', 'ulti', 'omni', 'keyn', 'dict', 'uspl'],
"   \ 'vim'     : ['path', 'omni', 'ulti', 'cmd', 'keyn'],
"   \ 'ruby'    : ['path', 'omni', 'ulti', 'tags', 'keyn'],
"   \ 'eruby'   : ['path', 'ulti', 'cmd', 'keyn']
"   \ }

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

" nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" " Or map each action separately
" nnoremap <silent> <leader>k :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> <leader>d :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <leader>r :call LanguageClient#textDocument_rename()<CR>

" nnoremap K :call LanguageClient_contextMenu()<CR>
