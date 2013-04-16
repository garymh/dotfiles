" plugin_settings.vim
" vim:fdm=marker
scriptencoding utf-8

" deleft.vim {{{ "
  let g:deleft_remove_strategy = 'comment'
" }}} deleft.vim "

" bullets {{{ "
  let g:bullets_set_mappings = 0
" }}} bullets "

" ale {{{ "
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
" }}} ale "

" argwrap {{{ "
  let g:argwrap_tail_indent_braces = '('
" }}} argwrap "

" rubocop {{{ "
  let g:vimrubocop_keymap = 0
" }}} rubocop "

" vim-which-key {{{ "
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
" }}} vim-which-key "

" multichange {{{ "
  let g:multichange_mapping        = 'sm'
  let g:multichange_motion_mapping = 'm'
" }}} multichange "

" projectionist {{{ "
  " let g:projectionist_ignore_term = 1
  " do i need to reenable this?
" }}} projectionist "

" lsp {{{ "
  let g:diagnostic_enable_virtual_text = 1
  let g:diagnostic_show_sign = 1
  let g:diagnostic_auto_popup_while_jump = 1
  let g:diagnostic_insert_delay = 1
" }}} lsp "

" nerdfont {{{ "
  let g:fern#renderer                          = "devicons"
  let g:fern#disable_default_mappings          = 1
  let g:fern#disable_drawer_auto_quit          = 1
  let g:fern#disable_viewer_hide_cursor        = 1
  let g:fern#mark_symbol                       = '●'
  let g:fern_git_status#disable_ignored        = 1
  let g:fern_git_status#disable_untracked      = 1
  let g:fern_git_status#disable_submodules     = 1
  let g:fern_renderer_devicons_disable_warning = 1

  function! FernInit() abort
    nmap <buffer><expr>
          \ <Plug>(fern-my-open-expand-collapse)
          \ fern#smart#leaf(
          \   "\<Plug>(fern-action-open:select)",
          \   "\<Plug>(fern-action-expand)",
          \   "\<Plug>(fern-action-collapse)",
          \ )
    nmap <buffer> o <Plug>(fern-my-open-expand-collapse)
    nmap <buffer> <CR> <Plug>(fern-action-open:edit)
    nmap <buffer> m <Plug>(fern-action-mark-toggle)j
    nmap <buffer> N <Plug>(fern-action-new-file)
    nmap <buffer> K <Plug>(fern-action-new-dir)
    nmap <buffer> D <Plug>(fern-action-remove)
    nmap <buffer> R <Plug>(fern-action-move)
    nmap <buffer> s <Plug>(fern-action-open:split)
    nmap <buffer> v <Plug>(fern-action-open:vsplit)
    nmap <buffer> r <Plug>(fern-action-reload)
    nmap <buffer> f <Nop>
    nmap <buffer> ff <Plug>(fern-action-fzf-files)
    nmap <buffer> fd <Plug>(fern-action-fzf-dirs)
    nmap <buffer> fa <Plug>(fern-action-fzf-both)
    nmap <buffer> <nowait> d <Plug>(fern-action-hidden-toggle)
    nmap <buffer> <nowait> - <Plug>(fern-action-leave)
    nmap <buffer> <nowait> < <Plug>(fern-action-leave)
    nmap <buffer> <nowait> > <Plug>(fern-action-enter)
    nmap <buffer> <nowait> ^ <Plug>(enter-project-top)
  endfunction

  augroup FernGroup
    autocmd!
    autocmd FileType fern call FernInit()
  augroup END
" }}} nerdfont "

" rooter {{{ "
  " let g:rooter_cd_cmd                                 = "lcd"
  let g:rooter_disable_map                            = 1
  let g:rooter_silent_chdir                           = 1
  let g:rooter_resolve_links                           = 1
  let g:rooter_change_directory_for_non_project_files = 'current'
  let g:rooter_patterns = ['.git', '.git/', 'node_modules/', 'Gemfile', 'package.json']
