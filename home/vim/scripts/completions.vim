set completeopt=menuone,noinsert,noselect
set shortmess+=c

if has('nvim')
  let g:UltiSnipsExpandTrigger      = "<f5>"
  let g:UltiSnipsJumpForwardTrigger = "<c-b>"
  let g:completion_enable_snippet   = 'UltiSnips'
  let g:completion_confirm_key      = ""
  let g:ulti_expand_or_jump_res     = 0

  function! Ulti_ExpandOrJump_and_getRes()
    if pumvisible()
      call UltiSnips#ExpandSnippetOrJump()
      if g:ulti_expand_or_jump_res == 0
        return "\<C-N>"
      endif
      return ""
    else
      call UltiSnips#ExpandSnippetOrJump()
      if g:ulti_expand_or_jump_res == 0
        return "\<TAB>"
      endif
      return ""
    endif
  endfunction
  inoremap <expr><TAB> Ulti_ExpandOrJump_and_getRes()
  inoremap <silent> <Tab> <C-r>=Ulti_ExpandOrJump_and_getRes()<cr>

  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

  let g:completion_chain_complete_list = {
        \ 'default': [
        \    {'complete_items': ['snippet', 'buffers', 'path' ]},
        \    {'mode': '<c-n>'},
        \    {'mode': '<c-p>'}
        \],
        \ 'ruby': [
        \    {'complete_items': ['snippet', 'lsp', 'buffers', 'path', 'tags' ]},
        \    {'mode': '<c-n>'},
        \    {'mode': '<c-p>'}
        \],
        \ 'vim': [
        \    {'complete_items': ['snippet', 'lsp', 'buffers', 'path' ]},
        \    {'mode': '<c-n>'},
        \    {'mode': '<c-p>'}
        \]
        \}

  " \    'string': [
  " \        {'mode': '<c-p>'},
  " \        {'mode': '<c-n>'}],
  " \    'func' : [
  " \        {'complete_items': ['lsp']}],
  " \    'default': [
  " \       {'complete_items': ['lsp', 'snippet']},
  " \       {'mode': '<c-p>'},
  " \       {'mode': '<c-n>'}],
  " \],
  " \ 'default' : {
  " \   'default': [
  " \       {'complete_items': ['lsp', 'snippet']},
  " \       {'mode': '<c-p>'},
  " \       {'mode': '<c-n>'}],
  " \   'comment': []
  " \   }
  " \}
  " \       {'complete_items': ['lsp', 'snippet']},
  " \       {'complete_items': ['path'], 'triggered_only': ['/']},
  " let g:completion_enable_auto_signature = 0
  let g:completion_auto_change_source = 1

else

  let g:UltiSnipsExpandTrigger = "<f5>"        " Do not use <tab>
  let g:UltiSnipsJumpForwardTrigger = "<c-b>"  " Do not use <c-j>

  let g:ulti_expand_or_jump_res = 0
  set completeopt=menuone,preview,noinsert,noselect
  set complete-=i

  let g:mucomplete#enable_auto_at_startup = 1
  let g:mucomplete#completion_delay = 50
  let g:mucomplete#reopen_immediately = 0
  let g:mucomplete#always_use_completeopt = 1

  fun! MyTabAction()
    return g:ulti_expand_or_jump_res ? "" : "\<plug>(MyFwd)"
  endf

  imap <plug>(MyFwd) <plug>(MUcompleteFwd)
  inoremap <plug>(TryUlti) <c-r>=UltiSnips#ExpandSnippetOrJump()<cr>
  imap <expr> <silent> <plug>(TryMUcomplete) MyTabAction()
  imap <expr> <silent> <tab> "\<plug>(TryUlti)\<plug>(TryMUcomplete)"

endif
