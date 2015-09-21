augroup random
  autocmd!
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

  " Help mode bindings
  " <enter> to follow tag, <bs> to go back, and q to quit.
  " From http://ctoomey.com/posts/an-incremental-approach-to-vim/
  autocmd filetype help nnoremap <buffer><cr> <c-]>
  autocmd filetype help nnoremap <buffer><bs> <c-T>
  autocmd filetype help nnoremap <buffer>q :q<cr>

  autocmd FileType cf set commentstring=<!--%s-->
  " jump the top in git commit messages
  autocmd FileType gitcommit normal gg
  autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END

augroup ft_yaml
  au!

  au FileType yaml set shiftwidth=2
augroup END

" Removes trailing spaces
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction

autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()

augroup ft_css
  au!

  au BufNewFile,BufRead *.less setlocal filetype=less

  au Filetype less,css setlocal iskeyword+=-

  au BufNewFile,BufRead *.less,*.css nnoremap <buffer> <localleader>S ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>
augroup END

augroup ft_quickfix
  au!
  au Filetype qf setlocal colorcolumn=0 nolist nocursorline nowrap tw=0
augroup END

augroup ag_config
  " stolen from @gf3
  autocmd!

  if executable("ag")
    " Note we extract the column as well as the file and line number
    set grepprg=ag\ --nogroup\ --nocolor\ --column
    set grepformat=%f:%l:%c%m

    " Have the silver searcher ignore all the same things as wilgignore
    let b:ag_command = 'ag %s -i --nocolor --nogroup'

    for i in split(&wildignore, ",")
      let i = substitute(i, '\*/\(.*\)/\*', '\1', 'g')
      let b:ag_command = b:ag_command . ' --ignore "' . substitute(i, '\*/\(.*\)/\*', '\1', 'g') . '"'
    endfor

    let b:ag_command = b:ag_command . ' --hidden -g ""'
    let g:ctrlp_user_command = b:ag_command
  endif
augroup END

augroup filetype_ruby
  autocmd!

  au BufRead,BufNewFile Rakefile,Capfile,Gemfile,*pryrc,*pryrc-helpers.rb,Brewfile set ft=ruby syntax=ruby

  " autocmd FileType ruby let g:rubycomplete_buffer_loading=1
  " autocmd FileType ruby let g:rubycomplete_classes_in_global=1
  autocmd FileType ruby let g:ruby_fold=1
  " autocmd FileType ruby let ruby_operators = 1
augroup END

augroup configure_folds
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType ruby setlocal foldmethod=syntax
  autocmd bufwritepost vim source $MYVIMRC
augroup END