" }}} rooter "

" tmux {{{ "
  let g:tmux_navigator_no_mappings         = 1
  let g:tmux_navigator_disable_when_zoomed = 1
" }}} tmux "

" echodoc {{{ "
  let g:echodoc_enable_at_startup = 1
  let g:echodoc#type              = 'floating'
" }}} echodoc "

" vim-slime {{{ "
  " let g:slime_target                  = 'tmux'
  " let g:slime_default_config          = {'socket_name': 'default', 'target_pane': '{right-of}'}
  " let g:tslime_always_current_session = 1
  " let g:tslime_always_current_window  = 1
" }}} vim-slime "

" suda {{{ "
  let g:suda_smart_edit = 1
" }}} suda "

" floaterm {{{ "
  " let g:floaterm_gitcommit='floaterm'
  " let g:floaterm_autoinsert=1
  let g:floaterm_width     = 0.8
  let g:floaterm_height    = 0.8
  let g:floaterm_wintitle  = 0
  let g:floaterm_autoclose = 1
  " let g:floaterm_winblend      = 0
  let g:floaterm_borderchars   = ['─', '│', '─', '│', '╭', '╮', '╯', '╰']
" }}} floaterm "

" DidYouMean {{{ "
  let g:dym_use_fzf = 1
" }}} DidYouMean "

" Rainbow Parens {{{ "
  let g:rainbow_active = 1
" }}} Rainbow Parens "

" vim-slash {{{ "
  noremap <plug>(slash-after) zz
" }}} vim-slash "

" better whitespace {{{ "
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
" }}} better whitespace "

" vim polygot individual settings {{{ "
  let g:vim_json_syntax_conceal = 0
  let g:no_gitcommit_commands   = 1
" }}} vim polygot individual settings "

" Git Messenger {{{ "
  let g:git_messenger_include_diff = 'none'
  let g:git_messenger_always_into_popup = v:true

  function! GitMessengerPopup() abort
    nmap <buffer><C-o> o
    nmap <buffer><C-i> O
    nmap <silent><buffer>j :GitMessengerClose<CR>
    nmap <silent><buffer>k :GitMessengerClose<CR>
  endfunction

  augroup GitMessenger
    autocmd!
    autocmd FileType gitmessengerpopup call GitMessengerPopup()
  augroup END
" }}} Git Messenger "

" anyjump {{{ "
  let g:any_jump_list_numbers = 0
  let g:any_jump_references_enabled = 1
  let g:any_jump_grouping_enabled = 0
  let g:any_jump_preview_lines_count = 5
  let g:any_jump_max_search_results = 7
  let g:any_jump_search_prefered_engine = 'rg'
  let g:any_jump_results_ui_style = 'filename_first'
  let g:any_jump_window_width_ratio  = 0.8
  let g:any_jump_window_height_ratio = 0.8
  let g:any_jump_window_top_offset   = 4
  let g:any_jump_disable_default_keybindings = 1
  let g:any_jump_remove_comments_from_results = 1
  let g:any_jump_keyword_match_cursor_mode = 'word'
  let g:any_jump_colors = {
        \ 'plain_text':         'Comment',
        \ 'preview':            'Comment',
        \ 'preview_keyword':    'Operator',
        \ 'heading_text':       'Function',
        \ 'heading_keyword':    'Identifier',
        \ 'group_text':         'Comment',
        \ 'group_name':         'Function',
        \ 'more_button':        'Operator',
        \ 'more_explain':       'Comment',
        \ 'result_line_number': 'Comment',
        \ 'result_text':        'Statement',
        \ 'result_path':        'String',
        \ 'help':               'String'
        \}
" }}} anyjump "

