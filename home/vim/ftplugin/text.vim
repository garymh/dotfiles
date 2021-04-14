set spell
set wrap
set linebreak
set breakindent

setlocal formatoptions+=tcoqnl1j

setlocal formatlistpat=^\\s*[\\[({]\\\?\\([0-9]\\+\\\|[iIvVxXlLcCdDmM]\\+\\\|[a-zA-Z]\\)[\\]:.)}]\\s\\+\\\|^\\s*[-+o*]\\s\\+

autocmd BufReadPost note-body.txt setlocal syntax=markdown
autocmd BufReadPost merge_request_description.txt setlocal syntax=markdown

inoremap <C-f> <c-g>u<Esc>[s1z=`]a<c-g>u
