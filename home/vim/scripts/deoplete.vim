" Plug 'honza/vim-snippets'
" Plug 'SirVer/ultisnips'
Plug 'Shougo/deoplete.nvim'

" enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
if has('nvim')
  " no +ruby for neovim yet :(
else
  autocmd FileType ruby set omnifunc=rubycomplete#Complete
end

let g:deoplete#enable_at_startup=1
let g:deoplete#auto_completion_start_length=2
let g:deoplete#sources={}
let g:deoplete#sources._    = ['buffer', 'file', 'ultisnips', 'omni']
" let g:deoplete#sources.ruby = ['buffer', 'member', 'file', 'ultisnips', 'tag']
let g:deoplete#sources.ruby = ['buffer', 'file', 'ultisnips', 'tag']
let g:deoplete#sources.vim  = ['buffer', 'member', 'file', 'ultisnips']
let g:deoplete#sources.css  = ['buffer', 'member', 'file', 'omni', 'ultisnips']
let g:deoplete#sources.scss = ['buffer', 'member', 'file', 'omni', 'ultisnips']

inoremap <silent><expr> <Tab>
\ pumvisible() ? "\<C-n>" :
\ deoplete#mappings#manual_complete()
" let g:UltiSnipsJumpForwardTrigger  = "<Enter>"
" let g:UltiSnipsJumpBackwardTrigger = "<Left>"

" let g:UltiSnipsExpandTrigger = "<nop>"
" let g:ulti_expand_or_jump_res = 0

" function! ExpandSnippetOrCarriageReturn()
"     let snippet = UltiSnips#ExpandSnippetOrJump()
"     if g:ulti_expand_or_jump_res > 0
"         return snippet
"     else
"         return "\<CR>"
"     endif
" endfunction

" let g:endwise_no_mappings = 1
" inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"
" inoremap <silent> <expr> <C-X><CR> pumvisible() ? "\<C-R>=ExpandSnippetOrCarriageReturn()\<CR>" : "\<CR>\<C-R>=EndwiseAlways()\<CR>"
" inoremap <silent> <expr> <CR> pumvisible() ? "\<C-R>=ExpandSnippetOrCarriageReturn()\<CR>" : "\<CR>\<C-R>=EndwiseDiscretionary()\<CR>"
