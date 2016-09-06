augroup random
  autocmd!
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  autocmd VimResized * execute "normal! \<c-w>="

  " Help mode bindings
  " <enter> to follow tag, <bs> to go back, and q to quit.
  " From http://ctoomey.com/posts/an-incremental-approach-to-vim/
  autocmd filetype help nnoremap <buffer><cr> <c-]>
  autocmd filetype help nnoremap <buffer><bs> <c-T>
  autocmd filetype help nnoremap <buffer>q :q<cr>

  " Set a pseudo filetype upon opening a buffer if filetype is not set.
  autocmd BufRead,BufNewFile * setfiletype txt
  autocmd FileType txt call PlainText()
  autocmd BufRead,BufNewFile *.axlsx,Rakefile,Capfile,Gemfile,*pryrc*,Brewfile call SetupRuby()

  autocmd FileType cf set commentstring=<!--%s-->
  autocmd FileType gitcommit normal gg
  autocmd BufReadPost fugitive://* set bufhidden=delete
  autocmd filetype crontab setlocal nobackup nowritebackup
augroup END
