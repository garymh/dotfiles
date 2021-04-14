" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "/Users/gary/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/gary/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/gary/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/gary/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/gary/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  ["BetterLua.vim"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/BetterLua.vim"
  },
  ["FixCursorHold.nvim"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim"
  },
  ale = {
    config = { "\27LJ\2\n°\5\0\0\3\0\30\00066\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\0016\0\0\0009\0\4\0)\1\1\0=\1\5\0006\0\0\0009\0\4\0005\1\b\0005\2\a\0=\2\t\0015\2\n\0=\2\v\0015\2\f\0=\2\r\0015\2\14\0=\2\15\0015\2\16\0=\2\17\1=\1\6\0006\0\0\0009\0\4\0005\1\20\0005\2\19\0=\2\t\1=\1\18\0006\0\0\0009\0\4\0'\1\22\0=\1\21\0006\0\0\0009\0\4\0'\1\24\0=\1\23\0006\0\0\0009\0\4\0'\1\22\0=\1\25\0006\0\0\0009\0\4\0)\1\1\0=\1\26\0006\0\0\0009\0\4\0)\1\0\0=\1\27\0006\0\0\0009\0\4\0005\1\29\0=\1\28\0K\0\1\0\1\2\0\0\rbrakeman\23ale_linters_ignore\27ale_virtualtext_cursor\20ale_echo_cursor\18ale_sign_info\b‚ñ¨\19ale_sign_error\b‚ñ™\21ale_sign_warning\1\0\0\1\2\0\0\frubocop\15ale_fixers\rmarkdown\1\2\0\0\tvale\ttext\1\2\0\0\tvale\14gitcommit\1\2\0\0\tvale\btxt\1\2\0\0\tvale\truby\1\0\0\1\2\0\0\frubocop\16ale_linters\20ale_disable_lsp\6gß\1    call ale#linter#Define('gitcommit', { 'name': 'vale', 'executable': 'vale', 'command': 'vale --output=JSON %t', 'callback': 'ale#handlers#vale#Handle' })\n    \17nvim_command\bapi\bvim\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/ale"
  },
  ["animate.vim"] = {
    config = { "\27LJ\2\nø\1\0\0\4\0\a\0\0196\0\0\0009\0\1\0009\0\2\0'\2\3\0)\3\0\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\4\0)\3ñ\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\5\0'\3\6\0B\0\3\1K\0\1\0\29animate#ease_in_out_sine\24animate#easing_func\21animate#duration\29animate#distribute_space\17nvim_set_var\bapi\bvim\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/animate.vim"
  },
  ["any-jump.vim"] = {
    commands = { "AnyJump", "AnyJumpVisual" },
    config = { "\27LJ\2\n¥\a\0\0\2\0\20\00196\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\0\0009\0\1\0)\1\0\0=\1\4\0006\0\0\0009\0\1\0)\1\5\0=\1\5\0006\0\0\0009\0\1\0)\1\a\0=\1\6\0006\0\0\0009\0\1\0'\1\b\0=\1\a\0006\0\0\0009\0\1\0'\1\n\0=\1\t\0006\0\0\0009\0\1\0*\1\0\0=\1\v\0006\0\0\0009\0\1\0*\1\0\0=\1\f\0006\0\0\0009\0\1\0)\1\4\0=\1\r\0006\0\0\0009\0\1\0)\1\1\0=\1\14\0006\0\0\0009\0\1\0)\1\1\0=\1\15\0006\0\0\0009\0\1\0'\1\17\0=\1\16\0006\0\0\0009\0\1\0005\1\19\0=\1\18\0K\0\1\0\1\0\r\23result_line_number\fComment\17more_explain\fComment\16more_button\rOperator\15group_name\rFunction\15group_text\fComment\16result_path\vString\20heading_keyword\15Identifier\17heading_text\rFunction\20preview_keyword\rOperator\fpreview\fComment\thelp\vString\15plain_text\fComment\16result_text\14Statement\20any_jump_colors\tword'any_jump_keyword_match_cursor_mode*any_jump_remove_comments_from_results)any_jump_disable_default_keybindings\31any_jump_window_top_offset!any_jump_window_height_ratio any_jump_window_width_ratio\19filename_first\30any_jump_results_ui_style\arg$any_jump_search_prefered_engine any_jump_max_search_results!any_jump_preview_lines_count\30any_jump_grouping_enabled any_jump_references_enabled\26any_jump_list_numbers\6g\bvimµÊÃô\19ô≥¶ˇ\3\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/opt/any-jump.vim"
  },
  ["beacon.nvim"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/beacon.nvim"
  },
  ["blue-moon"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/blue-moon"
  },
  ["conflict-marker.vim"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/conflict-marker.vim"
  },
  ["deleft.vim"] = {
    commands = { "Deleft" },
    config = { "\27LJ\2\n@\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\fcomment\27deleft_remove_strategy\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/opt/deleft.vim"
  },
  ["echodoc.vim"] = {
    config = { "\27LJ\2\nd\0\0\2\0\5\0\t6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0005\1\4\0=\1\3\0K\0\1\0\1\0\1\ttype\rfloating\fechodoc\30echodoc_enable_at_startup\6g\bvim\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/echodoc.vim"
  },
  fzf = {
    config = { "\27LJ\2\n°\1\0\0\2\0\a\0\r6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0005\1\4\0=\1\3\0006\0\0\0009\0\1\0'\1\6\0=\1\5\0K\0\1\0\19ripper-tags -R\21fzf_tags_command\1\3\0\0\21right:50%:hidden\vctrl-/\23fzf_preview_window\21fzf_buffers_jump\6g\bvim\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  ["git-messenger.vim"] = {
    commands = { "GitMessenger" },
    config = { "\27LJ\2\n‚\3\0\0\4\0\b\0\0156\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\4\0006\0\0\0009\0\5\0009\0\6\0'\2\a\0+\3\1\0B\0\3\1K\0\1\0Œ\2    function! GitMessengerPopup() abort\n    nmap <buffer><C-o> o\n    nmap <buffer><C-i> O\n    nmap <silent><buffer>j :GitMessengerClose<CR>\n    nmap <silent><buffer>k :GitMessengerClose<CR>\n    endfunction\n\n    augroup GitMessenger\n    autocmd!\n    autocmd FileType gitmessengerpopup call GitMessengerPopup()\n    augroup END\n    \14nvim_exec\bapi$git_messenger_always_into_popup\tnone\31git_messenger_include_diff\6g\bvim\0" },
    keys = { { "", "<Plug>(git-messenger)" } },
    loaded = false,
    needs_bufread = false,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/opt/git-messenger.vim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n¬\b\0\0\5\0\20\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\14\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\3=\3\15\0025\3\16\0=\3\17\0025\3\18\0=\3\19\2B\0\2\1K\0\1\0\16watch_index\1\0\1\rinterval\3Ë\a\fkeymaps\1\0\t\17n <leader>hu5<cmd>lua require\"gitsigns\".undo_stage_hunk()<CR>\17n <leader>hR2<cmd>lua require\"gitsigns\".reset_buffer()<CR>\tx ih2:<C-U>lua require\"gitsigns\".text_object()<CR>\17n <leader>hr0<cmd>lua require\"gitsigns\".reset_hunk()<CR>\vbuffer\2\17n <leader>hs0<cmd>lua require\"gitsigns\".stage_hunk()<CR>\fnoremap\2\to ih2:<C-U>lua require\"gitsigns\".text_object()<CR>\17n <leader>hp2<cmd>lua require\"gitsigns\".preview_hunk()<CR>\nsigns\1\0\6\nnumhl\1\18sign_priority\3\6\22use_internal_diff\2\23use_decoration_api\2\20update_debounce\3d\vlinehl\1\17changedelete\1\0\4\vlinehl\21GitSignsChangeLn\ahl\19GitSignsChange\nnumhl\21GitSignsChangeNr\ttext\b‚ñì\14topdelete\1\0\4\vlinehl\21GitSignsDeleteLn\ahl\19GitSignsDelete\nnumhl\21GitSignsDeleteNr\ttext\b‚ñì\vdelete\1\0\4\vlinehl\21GitSignsDeleteLn\ahl\19GitSignsDelete\nnumhl\21GitSignsDeleteNr\ttext\b‚ñì\vchange\1\0\4\vlinehl\21GitSignsChangeLn\ahl\19GitSignsChange\nnumhl\21GitSignsChangeNr\ttext\b‚ñì\badd\1\0\0\1\0\4\vlinehl\18GitSignsAddLn\ahl\16GitSignsAdd\nnumhl\18GitSignsAddNr\ttext\b‚ñì\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["glow.nvim"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/glow.nvim"
  },
  ["gx-extended.vim"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/gx-extended.vim"
  },
  ["iceberg.vim"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/iceberg.vim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\n∆\4\0\0\2\0\r\0\0296\0\0\0009\0\1\0+\1\1\0=\1\2\0006\0\0\0009\0\1\0'\1\4\0=\1\3\0006\0\0\0009\0\1\0005\1\6\0=\1\5\0006\0\0\0009\0\1\0005\1\b\0=\1\a\0006\0\0\0009\0\1\0+\1\2\0=\1\t\0006\0\0\0009\0\1\0'\1\v\0=\1\n\0006\0\0\0009\0\1\0+\1\2\0=\1\f\0K\0\1\0*indent_blankline_show_current_context\27IndentBlankLineContext'indent_blankline_context_highlight$indent_blankline_use_treesitter\1\t\0\0\21IndentBlankLine1\21IndentBlankLine2\21IndentBlankLine3\21IndentBlankLine4\21IndentBlankLine5\21IndentBlankLine6\21IndentBlankLine7\21IndentBlankLine8)indent_blankline_char_highlight_list\1\b\0\0\thelp\ttext\14which_key\bfzf\vpacker\tyaml\rNvimTree&indent_blankline_filetype_exclude\6 \26indent_blankline_char-indent_blankline_show_first_indent_level\6g\bvim\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim"
  },
  ["lens.vim"] = {
    config = { "\27LJ\2\nà\1\0\0\4\0\6\0\r6\0\0\0009\0\1\0009\0\2\0'\2\3\0005\3\4\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\5\0)\3\0\0B\0\3\1K\0\1\0\17lens#animate\1\4\0\0\thelp\bfzf\nvista\28lens#disabled_filetypes\17nvim_set_var\bapi\bvim\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/lens.vim"
  },
  mkdx = {
    config = { "\27LJ\2\n·\2\0\0\6\0\23\0\0256\0\0\0009\0\1\0009\0\2\0'\2\3\0005\3\5\0005\4\4\0=\4\6\0035\4\b\0005\5\a\0=\5\t\4=\4\n\0035\4\v\0=\4\f\0035\4\14\0005\5\r\0=\5\15\4=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\0035\4\21\0=\4\22\3B\0\3\1K\0\1\0\bmap\1\0\1\vprefix\19<localleader>m\tfold\1\0\1\venable\3\1\btoc\1\0\2\20update_on_write\3\1\ttext\22Table of Contents\nlinks\rexternal\1\0\0\1\0\1\venable\3\1\nenter\1\0\1\nshift\3\1\rcheckbox\ftoggles\1\0\0\1\3\0\0\6 \6x\14highlight\1\0\1\19restore_visual\3\1\1\0\1\venable\3\1\18mkdx#settings\17nvim_set_var\bapi\bvim\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/mkdx"
  },
  ["multichange.vim"] = {
    config = { "\27LJ\2\ne\0\0\2\0\6\0\t6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0K\0\1\0\6m\31multichange_motion_mapping\asm\24multichange_mapping\6g\bvim\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/multichange.vim"
  },
  neoformat = {
    config = { "\27LJ\2\nN\0\0\2\0\4\0\0056\0\0\0009\0\1\0005\1\3\0=\1\2\0K\0\1\0\1\0\1\bexe\15lua-format\31neoformat_lua_luaformatter\6g\bvim\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/neoformat"
  },
  ["nvim-ale-diagnostic"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/nvim-ale-diagnostic"
  },
  ["nvim-block-paste"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/nvim-block-paste"
  },
  ["nvim-bufferline.lua"] = {
    config = { "\27LJ\2\n˘\2\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\foptions\1\0\0\1\0\15\23right_trunc_marker\bÔÇ©\18modified_icon\b‚óè\22left_trunc_marker\bÔÇ®\20max_name_length\3\18\15close_icon\bÔÄç\rtab_size\3\18\rmappings\1\27always_show_bufferline\1\22buffer_close_icon\bÔôï\fsort_by\23relative_directory\17number_style\16superscript\28show_buffer_close_icons\1\fnumbers\14buffer_id\22max_prefix_length\3\15\tview\16multiwindow\nsetup\15bufferline\frequire\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/nvim-bufferline.lua"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-compe"] = {
    config = { "\27LJ\2\nF\0\1\a\0\3\0\b6\1\0\0009\1\1\0019\1\2\1\18\3\0\0+\4\2\0+\5\2\0+\6\2\0D\1\5\0\27nvim_replace_termcodes\bapi\bvim£\1\0\0\6\0\b\2\0306\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\2\23\0\0\0\b\0\1\0X\1\16Ä6\1\0\0009\1\1\0019\1\4\1'\3\3\0B\1\2\2\18\3\1\0009\1\5\1\18\4\0\0\18\5\0\0B\1\4\2\18\3\1\0009\1\6\1'\4\a\0B\1\3\2\15\0\1\0X\2\3Ä+\1\2\0L\1\2\0X\1\2Ä+\1\1\0L\1\2\0K\0\1\0\a%s\nmatch\bsub\fgetline\6.\bcol\afn\bvim\2\0˝\1\0\0\4\2\n\1#6\0\0\0009\0\1\0009\0\2\0B\0\1\2\t\0\0\0X\0\16Ä6\0\0\0009\0\1\0009\0\3\0'\2\4\0005\3\5\0B\0\3\2\t\0\0\0X\0\4Ä-\0\0\0'\2\6\0D\0\2\0X\0\16Ä-\0\0\0'\2\a\0D\0\2\0X\0\fÄ-\0\1\0B\0\1\2\15\0\0\0X\1\4Ä-\0\0\0'\2\b\0D\0\2\0X\0\4Ä6\0\0\0009\0\1\0009\0\t\0D\0\1\0K\0\1\0\0¿\1¿\19compe#complete\n<Tab>\n<C-n>!<Plug>(vsnip-expand-or-jump)\1\2\0\0\3\1\20vsnip#available\tcall\15pumvisible\afn\bvim\2»\1\0\0\4\1\t\1\0266\0\0\0009\0\1\0009\0\2\0B\0\1\2\t\0\0\0X\0\4Ä-\0\0\0'\2\3\0D\0\2\0X\0\15Ä6\0\0\0009\0\1\0009\0\4\0'\2\5\0005\3\6\0B\0\3\2\t\0\0\0X\0\4Ä-\0\0\0'\2\a\0D\0\2\0X\0\3Ä-\0\0\0'\2\b\0D\0\2\0K\0\1\0\0¿\f<S-Tab>\28<Plug>(vsnip-jump-prev)\1\2\0\0\3ˇˇˇˇ\15\19vsnip#jumpable\tcall\n<C-p>\15pumvisible\afn\bvim\2ò\5\1\0\b\0\26\00026\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\0013\0\6\0003\1\a\0006\2\b\0003\3\n\0=\3\t\0026\2\b\0003\3\f\0=\3\v\0026\2\r\0009\2\14\0029\2\15\2'\4\16\0'\5\17\0'\6\18\0005\a\19\0B\2\5\0016\2\r\0009\2\14\0029\2\15\2'\4\20\0'\5\17\0'\6\18\0005\a\21\0B\2\5\0016\2\r\0009\2\14\0029\2\15\2'\4\16\0'\5\22\0'\6\23\0005\a\24\0B\2\5\0016\2\r\0009\2\14\0029\2\15\2'\4\20\0'\5\22\0'\6\23\0005\a\25\0B\2\5\0012\0\0ÄK\0\1\0\1\0\1\texpr\2\1\0\1\texpr\2\27v:lua.s_tab_complete()\f<S-Tab>\1\0\1\texpr\2\6s\1\0\1\texpr\2\25v:lua.tab_complete()\n<Tab>\6i\20nvim_set_keymap\bapi\bvim\0\19s_tab_complete\0\17tab_complete\a_G\0\0\vsource\1\0\n\18snippets_nvim\1\ttags\2\rnvim_lua\1\rnvim_lsp\1\nvsnip\2\tcalc\2\vbuffer\2\tpath\2\15treesitter\2\nspell\2\1\0\f\17autocomplete\2\fenabled\2\19max_menu_width\3d\18documentation\2\ndebug\1\19max_kind_width\3d\19max_abbr_width\3d\21incomplete_delay\3ê\3\19source_timeout\3»\1\18throttle_time\3P\14preselect\venable\15min_length\3\1\nsetup\ncompe\frequire\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-fzf"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/nvim-fzf"
  },
  ["nvim-fzf-commands"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/nvim-fzf-commands"
  },
  ["nvim-hlslens"] = {
    config = { "\27LJ\2\nT\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\16auto_enable\2\14calm_down\2\nsetup\fhlslens\frequire\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/nvim-hlslens"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n6\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\25nvim_tree_auto_close\6g\bvim\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\nº\1\0\0\4\0\t\0\0146\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\0029\0\3\0005\2\4\0005\3\5\0=\3\6\0025\3\a\0=\3\b\2B\0\2\1K\0\1\0\frainbow\1\0\1\venable\2\14highlight\1\0\1\venable\2\1\0\1\21ensure_installed\15maintained\nsetup\28nvim-treesitter.configs\20nvim-treesitter\frequire\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\22nvim-web-devicons\frequire\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["oceanic-next"] = {
    config = { "\27LJ\2\ni\0\0\2\0\4\0\t6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0K\0\1\0!oceanic_next_terminal_italic\31oceanic_next_terminal_bold\6g\bvim\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/oceanic-next"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["plastic.vim"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/plastic.vim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["pulumi.vim"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/pulumi.vim"
  },
  ["rails_extra.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/opt/rails_extra.vim"
  },
  ["sideways.vim"] = {
    commands = { "SidewaysLeft", "SidewaysRight", "SidewaysJumpLeft", "SidewaysJumpRight" },
    keys = { { "", "<Plug>SidewaysArgumentAppendAfter" }, { "", "<Plug>SidewaysArgumentInsertFirst" }, { "", "<Plug>SidewaysArgumentTextobjA" }, { "", "<Plug>SidewaysArgumentTextobjI" } },
    loaded = false,
    needs_bufread = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/opt/sideways.vim"
  },
  ["sitruuna.vim"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/sitruuna.vim"
  },
  spaceduck = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/spaceduck"
  },
  ["splitjoin.vim"] = {
    commands = { "SplitjoinSplit", "SplitjoinJoin" },
    config = { "\27LJ\2\nÅ\1\0\0\2\0\6\0\r6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\3\0=\1\4\0006\0\0\0009\0\1\0)\1\1\0=\1\5\0K\0\1\0\20splitjoin_align\27splitjoin_join_mapping\5\28splitjoin_split_mapping\6g\bvim\0" },
    loaded = false,
    needs_bufread = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/opt/splitjoin.vim"
  },
  ["switch.vim"] = {
    commands = { "Switch", "SwitchReverse" },
    config = { "\27LJ\2\nß\2\0\0\3\0\n\0\0196\0\0\0009\0\1\0004\1\b\0005\2\3\0>\2\1\0015\2\4\0>\2\2\0015\2\5\0>\2\3\0015\2\6\0>\2\4\0015\2\a\0>\2\5\0015\2\b\0>\2\6\0015\2\t\0>\2\a\1=\1\2\0K\0\1\0\1\2\0\0005expect(\\([^. ]\\+\\))\\.to\\(_not\\|\\)': '\\1.should\\2\1\2\0\0006\\([^. ]\\+\\)\\.should\\(_not\\|\\)': 'expect(\\1)\\.to\\2\1\3\0\0\vlet g:\vvim.g.\1\3\0\0\byes\ano\1\3\0\0\b[ ]\b[x]\1\3\0\0\aif\vunless\1\3\0\0\vassert\vrefute\30switch_custom_definitions\6g\bvim\0" },
    loaded = false,
    needs_bufread = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/opt/switch.vim"
  },
  terminus = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/terminus"
  },
  ["textobj-word-column.vim"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/textobj-word-column.vim"
  },
  ["train.nvim"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/train.nvim"
  },
  vim = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-abolish"
  },
  ["vim-apathy"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-apathy"
  },
  ["vim-argwrap"] = {
    commands = { "ArgWrap" },
    config = { "\27LJ\2\n>\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\6(\31argwrap_tail_indent_braces\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/opt/vim-argwrap"
  },
  ["vim-better-whitespace"] = {
    config = { "\27LJ\2\nÓ\1\0\0\2\0\a\0\0176\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\0\0009\0\1\0)\1\0\0=\1\4\0006\0\0\0009\0\1\0005\1\6\0=\1\5\0K\0\1\0\1\a\0\0\tdiff\14gitcommit\aqf\thelp\rmarkdown\vpacker*better_whitespace_filetypes_blacklist\29strip_whitespace_confirm\29strip_whitespace_on_save\30better_whitespace_enabled\6g\bvim\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-better-whitespace"
  },
  ["vim-commandcaps"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-commandcaps"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-cool"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-cool"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-devicons"
  },
  ["vim-easy-align"] = {
    config = { "\27LJ\2\nê\3\0\0\4\0\18\0\0236\0\0\0009\0\1\0005\1\6\0005\2\3\0005\3\4\0=\3\5\2=\2\a\0015\2\b\0=\2\t\0015\2\n\0005\3\v\0=\3\5\2=\2\f\0015\2\r\0=\2\14\0015\2\15\0=\2\16\1=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\17\0K\0\1\0\27easy_align_bypass_fold\6]\1\0\4\16left_margin\3\0\fpattern\n[[\\]]\17right_margin\3\0\18stick_to_left\3\0\6(\1\0\3\fpattern\6(\17right_margin\3\0\20delimiter_align\6l\6;\1\2\0\0\r!Comment\1\0\2\fpattern\6;\20delimiter_align\6l\6\\\1\0\1\fpattern\a\\$\6/\1\0\0\18ignore_groups\1\2\0\0\r!Comment\1\0\2\fpattern\19//\\+\\|/\\*\\|\\*/\20delimiter_align\6l\26easy_align_delimiters\6g\bvim\0" },
    keys = { { "", "<Plug>(EasyAlign)" }, { "", "<Plug>(LiveEasyAlign)" } },
    loaded = false,
    needs_bufread = false,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/opt/vim-easy-align"
  },
  ["vim-easydir"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-easydir"
  },
  ["vim-esearch"] = {
    config = { "\27LJ\2\nù\f\0\0\5\0(\0M6\0\0\0009\0\1\0005\1\3\0004\2\"\0005\3\4\0005\4\5\0>\4\4\3>\3\1\0025\3\6\0>\3\2\0025\3\a\0>\3\3\0025\3\b\0>\3\4\0025\3\t\0>\3\5\0025\3\n\0>\3\6\0025\3\v\0>\3\a\0025\3\f\0>\3\b\0025\3\r\0>\3\t\0025\3\14\0>\3\n\0025\3\15\0>\3\v\0025\3\16\0>\3\f\0025\3\17\0>\3\r\0025\3\18\0>\3\14\0025\3\19\0>\3\15\0025\3\20\0>\3\16\0025\3\21\0>\3\17\0025\3\22\0>\3\18\0025\3\23\0005\4\24\0>\4\4\3>\3\19\0025\3\25\0>\3\20\0025\3\26\0>\3\21\0025\3\27\0>\3\22\0025\3\28\0>\3\23\0025\3\29\0>\3\24\0025\3\30\0>\3\25\0025\3\31\0>\3\26\0025\3 \0>\3\27\0025\3!\0>\3\28\0025\3\"\0>\3\29\0025\3#\0>\3\30\0025\3$\0>\3\31\0025\3%\0>\3 \0025\3&\0>\3!\2=\2'\1=\1\2\0K\0\1\0\fwin_map\1\4\0\0\6n\azM\23<plug>(esearch-zM)\1\4\0\0\6n\azc\23<plug>(esearch-zc)\1\4\0\0\6n\aza\23<plug>(esearch-za)\1\4\0\0\6n\a@:\23<plug>(esearch-@:)\1\4\0\0\6n\6.\22<plug>(esearch-.)\1\4\0\0\6x\6s\22<plug>(esearch-c)\1\4\0\0\anx\6D\22<plug>(esearch-D)\1\4\0\0\anx\6C\22<plug>(esearch-C)\1\4\0\0\6n\acc\23<plug>(esearch-cc)\1\4\0\0\anx\6c\22<plug>(esearch-c)\1\4\0\0\6n\add\23<plug>(esearch-dd)\1\4\0\0\anx\6d\22<plug>(esearch-d)\1\4\0\0\6x\6x\22<plug>(esearch-d)\1\4\0\0\6n\6I\22<plug>(esearch-I)\1\0\1\vnowait\3\1\1\4\0\0\aic\t<cr>\23<plug>(esearch-cr)\1\4\0\0\aov\aam$<plug>(textobj-esearch-match-a)\1\4\0\0\aov\aim$<plug>(textobj-esearch-match-i)\1\4\0\0\6 \6((<plug>(esearch-win-jump:dirname:up)\1\4\0\0\6 \6)*<plug>(esearch-win-jump:dirname:down)\1\4\0\0\6 \6{)<plug>(esearch-win-jump:filename:up)\1\4\0\0\6 \6}+<plug>(esearch-win-jump:filename:down)\1\4\0\0\6 \6K&<plug>(esearch-win-jump:entry:up)\1\4\0\0\6 \6J(<plug>(esearch-win-jump:entry:down)\1\4\0\0\6n\n<esc>&<plug>(esearch-win-preview:close)\1\4\0\0\6n\6P)100<plug>(esearch-win-preview:enter)\1\4\0\0\6n\6p <plug>(esearch-win-preview)\1\4\0\0\6n\t<cr>\29<plug>(esearch-win-open)\1\4\0\0\6n\6S*<plug>(esearch-win-vsplit:reuse:stay)\1\4\0\0\6n\6s\31<plug>(esearch-win-vsplit)\1\4\0\0\6n\6T%<plug>(esearch-win-tabopen:stay)\1\4\0\0\6n\6t <plug>(esearch-win-tabopen)\1\4\0\0\6n\6R\31<plug>(esearch-win-reload)\1\0\1\vnowait\3\1\1\4\0\0\6n\6o\29<plug>(esearch-win-open)\1\0\4\21default_mappings\3\0\fbackend\tnvim\nafter\3\1\vbefore\3\1\fesearch\6g\bvim\0" },
    keys = { { "", "<Plug>(esearch)" } },
    loaded = false,
    needs_bufread = false,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/opt/vim-esearch"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-eunuch"
  },
  ["vim-floaterm"] = {
    commands = { "FloatermNew" },
    config = { "\27LJ\2\n}\0\0\2\0\5\1\r6\0\0\0009\0\1\0*\1\0\0=\1\2\0006\0\0\0009\0\1\0*\1\0\0=\1\3\0006\0\0\0009\0\1\0)\1\1\0=\1\4\0K\0\1\0\23floaterm_autoclose\20floaterm_height\19floaterm_width\6g\bvimõ≥ÊÃ\25Ãô≥ˇ\3\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/opt/vim-floaterm"
  },
  ["vim-foldtext"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-foldtext"
  },
  ["vim-gh-line"] = {
    config = { "\27LJ\2\n_\0\0\2\0\4\0\t6\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\0\0009\0\1\0)\1\0\0=\1\3\0K\0\1\0\30gh_line_blame_map_default\24gh_line_map_default\6g\bvim\0" },
    keys = { { "", "<Plug>(gh-line)" }, { "", "<Plug>(gh-line-blame)" } },
    loaded = false,
    needs_bufread = false,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/opt/vim-gh-line"
  },
  ["vim-gotham"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-gotham"
  },
  ["vim-gtfo"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-gtfo"
  },
  ["vim-lastplace"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-lastplace"
  },
  ["vim-matchup"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-matchup"
  },
  ["vim-niceblock"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-niceblock"
  },
  ["vim-peekaboo"] = {
    config = { "\27LJ\2\n2\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\21peekaboo_compact\6g\bvim\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-peekaboo"
  },
  ["vim-projectionist"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-projectionist"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-repo-edit"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-repo-edit"
  },
  ["vim-rooter"] = {
    config = { "\27LJ\2\nö\3\0\0\2\0\t\0\0216\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\0\0009\0\1\0)\1\1\0=\1\4\0006\0\0\0009\0\1\0005\1\6\0=\1\5\0006\0\0\0009\0\1\0'\1\b\0=\1\a\0K\0\1\0\fcurrent2rooter_change_directory_for_non_project_files\1\19\0\0\t.env\15.gitignore\19.gitattributes\17.styleci.yml\16_ide_helper\18composer.json\18composer.lock\17package.json\14README.md\18.editorconfig\t.git\n.git/\f_darcs/\t.hg/\n.bzr/\n.svn/\18node_modules/\fGemfile\20rooter_patterns\25rooter_resolve_links\24rooter_silent_chdir\23rooter_disable_map\6g\bvim\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-rooter"
  },
  ["vim-rsi"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-rsi"
  },
  ["vim-sandwich"] = {
    config = { "\27LJ\2\n˛\5\0\0\6\0\29\0A6\0\0\0009\0\1\0004\1\4\0005\2\4\0005\3\3\0=\3\5\2>\2\1\0015\2\a\0005\3\6\0=\3\5\2>\2\2\0015\2\t\0005\3\b\0=\3\5\2>\2\3\1=\1\2\0006\0\0\0009\0\1\0004\1\4\0005\2\f\0005\3\v\0=\3\5\2>\2\1\0015\2\14\0005\3\r\0=\3\5\2>\2\2\0015\2\16\0005\3\15\0=\3\5\2>\2\3\1=\1\n\0006\0\0\0009\0\17\0009\0\18\0'\2\19\0'\3\20\0'\4\21\0005\5\22\0B\0\5\0016\0\0\0009\0\17\0009\0\18\0'\2\23\0'\3\20\0'\4\21\0005\5\24\0B\0\5\0016\0\0\0009\0\17\0009\0\18\0'\2\19\0'\3\25\0'\4\26\0005\5\27\0B\0\5\0016\0\0\0009\0\17\0009\0\18\0'\2\23\0'\3\25\0'\4\26\0005\5\28\0B\0\5\1K\0\1\0\1\0\2\texpr\2\vsilent\2\1\0\2\texpr\2\vsilent\2;textobj#sandwich#auto('o', 'i', {}, g:sandwich_braces)\aij\1\0\2\texpr\2\vsilent\2\6x\1\0\2\texpr\2\vsilent\2;textobj#sandwich#auto('o', 'i', {}, g:sandwich_quotes)\aiq\6o\20nvim_set_keymap\bapi\1\0\1\fnesting\3\1\1\3\0\0\a{ \a }\1\0\1\fnesting\3\1\1\3\0\0\6[\6]\1\0\1\fnesting\3\1\1\3\0\0\6(\6)\20sandwich_braces\1\0\4\rlinewise\3\0\fnesting\3\0\17expand_range\3\0\16quoteescape\3\1\1\3\0\0\6`\6`\1\0\4\rlinewise\3\0\fnesting\3\0\17expand_range\3\0\16quoteescape\3\1\1\3\0\0\6'\6'\tbuns\1\0\4\rlinewise\3\0\fnesting\3\0\17expand_range\3\0\16quoteescape\3\1\1\3\0\0\6\"\6\"\20sandwich_quotes\6g\bvim\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-sandwich"
  },
  ["vim-sayonara"] = {
    commands = { "Sayonara" },
    config = { "\27LJ\2\n7\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\26sayonara_confirm_quit\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/opt/vim-sayonara"
  },
  ["vim-test"] = {
    config = { "\27LJ\2\n∏\3\0\0\4\0\f\0\0316\0\0\0009\0\1\0009\0\2\0'\2\3\0)\3\1\0B\0\3\0016\0\0\0009\0\1\0009\0\4\0'\2\5\0+\3\1\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\6\0'\3\a\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\b\0005\3\t\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\n\0'\3\v\0B\0\3\1K\0\1\0\30ENABLE_SPRING=1 bin/rspec\31test#ruby#rspec#executable\1\0\2\fnearest0--format progress --force-color --fail-fast\tfile5--format documentation --force-color --fail-fast\28test#ruby#rspec#options\18gary_terminal\18test#strategy/source $DOTFILES/home/vim/lua/vim-test.vim\14nvim_exec\25test#preserve_screen\17nvim_set_var\bapi\bvim\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-test"
  },
  ["vim-textobj-entire"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-textobj-entire"
  },
  ["vim-textobj-fold"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-textobj-fold"
  },
  ["vim-textobj-indblock"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-textobj-indblock"
  },
  ["vim-textobj-indent"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-textobj-indent"
  },
  ["vim-textobj-line"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-textobj-line"
  },
  ["vim-textobj-rubyblock"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-textobj-rubyblock"
  },
  ["vim-textobj-uri"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-textobj-uri"
  },
  ["vim-textobj-user"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-textobj-user"
  },
  ["vim-tmux-navigator"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/opt/vim-tmux-navigator"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-unimpaired"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-vsnip"
  },
  ["vim-vsnip-integ"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-vsnip-integ"
  },
  ["vim-which-key"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-which-key"
  },
  ["vim-xtract"] = {
    commands = { "Xtract" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/opt/vim-xtract"
  },
  vimux = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/opt/vimux"
  }
}

-- Config for: lens.vim
try_loadstring("\27LJ\2\nà\1\0\0\4\0\6\0\r6\0\0\0009\0\1\0009\0\2\0'\2\3\0005\3\4\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\5\0)\3\0\0B\0\3\1K\0\1\0\17lens#animate\1\4\0\0\thelp\bfzf\nvista\28lens#disabled_filetypes\17nvim_set_var\bapi\bvim\0", "config", "lens.vim")
-- Config for: conflict-marker.vim
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "conflict-marker.vim")
-- Config for: mkdx
try_loadstring("\27LJ\2\n·\2\0\0\6\0\23\0\0256\0\0\0009\0\1\0009\0\2\0'\2\3\0005\3\5\0005\4\4\0=\4\6\0035\4\b\0005\5\a\0=\5\t\4=\4\n\0035\4\v\0=\4\f\0035\4\14\0005\5\r\0=\5\15\4=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\0035\4\21\0=\4\22\3B\0\3\1K\0\1\0\bmap\1\0\1\vprefix\19<localleader>m\tfold\1\0\1\venable\3\1\btoc\1\0\2\20update_on_write\3\1\ttext\22Table of Contents\nlinks\rexternal\1\0\0\1\0\1\venable\3\1\nenter\1\0\1\nshift\3\1\rcheckbox\ftoggles\1\0\0\1\3\0\0\6 \6x\14highlight\1\0\1\19restore_visual\3\1\1\0\1\venable\3\1\18mkdx#settings\17nvim_set_var\bapi\bvim\0", "config", "mkdx")
-- Config for: fzf
try_loadstring("\27LJ\2\n°\1\0\0\2\0\a\0\r6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0005\1\4\0=\1\3\0006\0\0\0009\0\1\0'\1\6\0=\1\5\0K\0\1\0\19ripper-tags -R\21fzf_tags_command\1\3\0\0\21right:50%:hidden\vctrl-/\23fzf_preview_window\21fzf_buffers_jump\6g\bvim\0", "config", "fzf")
-- Config for: multichange.vim
try_loadstring("\27LJ\2\ne\0\0\2\0\6\0\t6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0K\0\1\0\6m\31multichange_motion_mapping\asm\24multichange_mapping\6g\bvim\0", "config", "multichange.vim")
-- Config for: oceanic-next
try_loadstring("\27LJ\2\ni\0\0\2\0\4\0\t6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0K\0\1\0!oceanic_next_terminal_italic\31oceanic_next_terminal_bold\6g\bvim\0", "config", "oceanic-next")
-- Config for: vim-test
try_loadstring("\27LJ\2\n∏\3\0\0\4\0\f\0\0316\0\0\0009\0\1\0009\0\2\0'\2\3\0)\3\1\0B\0\3\0016\0\0\0009\0\1\0009\0\4\0'\2\5\0+\3\1\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\6\0'\3\a\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\b\0005\3\t\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\n\0'\3\v\0B\0\3\1K\0\1\0\30ENABLE_SPRING=1 bin/rspec\31test#ruby#rspec#executable\1\0\2\fnearest0--format progress --force-color --fail-fast\tfile5--format documentation --force-color --fail-fast\28test#ruby#rspec#options\18gary_terminal\18test#strategy/source $DOTFILES/home/vim/lua/vim-test.vim\14nvim_exec\25test#preserve_screen\17nvim_set_var\bapi\bvim\0", "config", "vim-test")
-- Config for: vim-rooter
try_loadstring("\27LJ\2\nö\3\0\0\2\0\t\0\0216\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\0\0009\0\1\0)\1\1\0=\1\4\0006\0\0\0009\0\1\0005\1\6\0=\1\5\0006\0\0\0009\0\1\0'\1\b\0=\1\a\0K\0\1\0\fcurrent2rooter_change_directory_for_non_project_files\1\19\0\0\t.env\15.gitignore\19.gitattributes\17.styleci.yml\16_ide_helper\18composer.json\18composer.lock\17package.json\14README.md\18.editorconfig\t.git\n.git/\f_darcs/\t.hg/\n.bzr/\n.svn/\18node_modules/\fGemfile\20rooter_patterns\25rooter_resolve_links\24rooter_silent_chdir\23rooter_disable_map\6g\bvim\0", "config", "vim-rooter")
-- Config for: vim-cool
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "vim-cool")
-- Config for: nvim-block-paste
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "nvim-block-paste")
-- Config for: echodoc.vim
try_loadstring("\27LJ\2\nd\0\0\2\0\5\0\t6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0005\1\4\0=\1\3\0K\0\1\0\1\0\1\ttype\rfloating\fechodoc\30echodoc_enable_at_startup\6g\bvim\0", "config", "echodoc.vim")
-- Config for: nvim-bufferline.lua
try_loadstring("\27LJ\2\n˘\2\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\foptions\1\0\0\1\0\15\23right_trunc_marker\bÔÇ©\18modified_icon\b‚óè\22left_trunc_marker\bÔÇ®\20max_name_length\3\18\15close_icon\bÔÄç\rtab_size\3\18\rmappings\1\27always_show_bufferline\1\22buffer_close_icon\bÔôï\fsort_by\23relative_directory\17number_style\16superscript\28show_buffer_close_icons\1\fnumbers\14buffer_id\22max_prefix_length\3\15\tview\16multiwindow\nsetup\15bufferline\frequire\0", "config", "nvim-bufferline.lua")
-- Config for: vim-peekaboo
try_loadstring("\27LJ\2\n2\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\21peekaboo_compact\6g\bvim\0", "config", "vim-peekaboo")
-- Config for: vim-matchup
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "vim-matchup")
-- Config for: nvim-colorizer.lua
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
-- Config for: ale
try_loadstring("\27LJ\2\n°\5\0\0\3\0\30\00066\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\0016\0\0\0009\0\4\0)\1\1\0=\1\5\0006\0\0\0009\0\4\0005\1\b\0005\2\a\0=\2\t\0015\2\n\0=\2\v\0015\2\f\0=\2\r\0015\2\14\0=\2\15\0015\2\16\0=\2\17\1=\1\6\0006\0\0\0009\0\4\0005\1\20\0005\2\19\0=\2\t\1=\1\18\0006\0\0\0009\0\4\0'\1\22\0=\1\21\0006\0\0\0009\0\4\0'\1\24\0=\1\23\0006\0\0\0009\0\4\0'\1\22\0=\1\25\0006\0\0\0009\0\4\0)\1\1\0=\1\26\0006\0\0\0009\0\4\0)\1\0\0=\1\27\0006\0\0\0009\0\4\0005\1\29\0=\1\28\0K\0\1\0\1\2\0\0\rbrakeman\23ale_linters_ignore\27ale_virtualtext_cursor\20ale_echo_cursor\18ale_sign_info\b‚ñ¨\19ale_sign_error\b‚ñ™\21ale_sign_warning\1\0\0\1\2\0\0\frubocop\15ale_fixers\rmarkdown\1\2\0\0\tvale\ttext\1\2\0\0\tvale\14gitcommit\1\2\0\0\tvale\btxt\1\2\0\0\tvale\truby\1\0\0\1\2\0\0\frubocop\16ale_linters\20ale_disable_lsp\6gß\1    call ale#linter#Define('gitcommit', { 'name': 'vale', 'executable': 'vale', 'command': 'vale --output=JSON %t', 'callback': 'ale#handlers#vale#Handle' })\n    \17nvim_command\bapi\bvim\0", "config", "ale")
-- Config for: train.nvim
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "train.nvim")
-- Config for: nvim-compe
try_loadstring("\27LJ\2\nF\0\1\a\0\3\0\b6\1\0\0009\1\1\0019\1\2\1\18\3\0\0+\4\2\0+\5\2\0+\6\2\0D\1\5\0\27nvim_replace_termcodes\bapi\bvim£\1\0\0\6\0\b\2\0306\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\2\23\0\0\0\b\0\1\0X\1\16Ä6\1\0\0009\1\1\0019\1\4\1'\3\3\0B\1\2\2\18\3\1\0009\1\5\1\18\4\0\0\18\5\0\0B\1\4\2\18\3\1\0009\1\6\1'\4\a\0B\1\3\2\15\0\1\0X\2\3Ä+\1\2\0L\1\2\0X\1\2Ä+\1\1\0L\1\2\0K\0\1\0\a%s\nmatch\bsub\fgetline\6.\bcol\afn\bvim\2\0˝\1\0\0\4\2\n\1#6\0\0\0009\0\1\0009\0\2\0B\0\1\2\t\0\0\0X\0\16Ä6\0\0\0009\0\1\0009\0\3\0'\2\4\0005\3\5\0B\0\3\2\t\0\0\0X\0\4Ä-\0\0\0'\2\6\0D\0\2\0X\0\16Ä-\0\0\0'\2\a\0D\0\2\0X\0\fÄ-\0\1\0B\0\1\2\15\0\0\0X\1\4Ä-\0\0\0'\2\b\0D\0\2\0X\0\4Ä6\0\0\0009\0\1\0009\0\t\0D\0\1\0K\0\1\0\0¿\1¿\19compe#complete\n<Tab>\n<C-n>!<Plug>(vsnip-expand-or-jump)\1\2\0\0\3\1\20vsnip#available\tcall\15pumvisible\afn\bvim\2»\1\0\0\4\1\t\1\0266\0\0\0009\0\1\0009\0\2\0B\0\1\2\t\0\0\0X\0\4Ä-\0\0\0'\2\3\0D\0\2\0X\0\15Ä6\0\0\0009\0\1\0009\0\4\0'\2\5\0005\3\6\0B\0\3\2\t\0\0\0X\0\4Ä-\0\0\0'\2\a\0D\0\2\0X\0\3Ä-\0\0\0'\2\b\0D\0\2\0K\0\1\0\0¿\f<S-Tab>\28<Plug>(vsnip-jump-prev)\1\2\0\0\3ˇˇˇˇ\15\19vsnip#jumpable\tcall\n<C-p>\15pumvisible\afn\bvim\2ò\5\1\0\b\0\26\00026\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\0013\0\6\0003\1\a\0006\2\b\0003\3\n\0=\3\t\0026\2\b\0003\3\f\0=\3\v\0026\2\r\0009\2\14\0029\2\15\2'\4\16\0'\5\17\0'\6\18\0005\a\19\0B\2\5\0016\2\r\0009\2\14\0029\2\15\2'\4\20\0'\5\17\0'\6\18\0005\a\21\0B\2\5\0016\2\r\0009\2\14\0029\2\15\2'\4\16\0'\5\22\0'\6\23\0005\a\24\0B\2\5\0016\2\r\0009\2\14\0029\2\15\2'\4\20\0'\5\22\0'\6\23\0005\a\25\0B\2\5\0012\0\0ÄK\0\1\0\1\0\1\texpr\2\1\0\1\texpr\2\27v:lua.s_tab_complete()\f<S-Tab>\1\0\1\texpr\2\6s\1\0\1\texpr\2\25v:lua.tab_complete()\n<Tab>\6i\20nvim_set_keymap\bapi\bvim\0\19s_tab_complete\0\17tab_complete\a_G\0\0\vsource\1\0\n\18snippets_nvim\1\ttags\2\rnvim_lua\1\rnvim_lsp\1\nvsnip\2\tcalc\2\vbuffer\2\tpath\2\15treesitter\2\nspell\2\1\0\f\17autocomplete\2\fenabled\2\19max_menu_width\3d\18documentation\2\ndebug\1\19max_kind_width\3d\19max_abbr_width\3d\21incomplete_delay\3ê\3\19source_timeout\3»\1\18throttle_time\3P\14preselect\venable\15min_length\3\1\nsetup\ncompe\frequire\0", "config", "nvim-compe")
-- Config for: animate.vim
try_loadstring("\27LJ\2\nø\1\0\0\4\0\a\0\0196\0\0\0009\0\1\0009\0\2\0'\2\3\0)\3\0\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\4\0)\3ñ\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\5\0'\3\6\0B\0\3\1K\0\1\0\29animate#ease_in_out_sine\24animate#easing_func\21animate#duration\29animate#distribute_space\17nvim_set_var\bapi\bvim\0", "config", "animate.vim")
-- Config for: neoformat
try_loadstring("\27LJ\2\nN\0\0\2\0\4\0\0056\0\0\0009\0\1\0005\1\3\0=\1\2\0K\0\1\0\1\0\1\bexe\15lua-format\31neoformat_lua_luaformatter\6g\bvim\0", "config", "neoformat")
-- Config for: nvim-web-devicons
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\22nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
-- Config for: vim-better-whitespace
try_loadstring("\27LJ\2\nÓ\1\0\0\2\0\a\0\0176\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\0\0009\0\1\0)\1\0\0=\1\4\0006\0\0\0009\0\1\0005\1\6\0=\1\5\0K\0\1\0\1\a\0\0\tdiff\14gitcommit\aqf\thelp\rmarkdown\vpacker*better_whitespace_filetypes_blacklist\29strip_whitespace_confirm\29strip_whitespace_on_save\30better_whitespace_enabled\6g\bvim\0", "config", "vim-better-whitespace")
-- Config for: gx-extended.vim
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "gx-extended.vim")
-- Config for: nvim-treesitter
try_loadstring("\27LJ\2\nº\1\0\0\4\0\t\0\0146\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\0029\0\3\0005\2\4\0005\3\5\0=\3\6\0025\3\a\0=\3\b\2B\0\2\1K\0\1\0\frainbow\1\0\1\venable\2\14highlight\1\0\1\venable\2\1\0\1\21ensure_installed\15maintained\nsetup\28nvim-treesitter.configs\20nvim-treesitter\frequire\0", "config", "nvim-treesitter")
-- Config for: nvim-hlslens
try_loadstring("\27LJ\2\nT\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\16auto_enable\2\14calm_down\2\nsetup\fhlslens\frequire\0", "config", "nvim-hlslens")
-- Config for: gitsigns.nvim
try_loadstring("\27LJ\2\n¬\b\0\0\5\0\20\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\14\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\3=\3\15\0025\3\16\0=\3\17\0025\3\18\0=\3\19\2B\0\2\1K\0\1\0\16watch_index\1\0\1\rinterval\3Ë\a\fkeymaps\1\0\t\17n <leader>hu5<cmd>lua require\"gitsigns\".undo_stage_hunk()<CR>\17n <leader>hR2<cmd>lua require\"gitsigns\".reset_buffer()<CR>\tx ih2:<C-U>lua require\"gitsigns\".text_object()<CR>\17n <leader>hr0<cmd>lua require\"gitsigns\".reset_hunk()<CR>\vbuffer\2\17n <leader>hs0<cmd>lua require\"gitsigns\".stage_hunk()<CR>\fnoremap\2\to ih2:<C-U>lua require\"gitsigns\".text_object()<CR>\17n <leader>hp2<cmd>lua require\"gitsigns\".preview_hunk()<CR>\nsigns\1\0\6\nnumhl\1\18sign_priority\3\6\22use_internal_diff\2\23use_decoration_api\2\20update_debounce\3d\vlinehl\1\17changedelete\1\0\4\vlinehl\21GitSignsChangeLn\ahl\19GitSignsChange\nnumhl\21GitSignsChangeNr\ttext\b‚ñì\14topdelete\1\0\4\vlinehl\21GitSignsDeleteLn\ahl\19GitSignsDelete\nnumhl\21GitSignsDeleteNr\ttext\b‚ñì\vdelete\1\0\4\vlinehl\21GitSignsDeleteLn\ahl\19GitSignsDelete\nnumhl\21GitSignsDeleteNr\ttext\b‚ñì\vchange\1\0\4\vlinehl\21GitSignsChangeLn\ahl\19GitSignsChange\nnumhl\21GitSignsChangeNr\ttext\b‚ñì\badd\1\0\0\1\0\4\vlinehl\18GitSignsAddLn\ahl\16GitSignsAdd\nnumhl\18GitSignsAddNr\ttext\b‚ñì\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
-- Config for: indent-blankline.nvim
try_loadstring("\27LJ\2\n∆\4\0\0\2\0\r\0\0296\0\0\0009\0\1\0+\1\1\0=\1\2\0006\0\0\0009\0\1\0'\1\4\0=\1\3\0006\0\0\0009\0\1\0005\1\6\0=\1\5\0006\0\0\0009\0\1\0005\1\b\0=\1\a\0006\0\0\0009\0\1\0+\1\2\0=\1\t\0006\0\0\0009\0\1\0'\1\v\0=\1\n\0006\0\0\0009\0\1\0+\1\2\0=\1\f\0K\0\1\0*indent_blankline_show_current_context\27IndentBlankLineContext'indent_blankline_context_highlight$indent_blankline_use_treesitter\1\t\0\0\21IndentBlankLine1\21IndentBlankLine2\21IndentBlankLine3\21IndentBlankLine4\21IndentBlankLine5\21IndentBlankLine6\21IndentBlankLine7\21IndentBlankLine8)indent_blankline_char_highlight_list\1\b\0\0\thelp\ttext\14which_key\bfzf\vpacker\tyaml\rNvimTree&indent_blankline_filetype_exclude\6 \26indent_blankline_char-indent_blankline_show_first_indent_level\6g\bvim\0", "config", "indent-blankline.nvim")
-- Config for: nvim-tree.lua
try_loadstring("\27LJ\2\n6\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\25nvim_tree_auto_close\6g\bvim\0", "config", "nvim-tree.lua")
-- Config for: vim-sandwich
try_loadstring("\27LJ\2\n˛\5\0\0\6\0\29\0A6\0\0\0009\0\1\0004\1\4\0005\2\4\0005\3\3\0=\3\5\2>\2\1\0015\2\a\0005\3\6\0=\3\5\2>\2\2\0015\2\t\0005\3\b\0=\3\5\2>\2\3\1=\1\2\0006\0\0\0009\0\1\0004\1\4\0005\2\f\0005\3\v\0=\3\5\2>\2\1\0015\2\14\0005\3\r\0=\3\5\2>\2\2\0015\2\16\0005\3\15\0=\3\5\2>\2\3\1=\1\n\0006\0\0\0009\0\17\0009\0\18\0'\2\19\0'\3\20\0'\4\21\0005\5\22\0B\0\5\0016\0\0\0009\0\17\0009\0\18\0'\2\23\0'\3\20\0'\4\21\0005\5\24\0B\0\5\0016\0\0\0009\0\17\0009\0\18\0'\2\19\0'\3\25\0'\4\26\0005\5\27\0B\0\5\0016\0\0\0009\0\17\0009\0\18\0'\2\23\0'\3\25\0'\4\26\0005\5\28\0B\0\5\1K\0\1\0\1\0\2\texpr\2\vsilent\2\1\0\2\texpr\2\vsilent\2;textobj#sandwich#auto('o', 'i', {}, g:sandwich_braces)\aij\1\0\2\texpr\2\vsilent\2\6x\1\0\2\texpr\2\vsilent\2;textobj#sandwich#auto('o', 'i', {}, g:sandwich_quotes)\aiq\6o\20nvim_set_keymap\bapi\1\0\1\fnesting\3\1\1\3\0\0\a{ \a }\1\0\1\fnesting\3\1\1\3\0\0\6[\6]\1\0\1\fnesting\3\1\1\3\0\0\6(\6)\20sandwich_braces\1\0\4\rlinewise\3\0\fnesting\3\0\17expand_range\3\0\16quoteescape\3\1\1\3\0\0\6`\6`\1\0\4\rlinewise\3\0\fnesting\3\0\17expand_range\3\0\16quoteescape\3\1\1\3\0\0\6'\6'\tbuns\1\0\4\rlinewise\3\0\fnesting\3\0\17expand_range\3\0\16quoteescape\3\1\1\3\0\0\6\"\6\"\20sandwich_quotes\6g\bvim\0", "config", "vim-sandwich")
-- Conditional loads
if try_loadstring("\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\v\0\0\0X\0\2Ä+\0\1\0X\1\1Ä+\0\2\0L\0\2\0\tTMUX\benv\bvim\0", "condition", '{ "vim-tmux-navigator", "vimux" }') then
	vim.cmd [[packadd vim-tmux-navigator]]
		vim.cmd [[packadd vimux]]
end


-- Command lazy-loads
vim.cmd [[command! -nargs=* -range -bang -complete=file AnyJumpVisual lua require("packer.load")({'any-jump.vim'}, { cmd = "AnyJumpVisual", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file FloatermNew lua require("packer.load")({'vim-floaterm'}, { cmd = "FloatermNew", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file SwitchReverse lua require("packer.load")({'switch.vim'}, { cmd = "SwitchReverse", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file SidewaysRight lua require("packer.load")({'sideways.vim'}, { cmd = "SidewaysRight", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file SplitjoinSplit lua require("packer.load")({'splitjoin.vim'}, { cmd = "SplitjoinSplit", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file SplitjoinJoin lua require("packer.load")({'splitjoin.vim'}, { cmd = "SplitjoinJoin", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file ArgWrap lua require("packer.load")({'vim-argwrap'}, { cmd = "ArgWrap", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file SidewaysLeft lua require("packer.load")({'sideways.vim'}, { cmd = "SidewaysLeft", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Xtract lua require("packer.load")({'vim-xtract'}, { cmd = "Xtract", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file GitMessenger lua require("packer.load")({'git-messenger.vim'}, { cmd = "GitMessenger", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Switch lua require("packer.load")({'switch.vim'}, { cmd = "Switch", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Sayonara lua require("packer.load")({'vim-sayonara'}, { cmd = "Sayonara", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file SidewaysJumpLeft lua require("packer.load")({'sideways.vim'}, { cmd = "SidewaysJumpLeft", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file SidewaysJumpRight lua require("packer.load")({'sideways.vim'}, { cmd = "SidewaysJumpRight", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Deleft lua require("packer.load")({'deleft.vim'}, { cmd = "Deleft", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file AnyJump lua require("packer.load")({'any-jump.vim'}, { cmd = "AnyJump", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]

-- Keymap lazy-loads
vim.cmd [[noremap <silent> <Plug>SidewaysArgumentInsertFirst <cmd>lua require("packer.load")({'sideways.vim'}, { keys = "<lt>Plug>SidewaysArgumentInsertFirst", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>(gh-line-blame) <cmd>lua require("packer.load")({'vim-gh-line'}, { keys = "<lt>Plug>(gh-line-blame)", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>(git-messenger) <cmd>lua require("packer.load")({'git-messenger.vim'}, { keys = "<lt>Plug>(git-messenger)", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>SidewaysArgumentTextobjI <cmd>lua require("packer.load")({'sideways.vim'}, { keys = "<lt>Plug>SidewaysArgumentTextobjI", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>SidewaysArgumentAppendAfter <cmd>lua require("packer.load")({'sideways.vim'}, { keys = "<lt>Plug>SidewaysArgumentAppendAfter", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>(LiveEasyAlign) <cmd>lua require("packer.load")({'vim-easy-align'}, { keys = "<lt>Plug>(LiveEasyAlign)", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>SidewaysArgumentTextobjA <cmd>lua require("packer.load")({'sideways.vim'}, { keys = "<lt>Plug>SidewaysArgumentTextobjA", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>(esearch) <cmd>lua require("packer.load")({'vim-esearch'}, { keys = "<lt>Plug>(esearch)", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>(EasyAlign) <cmd>lua require("packer.load")({'vim-easy-align'}, { keys = "<lt>Plug>(EasyAlign)", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>(gh-line) <cmd>lua require("packer.load")({'vim-gh-line'}, { keys = "<lt>Plug>(gh-line)", prefix = "" }, _G.packer_plugins)<cr>]]

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
vim.cmd [[au FileType ruby ++once lua require("packer.load")({'rails_extra.vim'}, { ft = "ruby" }, _G.packer_plugins)]]
vim.cmd [[au FileType eruby ++once lua require("packer.load")({'rails_extra.vim'}, { ft = "eruby" }, _G.packer_plugins)]]
vim.cmd [[au FileType slim ++once lua require("packer.load")({'rails_extra.vim'}, { ft = "slim" }, _G.packer_plugins)]]
vim.cmd [[au FileType haml ++once lua require("packer.load")({'rails_extra.vim'}, { ft = "haml" }, _G.packer_plugins)]]
vim.cmd [[au FileType rspec ++once lua require("packer.load")({'rails_extra.vim'}, { ft = "rspec" }, _G.packer_plugins)]]
vim.cmd("augroup END")
END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
