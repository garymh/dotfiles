" set spell
set wrap
set linebreak
if v:version > 800
  set breakindent
endif

setlocal formatoptions+=tcoqnl1j

setlocal formatlistpat=^\\s*[\\[({]\\\?\\([0-9]\\+\\\|[iIvVxXlLcCdDmM]\\+\\\|[a-zA-Z]\\)[\\]:.)}]\\s\\+\\\|^\\s*[-+o*]\\s\\+

autocmd BufReadPost note-body.txt setlocal syntax=markdown
autocmd BufReadPost merge_request_description.txt setlocal syntax=markdown

