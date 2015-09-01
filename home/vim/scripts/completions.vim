let s:darwin = has('mac')


if s:darwin
  function! BuildYCM(info)
    if a:info.status == 'installed' || a:info.force
      !./install.py
    endif
  endfunction

  Plug 'honza/vim-snippets'
  Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
  Plug 'SirVer/ultisnips'

  " grabbed from: https://github.com/Valloric/YouCompleteMe/issues/36

  let g:UltiSnipsExpandTrigger       ="<c-tab>"
  let g:UltiSnipsJumpForwardTrigger  = "<tab>"
  let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

  " Enable tabbing through list of results
  function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
      if pumvisible()
        return "\<C-n>"
      else
        call UltiSnips#JumpForwards()
        if g:ulti_jump_forwards_res == 0
          return "\<TAB>"
        endif
      endif
    endif
    return ""
  endfunction

  au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"

  " Expand snippet or return
  let g:ulti_expand_res = 0
  function! Ulti_ExpandOrEnter()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res
      return ''
    else
      return "\<return>"
    endif
  endfunction

  au InsertEnter * exec "inoremap <silent> <return> <C-R>=Ulti_ExpandOrEnter()<cr>"
  " inoremap <return> <C-R>=Ulti_ExpandOrEnter()<CR>

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
endif

if has('nvim')
  " no +ruby for neovim yet :(
else
  autocmd FileType ruby set omnifunc=rubycomplete#Complete
end

let g:ycm_filetype_blacklist = {
      \ 'qf' : 1,
      \ 'notes' : 1,
      \ 'markdown' : 1,
      \ }
" let g:ycm_complete_in_strings = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_collect_identifiers_from_tags_files      = 1
let g:ycm_seed_identifiers_with_syntax             = 1
