function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.py
  endif
endfunction

Plug 'honza/vim-snippets'
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'SirVer/ultisnips'

" YCM-UltiSnip-SuperTab:
" ------------------------------
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>" " you can use <c-j>
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1

" Disable unhelpful semantic completions.
let g:ycm_filetype_specific_completion_to_disable = {
      \   'c': 1,
      \   'gitcommit': 1,
      \   'haskell': 1,
      \   'ruby': 1,
      \   'javascript': 1
      \ }


let g:ycm_semantic_triggers = {
      \   'haskell': [
      \     '.',
      \     '(',
      \     ',',
      \     ', '
      \   ],
      \   'markdown': [
      \     ']('
      \   ]
      \ }

" Same as default, but with "markdown" and "text" removed.
let g:ycm_filetype_blacklist = {
      \   'notes': 1,
      \   'unite': 1,
      \   'tagbar': 1,
      \   'pandoc': 1,
      \   'qf': 1,
      \   'vimwiki': 1,
      \   'infolog': 1,
      \   'mail': 1
      \ }

