setlocal smartindent
setlocal foldmethod=indent

" let ruby_spellcheck_strings          = 0
" let g:ruby_operators                 = 1
" let g:ruby_space_errors              = 1
" let g:rubycomplete_buffer_loading    = 1
" let g:rubycomplete_classes_in_global = 1
" let g:rails_syntax                   = 0

set colorcolumn=81

let b:deleft_closing_pattern = '^\s*end\>'

" Define a text object for block arguments (do |...|)
onoremap <buffer> i\| :<c-u>normal! T\|vt\|<cr>
xnoremap <buffer> i\| :<c-u>normal! T\|vt\|<cr>
onoremap <buffer> a\| :<c-u>normal! F\|vf\|<cr>
xnoremap <buffer> a\| :<c-u>normal! F\|vf\|<cr>
