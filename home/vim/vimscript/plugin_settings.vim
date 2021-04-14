" plugin_settings.vim
" vim:fdm=marker
scriptencoding utf-8

if exists('*ale#linter#Define')
  call ale#linter#Define('gitcommit', {
        \   'name':       'vale',
        \   'executable': 'vale',
        \   'command':    'vale --output=JSON %t',
        \   'callback':   'ale#handlers#vale#Handle',
        \})
endif
let g:ale_disable_lsp = 1
let g:ale_linters = {
      \   'ruby':      ['rubocop'],
      \   'txt':       ['vale'],
      \   'gitcommit': ['vale'],
      \   'text':      ['vale'],
      \   'markdown':  ['vale'],
      \}
let g:ale_fixers = {
      \    'ruby': ['rubocop'],
      \}
let g:ale_sign_warning       = '▪'
let g:ale_sign_error         = '▬'
let g:ale_sign_info          = '▪'
let g:ale_echo_cursor        = 1
let g:ale_virtualtext_cursor = 0

let g:mkdx#settings = { 'highlight': { 'enable': 1 },
      \ 'checkbox': { 'toggles': [' ', 'x'] },
      \ 'enter': { 'shift': 1 },
      \ 'restore_visual': 1,
      \ 'links': { 'external': { 'enable': 1 } },
      \ 'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
      \ 'fold': { 'enable': 1 },
      \ 'map': { 'prefix': '<localleader>m' } }

let g:mapleader                  = ','
let g:maplocalleader             = '\'
let g:which_key_use_floating_win = 1

nnoremap <silent> [             :<c-u>WhichKey '['<CR>
nnoremap <silent> ]             :<c-u>WhichKey ']'<CR>
nnoremap <silent> <leader>      :<c-u>WhichKey ','<CR>
nnoremap <silent> <space>       :<c-u>WhichKey '<space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey '\'<CR>

call which_key#register('<Space>', "g:which_key_space")
call which_key#register(',',       "g:which_key_leader")
call which_key#register('\',       "g:which_key_localleader")
call which_key#register('[',       "g:which_key_leftbracket")
call which_key#register(']',       "g:which_key_rightbracket")

let g:multichange_mapping        = 'sm'
let g:multichange_motion_mapping = 'm'

let g:better_whitespace_enabled             = 1
let g:strip_whitespace_on_save              = 1
let g:strip_whitespace_confirm              = 0
let g:better_whitespace_filetypes_blacklist = [
      \'diff',
      \'gitcommit',
      \'qf',
      \'help',
      \'markdown',
      \'vim-plug',
      \]

let g:vim_json_syntax_conceal = 0
let g:no_gitcommit_commands   = 1

let g:ragtag_global_maps = 1

let g:sayonara_confirm_quit = 1

function! s:SetupGhostBuffer()
    if match(expand("%:a"), '\v/ghost-(github|gitlab)\.com-')
        set ft=markdown
    endif
    execute ":Goyo"
endfunction

let g:ghost_autostart=1

augroup vim-ghost
    au!
    au User vim-ghost#connected call s:SetupGhostBuffer()
augroup END

let g:switch_custom_definitions =
      \ [
      \   ['assert', 'refute'],
      \   ['[ ]', '[x]'],
      \   ['pick', 'squash', 'fixup'],
      \   ['yes', 'no'],
      \ ]

function! BreakHere()
  s/\(.\{-}\)\(\s*\)\(\%#\)\(\s*\)\(.*\)/\1\r\3\5
  call histdel('/', -1)
endfunction

let g:fzf_history_dir = '~/.local/fzf-history'
let g:fzf_tags_command = 'rtags'
let g:fzf_layout = { 'window': 'silent botright 16split enew' }
let g:ghost_darwin_app = 'MacVim'