" vista {{{ "
  let g:vista_icon_indent          = ['╰─▸ ', '├─▸ ']
  let g:vista#renderer#enable_icon = 1
  let g:vista_echo_cursor_strategy = 'floating_win'
  let g:vista_close_on_jump        = 1
  let g:vista_sidebar_width        = 30
" }}} vista "

" vim-surround {{{ "
  augroup Surround
    autocmd!
    autocmd User targets#mappings#user call targets#mappings#extend({
          \ 'j': {'pair': [{'o':'(', 'c':')'}, {'o':'[', 'c':']'}, {'o':'{', 'c':'}'}]},
          \ })
  augroup end
  let g:textobl_sandwich_no_default_key_mappings = 1
  " let b:surround_{char2nr('#')} = "#{\r}"
  " let b:surround_indent   = 1

  " FIX THIS!!
  let g:sandwich#recipes  = deepcopy(g:sandwich#default_recipes)
  let g:sandwich#recipes += [
        \   {'buns': ['#{', '}'], 'nesting': 1, 'match_syntax': 1,
        \    'kind': ['add', 'replace'], 'action': ['add'], 'input': ['v']},
        \ ]
  let g:sandwich#recipes += [
        \   {'buns': ['"#{', '}"'], 'nesting': 1, 'match_syntax': 1,
        \    'kind': ['add', 'replace'], 'action': ['add'], 'input': ['s']},
        \ ]
" }}} vim-surround "

" Gutentags / ctags {{{ "
  if executable('ripper-tags')
    let g:gutentags_ctags_executable_ruby = 'rtags'
  endif
  let g:gutentags_add_default_project_roots = 0
  let g:gutentags_project_root              = ['package.json', '.git', '.hg', '.svn']
  let g:gutentags_cache_dir                 = expand('~/.gutentags_cache')
  let g:gutentags_exclude_filetypes         = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git', 'vim']
  let g:gutentags_generate_on_new           = 1
  let g:gutentags_generate_on_missing       = 1
  let g:gutentags_generate_on_write         = 1
  let g:gutentags_generate_on_empty_buffer  = 0
  " exec 'silent! !mkdir -p' g:gutentags_cache_dir
" }}} Gutentags / ctags "

" ragtag {{{ "
  let g:ragtag_global_maps = 1
" }}} ragtag "

" indentLine {{{ "
  let g:indentLine_char_list       = ['▒']
  let g:indent_blankline_char      = 'f'
  let g:indentLine_fileTypeExclude = ['help', 'netrw', 'fzf']
  let g:indentLine_faster          = 1
" }}} indentLine "

" vim-sayonara {{{ "
  let g:sayonara_confirm_quit = 1
  " let g:sayonara_filetypes = {
  "     \ 'nerdtree': 'NERDTreeClose',
  "     \ 'undotree': 'echomsg "Closing Undotree" | UndotreeHide',
  "     \ }
" }}} vim-sayonara "

" Switch {{{ "
  let g:switch_custom_definitions =
        \ [
        \   ['assert', 'refute'],
        \   ['[ ]', '[x]'],
        \   ['pick', 'squash', 'fixup'],
        \   ['yes', 'no'],
        \ ]
" }}} Switch "

" easy-align {{{ "
  let g:easy_align_delimiters = {
        \   '/': {
        \     'pattern':         '//\+\|/\*\|\*/',
        \     'delimiter_align': 'l',
        \     'ignore_groups':   [ '!Comment' ]
        \   },
        \ '\': {
        \     'pattern': '\\$',
        \ },
        \   ';': {
        \     'pattern':         ';',
        \     'delimiter_align': 'l',
        \     'ignore_groups':   [ '!Comment' ]
        \   },
        \   '(': {
        \     'pattern':         '(',
        \     'delimiter_align': 'l',
        \     'right_margin':    0
        \   },
        \   ']': {
        \     'pattern':         '[[\]]',
        \     'left_margin':     0,
        \     'right_margin':    0,
        \     'stick_to_left':   0
        \   }
        \ }
  let g:easy_align_bypass_fold = 1
