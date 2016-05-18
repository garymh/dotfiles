augroup random
  autocmd!
  au VimEnter * RainbowParenthesesToggle
  au Syntax * RainbowParenthesesLoadRound
  au Syntax * RainbowParenthesesLoadSquare
  au Syntax * RainbowParenthesesLoadBraces

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
augroup END

augroup filetype_ruby
  autocmd!
  au BufRead,BufNewFile *.axlsx,Rakefile,Capfile,Gemfile,*pryrc,*pryrc-helpers.rb,Brewfile set ft=ruby syntax=ruby
augroup END
