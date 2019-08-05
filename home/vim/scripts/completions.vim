set completeopt=menuone,preview,noinsert,noselect

Plug 'lifepillar/vim-mucomplete'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

let g:mucomplete#enable_auto_at_startup = 1
let g:ulti_expand_or_jump_res = 0

" ruby omni is really slow rn
let g:mucomplete#chains = {
  \ 'default':    ['path', 'ulti', 'omni', 'keyn', 'dict', 'uspl'],
  \ 'vim':        ['path', 'omni', 'ulti', 'cmd', 'keyn'],
  \ 'ruby':       ['path', 'ulti', 'tags', 'keyn'],
  \ 'yaml':       ['path', 'ulti', 'tags', 'keyn'],
  \ 'eruby.yaml': ['path', 'ulti', 'tags', 'keyn'],
  \ 'eruby':      ['path', 'ulti', 'cmd', 'keyn'],
  \ 'javascript': ['path', 'ulti', 'cmd', 'keyn']
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

" set completefunc=LanguageClient#complete
" set shortmess+=c   " Shut off completion messages

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