" }}} easy-align "

" SplitJoin {{{ "
  let g:splitjoin_split_mapping = ''
  let g:splitjoin_join_mapping  = ''
  let g:splitjoin_align         = 1

  function! BreakHere()
    s/\(.\{-}\)\(\s*\)\(\%#\)\(\s*\)\(.*\)/\1\r\3\5
    call histdel('/', -1)
  endfunction
" }}} SplitJoin "

" dadbod-ui {{{ "
  let g:db_ui_env_variable_url = 'DATABASE_URL'
  " let g:db_ui_env_variable_name = 'GitLab'
" }}} dadbod-ui "

" FZF settings {{{ "
  let g:fzf_history_dir = '~/.local/fzf-history'
  let g:fzf_tags_command = 'rtags'

  if has('nvim-0.4.0')
    source $DOTFILES/home/vim/scripts/cool_floating_window.vim
    let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }
  else
    let g:fzf_layout = { 'window': 'silent botright 16split enew' }
  endif
" }}} FZF settings "

" Testing {{{ "
  " let test#strategy = 'floaterm'
  let test#strategy = 'vimux'

  let g:VimuxHeight = '60'
  " let test#ruby#rails#options = {
  "       \ 'all':   '-f -p'
  "       \}
  let g:test#ruby#rspec#options = {
        \ 'nearest': '--format progress --force-color --fail-fast',
        \ 'file':    '--format documentation --force-color --fail-fast',
        \}
  let g:test#ruby#rspec#executable = 'ENABLE_SPRING=1 bin/rspec'
" }}} Testing "

" animate/lens {{{ "
  let g:animate#distribute_space = 0
  let g:animate#duration         = 150.0
  let g:lens#disabled_filetypes  = ['help', 'fzf', 'vista']
  let g:lens#animate             = 0
  " let g:lens#disabled            = 1
  let g:animate#easing_func      = 'animate#ease_in_out_sine'
" }}} animate/lens "

" git-gutter {{{ "
  let g:gitgutter_map_keys                = 0
  let g:gitgutter_sign_added              = '▓'
  let g:gitgutter_sign_modified           = '▓'
  let g:gitgutter_sign_removed            = '▓'
  let g:gitgutter_sign_removed_first_line = '▓'
  let g:gitgutter_sign_modified_removed   = '▓'
  let g:gitgutter_set_sign_backgrounds    = 1
  " let g:gitgutter_use_location_list = 1

  " cool boxes: ░▒▓
" }}} git-gutter "

" dim-inactive {{{ "
  let g:diminactive_enable_focus = 1
  let g:diminactive_use_colorcolumn = 1
" }}} dim-inactive "

" esearch {{{ "
  let g:esearch = {}
  let g:esearch.before = 1
  let g:esearch.after = 1
  if has('nvim')
    let g:esearch.backend = 'nvim'
  else
    let g:esearch.backend = 'vim8'
  end

  " let g:esearch = extend(get(g:, 'esearch', {}), {
  "       \ 'win_update_throttle_wait': 200,
  "       \ 'win_matches_highlight_debounce_wait': 200,
  "       \ 'win_viewport_off_screen_margin': &lines / 2,
  "       \ 'win_cursor_linenr_highlight': 0
  "       \})
  " let g:esearch.win_contexts_syntax_sync_minlines        = 100
  " let g:esearch.win_context_syntax_clear_on_line_len     = 200
  " let g:esearch.win_contexts_syntax_clear_on_line_len    = 100
  " let g:esearch.win_contexts_syntax_clear_on_files_count = 100
  let g:esearch.win_map = [
  \ ['n',  'o', '<plug>(esearch-win-open)' , {'nowait': 1}]
  \]

" }}} esearch "

" statusbar scroller {{{ "
  let g:scrollstatus_size = 15
" }}} statusbar scroller "
