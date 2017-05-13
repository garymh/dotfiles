" Set a pseudo filetype upon opening a buffer if filetype is not set.
autocmd BufEnter * if &filetype == "" | setlocal ft=text | endif
