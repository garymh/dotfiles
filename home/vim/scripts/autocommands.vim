augroup random
  autocmd!
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  autocmd BufWritePre * StripWhitespace

  autocmd VimResized * execute "normal! \<c-w>="

  " Help mode bindings
  " <enter> to follow tag, <bs> to go back, and q to quit.
  " From http://ctoomey.com/posts/an-incremental-approach-to-vim/
  autocmd filetype help nnoremap <buffer><cr> <c-]>
  autocmd filetype help nnoremap <buffer><bs> <c-T>
  autocmd filetype help nnoremap <buffer>q :q<cr>

  autocmd FileType cf set commentstring=<!--%s-->
  autocmd FileType gitcommit normal gg
  autocmd BufReadPost fugitive://* set bufhidden=delete

  autocmd filetype crontab setlocal nobackup nowritebackup
  autocmd BufRead,BufNewFile *.axlsx,Rakefile,Capfile,Gemfile,*pryrc,*pryrc-helpers.rb,Brewfile set ft=ruby syntax=ruby foldmethod=indent
"   let ruby_operators = 1
  " let ruby_fold = 1
augroup END
