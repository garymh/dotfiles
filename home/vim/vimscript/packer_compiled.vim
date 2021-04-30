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
  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time("Luarocks path setup", true)
local package_path_str = "/Users/gary/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/gary/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/gary/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/gary/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/gary/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time("Luarocks path setup", false)
time("try_loadstring definition", true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

time("try_loadstring definition", false)
time("Defining packer_plugins", true)
_G.packer_plugins = {
  ["BetterLua.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/opt/BetterLua.vim"
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
    config = { "\27LJ\2\n¥\a\0\0\2\0\20\00196\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\0\0009\0\1\0)\1\0\0=\1\4\0006\0\0\0009\0\1\0)\1\5\0=\1\5\0006\0\0\0009\0\1\0)\1\a\0=\1\6\0006\0\0\0009\0\1\0'\1\b\0=\1\a\0006\0\0\0009\0\1\0'\1\n\0=\1\t\0006\0\0\0009\0\1\0*\1\0\0=\1\v\0006\0\0\0009\0\1\0*\1\0\0=\1\f\0006\0\0\0009\0\1\0)\1\4\0=\1\r\0006\0\0\0009\0\1\0)\1\1\0=\1\14\0006\0\0\0009\0\1\0)\1\1\0=\1\15\0006\0\0\0009\0\1\0'\1\17\0=\1\16\0006\0\0\0009\0\1\0005\1\19\0=\1\18\0K\0\1\0\1\0\r\17more_explain\fComment\16more_button\rOperator\15group_name\rFunction\15group_text\fComment\16result_path\vString\20heading_keyword\15Identifier\17heading_text\rFunction\thelp\vString\20preview_keyword\rOperator\fpreview\fComment\15plain_text\fComment\16result_text\14Statement\23result_line_number\fComment\20any_jump_colors\tword'any_jump_keyword_match_cursor_mode*any_jump_remove_comments_from_results)any_jump_disable_default_keybindings\31any_jump_window_top_offset!any_jump_window_height_ratio any_jump_window_width_ratio\19filename_first\30any_jump_results_ui_style\arg$any_jump_search_prefered_engine any_jump_max_search_results!any_jump_preview_lines_count\30any_jump_grouping_enabled any_jump_references_enabled\26any_jump_list_numbers\6g\bvimµÊÃô\19ô≥¶ˇ\3\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/opt/any-jump.vim"
  },
  ["beacon.nvim"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/beacon.nvim"
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
    config = { "\27LJ\2\n–\4\0\0\4\0\b\0\0156\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\4\0006\0\0\0009\0\5\0009\0\6\0'\2\a\0+\3\1\0B\0\3\1K\0\1\0º\3              function! GitMessengerPopup() abort\n              nmap <buffer><C-o> o\n              nmap <buffer><C-i> O\n              nmap <silent><buffer>j :GitMessengerClose<CR>\n              nmap <silent><buffer>k :GitMessengerClose<CR>\n              endfunction\n\n              augroup GitMessenger\n              autocmd!\n              autocmd FileType gitmessengerpopup call GitMessengerPopup()\n              augroup END\n              \14nvim_exec\bapi$git_messenger_always_into_popup\tnone\31git_messenger_include_diff\6g\bvim\0" },
    keys = { { "", "<Plug>(git-messenger)" } },
    loaded = false,
    needs_bufread = false,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/opt/git-messenger.vim"
  },
  ["glow.nvim"] = {
    commands = { "Glow" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/opt/glow.nvim"
  },
  ["gx-extended.vim"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/gx-extended.vim"
  },
  ["lens.vim"] = {
    config = { "\27LJ\2\nà\1\0\0\4\0\6\0\r6\0\0\0009\0\1\0009\0\2\0'\2\3\0005\3\4\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\5\0)\3\0\0B\0\3\1K\0\1\0\17lens#animate\1\4\0\0\thelp\bfzf\nvista\28lens#disabled_filetypes\17nvim_set_var\bapi\bvim\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/lens.vim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n\31\0\1\6\0\1\0\5\18\3\0\0009\1\0\0)\4\1\0)\5\15\0D\1\4\0\bsubV\0\1\a\0\4\0\0156\1\0\0009\1\1\1\18\3\0\0'\4\2\0+\5\0\0+\6\2\0B\1\5\2\15\0\1\0X\2\3Ä'\1\3\0L\1\2\0X\1\2Ä+\1\0\0L\1\2\0K\0\1\0\aEE\bee/\tfind\vstringí\5\1\0\b\0$\0=6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\3=\3\t\0025\3\r\0004\4\3\0005\5\n\0003\6\v\0=\6\f\5>\5\1\4=\4\14\0034\4\3\0005\5\15\0005\6\17\0003\a\16\0=\a\f\6>\6\2\5>\5\1\0045\5\18\0>\5\2\4=\4\19\0034\4\0\0=\4\20\0034\4\3\0005\5\21\0>\5\1\4=\4\22\0034\4\3\0005\5\23\0005\6\24\0=\6\25\5>\5\1\4=\4\26\0035\4\27\0=\4\28\3=\3\29\0025\3\30\0004\4\0\0=\4\14\0034\4\0\0=\4\19\0035\4\31\0=\4\20\0035\4 \0=\4\22\0034\4\0\0=\4\26\0034\4\0\0=\4\28\3=\3!\0025\3\"\0=\3#\2B\0\2\1K\0\1\0\15extensions\1\3\0\0\bfzf\14nvim-tree\22inactive_sections\1\2\0\0\rlocation\1\2\0\0\rfilename\1\0\0\rsections\14lualine_z\1\2\0\0\rlocation\14lualine_y\fsources\1\2\0\0\bale\1\2\0\0\16diagnostics\14lualine_x\1\2\0\0\tdiff\14lualine_c\14lualine_b\1\2\0\0\rfilename\1\0\2\ncolor\rErrorMsg\14full_path\2\0\1\2\0\0\rfilename\14lualine_a\1\0\0\vformat\0\1\2\0\0\vbranch\foptions\1\0\0\25component_separators\1\3\0\0\5\5\23section_separators\1\3\0\0\5\5\1\0\3\18icons_enabled\2\fpadding\3\2\ntheme\15tokyonight\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  mkdx = {
    config = { "\27LJ\2\n·\2\0\0\6\0\23\0\0256\0\0\0009\0\1\0009\0\2\0'\2\3\0005\3\5\0005\4\4\0=\4\6\0035\4\b\0005\5\a\0=\5\t\4=\4\n\0035\4\v\0=\4\f\0035\4\14\0005\5\r\0=\5\15\4=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\0035\4\21\0=\4\22\3B\0\3\1K\0\1\0\bmap\1\0\1\vprefix\19<localleader>m\tfold\1\0\1\venable\3\1\btoc\1\0\2\ttext\22Table of Contents\20update_on_write\3\1\nlinks\rexternal\1\0\0\1\0\1\venable\3\1\nenter\1\0\1\nshift\3\1\rcheckbox\ftoggles\1\0\0\1\3\0\0\6 \6x\14highlight\1\0\1\19restore_visual\3\1\1\0\1\venable\3\1\18mkdx#settings\17nvim_set_var\bapi\bvim\0" },
    loaded = false,
    needs_bufread = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/opt/mkdx"
  },
  ["multichange.vim"] = {
    config = { "\27LJ\2\ne\0\0\2\0\6\0\t6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0K\0\1\0\6m\31multichange_motion_mapping\asm\24multichange_mapping\6g\bvim\0" },
    keys = { { "", "sm" }, { "", "smm" } },
    loaded = false,
    needs_bufread = false,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/opt/multichange.vim"
  },
  neoformat = {
    commands = { "Neoformat" },
    config = { "\27LJ\2\nN\0\0\2\0\4\0\0056\0\0\0009\0\1\0005\1\3\0=\1\2\0K\0\1\0\1\0\1\bexe\15lua-format\31neoformat_lua_luaformatter\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/opt/neoformat"
  },
  ["neoscroll.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14neoscroll\frequire\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/neoscroll.nvim"
  },
  ["nvim-block-paste"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/nvim-block-paste"
  },
  ["nvim-bufferline.lua"] = {
    config = { "\27LJ\2\n˘\2\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\foptions\1\0\0\1\0\15\18modified_icon\b‚óè\rmappings\1\22buffer_close_icon\bÔôï\fsort_by\23relative_directory\17number_style\16superscript\28show_buffer_close_icons\1\fnumbers\14buffer_id\22max_prefix_length\3\15\tview\16multiwindow\rtab_size\3\18\23right_trunc_marker\bÔÇ©\27always_show_bufferline\1\22left_trunc_marker\bÔÇ®\20max_name_length\3\18\15close_icon\bÔÄç\nsetup\15bufferline\frequire\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/nvim-bufferline.lua"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-compe"] = {
    config = { "\27LJ\2\nF\0\1\a\0\3\0\b6\1\0\0009\1\1\0019\1\2\1\18\3\0\0+\4\2\0+\5\2\0+\6\2\0D\1\5\0\27nvim_replace_termcodes\bapi\bvim£\1\0\0\6\0\b\2\0306\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\2\23\0\0\0\b\0\1\0X\1\16Ä6\1\0\0009\1\1\0019\1\4\1'\3\3\0B\1\2\2\18\3\1\0009\1\5\1\18\4\0\0\18\5\0\0B\1\4\2\18\3\1\0009\1\6\1'\4\a\0B\1\3\2\15\0\1\0X\2\3Ä+\1\2\0L\1\2\0X\1\2Ä+\1\1\0L\1\2\0K\0\1\0\a%s\nmatch\bsub\fgetline\6.\bcol\afn\bvim\2\0˝\1\0\0\4\2\n\1#6\0\0\0009\0\1\0009\0\2\0B\0\1\2\t\0\0\0X\0\16Ä6\0\0\0009\0\1\0009\0\3\0'\2\4\0005\3\5\0B\0\3\2\t\0\0\0X\0\4Ä-\0\0\0'\2\6\0D\0\2\0X\0\16Ä-\0\0\0'\2\a\0D\0\2\0X\0\fÄ-\0\1\0B\0\1\2\15\0\0\0X\1\4Ä-\0\0\0'\2\b\0D\0\2\0X\0\4Ä6\0\0\0009\0\1\0009\0\t\0D\0\1\0K\0\1\0\0¿\1¿\19compe#complete\n<Tab>\n<C-n>!<Plug>(vsnip-expand-or-jump)\1\2\0\0\3\1\20vsnip#available\tcall\15pumvisible\afn\bvim\2»\1\0\0\4\1\t\1\0266\0\0\0009\0\1\0009\0\2\0B\0\1\2\t\0\0\0X\0\4Ä-\0\0\0'\2\3\0D\0\2\0X\0\15Ä6\0\0\0009\0\1\0009\0\4\0'\2\5\0005\3\6\0B\0\3\2\t\0\0\0X\0\4Ä-\0\0\0'\2\a\0D\0\2\0X\0\3Ä-\0\0\0'\2\b\0D\0\2\0K\0\1\0\0¿\f<S-Tab>\28<Plug>(vsnip-jump-prev)\1\2\0\0\3ˇˇˇˇ\15\19vsnip#jumpable\tcall\n<C-p>\15pumvisible\afn\bvim\2ò\5\1\0\b\0\26\00026\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\0013\0\6\0003\1\a\0006\2\b\0003\3\n\0=\3\t\0026\2\b\0003\3\f\0=\3\v\0026\2\r\0009\2\14\0029\2\15\2'\4\16\0'\5\17\0'\6\18\0005\a\19\0B\2\5\0016\2\r\0009\2\14\0029\2\15\2'\4\20\0'\5\17\0'\6\18\0005\a\21\0B\2\5\0016\2\r\0009\2\14\0029\2\15\2'\4\16\0'\5\22\0'\6\23\0005\a\24\0B\2\5\0016\2\r\0009\2\14\0029\2\15\2'\4\20\0'\5\22\0'\6\23\0005\a\25\0B\2\5\0012\0\0ÄK\0\1\0\1\0\1\texpr\2\1\0\1\texpr\2\27v:lua.s_tab_complete()\f<S-Tab>\1\0\1\texpr\2\6s\1\0\1\texpr\2\25v:lua.tab_complete()\n<Tab>\6i\20nvim_set_keymap\bapi\bvim\0\19s_tab_complete\0\17tab_complete\a_G\0\0\vsource\1\0\n\nspell\2\15treesitter\2\18snippets_nvim\1\ttags\2\rnvim_lua\1\rnvim_lsp\1\nvsnip\2\tcalc\2\vbuffer\2\tpath\2\1\0\f\14preselect\venable\15min_length\3\1\17autocomplete\2\fenabled\2\ndebug\1\18documentation\2\19max_menu_width\3d\19max_kind_width\3d\19max_abbr_width\3d\21incomplete_delay\3ê\3\19source_timeout\3»\1\18throttle_time\3P\nsetup\ncompe\frequire\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-hlslens"] = {
    config = { "\27LJ\2\nT\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\14calm_down\2\16auto_enable\2\nsetup\fhlslens\frequire\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/nvim-hlslens"
  },
  ["nvim-tree.lua"] = {
    commands = { "NvimTreeToggle", "NvimTreeFindFile" },
    config = { "\27LJ\2\n6\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\25nvim_tree_auto_close\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/opt/nvim-tree.lua"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["rails_extra.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/opt/rails_extra.vim"
  },
  ["sideways.vim"] = {
    keys = { { "", "<Plug>SidewaysArgumentAppendAfter" }, { "", "<Plug>SidewaysArgumentInsertFirst" }, { "", "<Plug>SidewaysArgumentTextobjA" }, { "", "<Plug>SidewaysArgumentTextobjI" } },
    loaded = false,
    needs_bufread = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/opt/sideways.vim"
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
  ["tokyodark.nvim"] = {
    config = { "\27LJ\2\nk\0\0\2\0\4\0\t6\0\0\0009\0\1\0+\1\2\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\3\0K\0\1\0%tokyonight_enable_italic_comment\29tokyonight_enable_italic\6g\bvim\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/tokyodark.nvim"
  },
  ["tokyonight.nvim"] = {
    config = { "\27LJ\2\n`\0\0\2\0\5\0\t6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\4\0K\0\1\0\28tokyonight_dark_sidebar\nnight\21tokyonight_style\6g\bvim\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/tokyonight.nvim"
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
    config = { "\27LJ\2\n2\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\21CoolTotalMatches\6g\bvim\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-cool"
  },
  ["vim-easy-align"] = {
    config = { "\27LJ\2\nê\3\0\0\4\0\18\0\0236\0\0\0009\0\1\0005\1\6\0005\2\3\0005\3\4\0=\3\5\2=\2\a\0015\2\b\0=\2\t\0015\2\n\0005\3\v\0=\3\5\2=\2\f\0015\2\r\0=\2\14\0015\2\15\0=\2\16\1=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\17\0K\0\1\0\27easy_align_bypass_fold\6]\1\0\4\16left_margin\3\0\17right_margin\3\0\18stick_to_left\3\0\fpattern\n[[\\]]\6(\1\0\3\17right_margin\3\0\20delimiter_align\6l\fpattern\6(\6;\1\2\0\0\r!Comment\1\0\2\20delimiter_align\6l\fpattern\6;\6\\\1\0\1\fpattern\a\\$\6/\1\0\0\18ignore_groups\1\2\0\0\r!Comment\1\0\2\20delimiter_align\6l\fpattern\19//\\+\\|/\\*\\|\\*/\26easy_align_delimiters\6g\bvim\0" },
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
    config = { "\27LJ\2\nù\f\0\0\5\0(\0M6\0\0\0009\0\1\0005\1\3\0004\2\"\0005\3\4\0005\4\5\0>\4\4\3>\3\1\0025\3\6\0>\3\2\0025\3\a\0>\3\3\0025\3\b\0>\3\4\0025\3\t\0>\3\5\0025\3\n\0>\3\6\0025\3\v\0>\3\a\0025\3\f\0>\3\b\0025\3\r\0>\3\t\0025\3\14\0>\3\n\0025\3\15\0>\3\v\0025\3\16\0>\3\f\0025\3\17\0>\3\r\0025\3\18\0>\3\14\0025\3\19\0>\3\15\0025\3\20\0>\3\16\0025\3\21\0>\3\17\0025\3\22\0>\3\18\0025\3\23\0005\4\24\0>\4\4\3>\3\19\0025\3\25\0>\3\20\0025\3\26\0>\3\21\0025\3\27\0>\3\22\0025\3\28\0>\3\23\0025\3\29\0>\3\24\0025\3\30\0>\3\25\0025\3\31\0>\3\26\0025\3 \0>\3\27\0025\3!\0>\3\28\0025\3\"\0>\3\29\0025\3#\0>\3\30\0025\3$\0>\3\31\0025\3%\0>\3 \0025\3&\0>\3!\2=\2'\1=\1\2\0K\0\1\0\fwin_map\1\4\0\0\6n\azM\23<plug>(esearch-zM)\1\4\0\0\6n\azc\23<plug>(esearch-zc)\1\4\0\0\6n\aza\23<plug>(esearch-za)\1\4\0\0\6n\a@:\23<plug>(esearch-@:)\1\4\0\0\6n\6.\22<plug>(esearch-.)\1\4\0\0\6x\6s\22<plug>(esearch-c)\1\4\0\0\anx\6D\22<plug>(esearch-D)\1\4\0\0\anx\6C\22<plug>(esearch-C)\1\4\0\0\6n\acc\23<plug>(esearch-cc)\1\4\0\0\anx\6c\22<plug>(esearch-c)\1\4\0\0\6n\add\23<plug>(esearch-dd)\1\4\0\0\anx\6d\22<plug>(esearch-d)\1\4\0\0\6x\6x\22<plug>(esearch-d)\1\4\0\0\6n\6I\22<plug>(esearch-I)\1\0\1\vnowait\3\1\1\4\0\0\aic\t<cr>\23<plug>(esearch-cr)\1\4\0\0\aov\aam$<plug>(textobj-esearch-match-a)\1\4\0\0\aov\aim$<plug>(textobj-esearch-match-i)\1\4\0\0\6 \6((<plug>(esearch-win-jump:dirname:up)\1\4\0\0\6 \6)*<plug>(esearch-win-jump:dirname:down)\1\4\0\0\6 \6{)<plug>(esearch-win-jump:filename:up)\1\4\0\0\6 \6}+<plug>(esearch-win-jump:filename:down)\1\4\0\0\6 \6K&<plug>(esearch-win-jump:entry:up)\1\4\0\0\6 \6J(<plug>(esearch-win-jump:entry:down)\1\4\0\0\6n\n<esc>&<plug>(esearch-win-preview:close)\1\4\0\0\6n\6P)100<plug>(esearch-win-preview:enter)\1\4\0\0\6n\6p <plug>(esearch-win-preview)\1\4\0\0\6n\t<cr>\29<plug>(esearch-win-open)\1\4\0\0\6n\6S*<plug>(esearch-win-vsplit:reuse:stay)\1\4\0\0\6n\6s\31<plug>(esearch-win-vsplit)\1\4\0\0\6n\6T%<plug>(esearch-win-tabopen:stay)\1\4\0\0\6n\6t <plug>(esearch-win-tabopen)\1\4\0\0\6n\6R\31<plug>(esearch-win-reload)\1\0\1\vnowait\3\1\1\4\0\0\6n\6o\29<plug>(esearch-win-open)\1\0\4\fbackend\tnvim\nafter\3\1\vbefore\3\1\21default_mappings\3\0\fesearch\6g\bvim\0" },
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
    commands = { "FloatermNew", "FloatermToggle" },
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
  ["vim-gitgutter"] = {
    config = { "\27LJ\2\n—\3\0\0\2\0\15\0-6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\3\0=\1\4\0006\0\0\0009\0\1\0'\1\3\0=\1\5\0006\0\0\0009\0\1\0'\1\3\0=\1\6\0006\0\0\0009\0\1\0'\1\3\0=\1\a\0006\0\0\0009\0\1\0)\1\0\0=\1\b\0006\0\0\0009\0\1\0)\1\1\0=\1\t\0006\0\0\0009\0\1\0)\1\0\0=\1\n\0006\0\0\0009\0\1\0)\1\0\0=\1\v\0006\0\0\0009\0\1\0'\1\r\0=\1\f\0006\0\0\0009\0\1\0)\1\1\0=\1\14\0K\0\1\0#gitgutter_preview_win_floating\arg\19gitgutter_grep\20gitgutter_eager\23gitgutter_realtime#gitgutter_set_sign_backgrounds\23gitgutter_map_keys$gitgutter_sign_modified_removed&gitgutter_sign_removed_first_line\27gitgutter_sign_removed\28gitgutter_sign_modified\b‚îÇ\25gitgutter_sign_added\6g\bvim\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-gitgutter"
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
  ["vim-projectionist"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-projectionist"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-repo-edit"] = {
    commands = { "RepoEdit" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/opt/vim-repo-edit"
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
    config = { "\27LJ\2\n˛\5\0\0\6\0\29\0A6\0\0\0009\0\1\0004\1\4\0005\2\4\0005\3\3\0=\3\5\2>\2\1\0015\2\a\0005\3\6\0=\3\5\2>\2\2\0015\2\t\0005\3\b\0=\3\5\2>\2\3\1=\1\2\0006\0\0\0009\0\1\0004\1\4\0005\2\f\0005\3\v\0=\3\5\2>\2\1\0015\2\14\0005\3\r\0=\3\5\2>\2\2\0015\2\16\0005\3\15\0=\3\5\2>\2\3\1=\1\n\0006\0\0\0009\0\17\0009\0\18\0'\2\19\0'\3\20\0'\4\21\0005\5\22\0B\0\5\0016\0\0\0009\0\17\0009\0\18\0'\2\23\0'\3\20\0'\4\21\0005\5\24\0B\0\5\0016\0\0\0009\0\17\0009\0\18\0'\2\19\0'\3\25\0'\4\26\0005\5\27\0B\0\5\0016\0\0\0009\0\17\0009\0\18\0'\2\23\0'\3\25\0'\4\26\0005\5\28\0B\0\5\1K\0\1\0\1\0\2\vsilent\2\texpr\2\1\0\2\vsilent\2\texpr\2;textobj#sandwich#auto('o', 'i', {}, g:sandwich_braces)\aij\1\0\2\vsilent\2\texpr\2\6x\1\0\2\vsilent\2\texpr\2;textobj#sandwich#auto('o', 'i', {}, g:sandwich_quotes)\aiq\6o\20nvim_set_keymap\bapi\1\0\1\fnesting\3\1\1\3\0\0\a{ \a }\1\0\1\fnesting\3\1\1\3\0\0\6[\6]\1\0\1\fnesting\3\1\1\3\0\0\6(\6)\20sandwich_braces\1\0\4\rlinewise\3\0\fnesting\3\0\17expand_range\3\0\16quoteescape\3\1\1\3\0\0\6`\6`\1\0\4\rlinewise\3\0\fnesting\3\0\17expand_range\3\0\16quoteescape\3\1\1\3\0\0\6'\6'\tbuns\1\0\4\rlinewise\3\0\fnesting\3\0\17expand_range\3\0\16quoteescape\3\1\1\3\0\0\6\"\6\"\20sandwich_quotes\6g\bvim\0" },
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
  ["vim-startuptime"] = {
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/vim-startuptime"
  },
  ["vim-test"] = {
    commands = { "TestNearest", "TestFile", "TestVisit", "TestLast" },
    config = { "\27LJ\2\n∏\3\0\0\4\0\f\0\0316\0\0\0009\0\1\0009\0\2\0'\2\3\0)\3\1\0B\0\3\0016\0\0\0009\0\1\0009\0\4\0'\2\5\0+\3\1\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\6\0'\3\a\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\b\0005\3\t\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\n\0'\3\v\0B\0\3\1K\0\1\0\30ENABLE_SPRING=1 bin/rspec\31test#ruby#rspec#executable\1\0\2\fnearest0--format progress --force-color --fail-fast\tfile5--format documentation --force-color --fail-fast\28test#ruby#rspec#options\18gary_terminal\18test#strategy/source $DOTFILES/home/vim/lua/vim-test.vim\14nvim_exec\25test#preserve_screen\17nvim_set_var\bapi\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/opt/vim-test"
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
  ["vim-xtract"] = {
    commands = { "Xtract" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/opt/vim-xtract"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\ná\4\0\0\5\0\26\0\0296\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\3\0005\4\4\0=\4\5\3=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\0025\3\f\0005\4\r\0=\4\14\0035\4\15\0=\4\16\3=\3\17\0025\3\19\0005\4\18\0=\4\20\0035\4\21\0=\4\22\3=\3\23\0025\3\24\0=\3\25\2B\0\2\1K\0\1\0\vhidden\1\t\0\0\r<silent>\n<cmd>\n<Cmd>\t<CR>\tcall\blua\a^:\a^ \vlayout\nwidth\1\0\2\bmin\3\20\bmax\0032\vheight\1\0\1\fspacing\3\3\1\0\2\bmin\3\4\bmax\3\25\vwindow\fpadding\1\5\0\0\3\2\3\2\3\2\3\2\vmargin\1\5\0\0\3\1\3\0\3\1\3\0\1\0\2\rposition\vbottom\vborder\vshadow\nicons\1\0\3\14separator\b‚ûú\ngroup\6+\15breadcrumb\a¬ª\14operators\1\0\1\agc\rComments\fplugins\1\0\1\14show_help\1\fpresets\1\0\a\6g\2\6z\2\bnav\2\fwindows\2\17text_objects\2\fmotions\2\14operators\2\1\0\2\14registers\2\nmarks\2\nsetup\14which-key\frequire\0" },
    loaded = true,
    path = "/Users/gary/.local/share/nvim/site/pack/packer/start/which-key.nvim"
  }
}

time("Defining packer_plugins", false)
-- Config for: vim-cool
time("Config for vim-cool", true)
try_loadstring("\27LJ\2\n2\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\21CoolTotalMatches\6g\bvim\0", "config", "vim-cool")
time("Config for vim-cool", false)
-- Config for: vim-rooter
time("Config for vim-rooter", true)
try_loadstring("\27LJ\2\nö\3\0\0\2\0\t\0\0216\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\0\0009\0\1\0)\1\1\0=\1\4\0006\0\0\0009\0\1\0005\1\6\0=\1\5\0006\0\0\0009\0\1\0'\1\b\0=\1\a\0K\0\1\0\fcurrent2rooter_change_directory_for_non_project_files\1\19\0\0\t.env\15.gitignore\19.gitattributes\17.styleci.yml\16_ide_helper\18composer.json\18composer.lock\17package.json\14README.md\18.editorconfig\t.git\n.git/\f_darcs/\t.hg/\n.bzr/\n.svn/\18node_modules/\fGemfile\20rooter_patterns\25rooter_resolve_links\24rooter_silent_chdir\23rooter_disable_map\6g\bvim\0", "config", "vim-rooter")
time("Config for vim-rooter", false)
-- Config for: gx-extended.vim
time("Config for gx-extended.vim", true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "gx-extended.vim")
time("Config for gx-extended.vim", false)
-- Config for: lens.vim
time("Config for lens.vim", true)
try_loadstring("\27LJ\2\nà\1\0\0\4\0\6\0\r6\0\0\0009\0\1\0009\0\2\0'\2\3\0005\3\4\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\5\0)\3\0\0B\0\3\1K\0\1\0\17lens#animate\1\4\0\0\thelp\bfzf\nvista\28lens#disabled_filetypes\17nvim_set_var\bapi\bvim\0", "config", "lens.vim")
time("Config for lens.vim", false)
-- Config for: vim-sandwich
time("Config for vim-sandwich", true)
try_loadstring("\27LJ\2\n˛\5\0\0\6\0\29\0A6\0\0\0009\0\1\0004\1\4\0005\2\4\0005\3\3\0=\3\5\2>\2\1\0015\2\a\0005\3\6\0=\3\5\2>\2\2\0015\2\t\0005\3\b\0=\3\5\2>\2\3\1=\1\2\0006\0\0\0009\0\1\0004\1\4\0005\2\f\0005\3\v\0=\3\5\2>\2\1\0015\2\14\0005\3\r\0=\3\5\2>\2\2\0015\2\16\0005\3\15\0=\3\5\2>\2\3\1=\1\n\0006\0\0\0009\0\17\0009\0\18\0'\2\19\0'\3\20\0'\4\21\0005\5\22\0B\0\5\0016\0\0\0009\0\17\0009\0\18\0'\2\23\0'\3\20\0'\4\21\0005\5\24\0B\0\5\0016\0\0\0009\0\17\0009\0\18\0'\2\19\0'\3\25\0'\4\26\0005\5\27\0B\0\5\0016\0\0\0009\0\17\0009\0\18\0'\2\23\0'\3\25\0'\4\26\0005\5\28\0B\0\5\1K\0\1\0\1\0\2\vsilent\2\texpr\2\1\0\2\vsilent\2\texpr\2;textobj#sandwich#auto('o', 'i', {}, g:sandwich_braces)\aij\1\0\2\vsilent\2\texpr\2\6x\1\0\2\vsilent\2\texpr\2;textobj#sandwich#auto('o', 'i', {}, g:sandwich_quotes)\aiq\6o\20nvim_set_keymap\bapi\1\0\1\fnesting\3\1\1\3\0\0\a{ \a }\1\0\1\fnesting\3\1\1\3\0\0\6[\6]\1\0\1\fnesting\3\1\1\3\0\0\6(\6)\20sandwich_braces\1\0\4\rlinewise\3\0\fnesting\3\0\17expand_range\3\0\16quoteescape\3\1\1\3\0\0\6`\6`\1\0\4\rlinewise\3\0\fnesting\3\0\17expand_range\3\0\16quoteescape\3\1\1\3\0\0\6'\6'\tbuns\1\0\4\rlinewise\3\0\fnesting\3\0\17expand_range\3\0\16quoteescape\3\1\1\3\0\0\6\"\6\"\20sandwich_quotes\6g\bvim\0", "config", "vim-sandwich")
time("Config for vim-sandwich", false)
-- Config for: tokyodark.nvim
time("Config for tokyodark.nvim", true)
try_loadstring("\27LJ\2\nk\0\0\2\0\4\0\t6\0\0\0009\0\1\0+\1\2\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\3\0K\0\1\0%tokyonight_enable_italic_comment\29tokyonight_enable_italic\6g\bvim\0", "config", "tokyodark.nvim")
time("Config for tokyodark.nvim", false)
-- Config for: lualine.nvim
time("Config for lualine.nvim", true)
try_loadstring("\27LJ\2\n\31\0\1\6\0\1\0\5\18\3\0\0009\1\0\0)\4\1\0)\5\15\0D\1\4\0\bsubV\0\1\a\0\4\0\0156\1\0\0009\1\1\1\18\3\0\0'\4\2\0+\5\0\0+\6\2\0B\1\5\2\15\0\1\0X\2\3Ä'\1\3\0L\1\2\0X\1\2Ä+\1\0\0L\1\2\0K\0\1\0\aEE\bee/\tfind\vstringí\5\1\0\b\0$\0=6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\3=\3\t\0025\3\r\0004\4\3\0005\5\n\0003\6\v\0=\6\f\5>\5\1\4=\4\14\0034\4\3\0005\5\15\0005\6\17\0003\a\16\0=\a\f\6>\6\2\5>\5\1\0045\5\18\0>\5\2\4=\4\19\0034\4\0\0=\4\20\0034\4\3\0005\5\21\0>\5\1\4=\4\22\0034\4\3\0005\5\23\0005\6\24\0=\6\25\5>\5\1\4=\4\26\0035\4\27\0=\4\28\3=\3\29\0025\3\30\0004\4\0\0=\4\14\0034\4\0\0=\4\19\0035\4\31\0=\4\20\0035\4 \0=\4\22\0034\4\0\0=\4\26\0034\4\0\0=\4\28\3=\3!\0025\3\"\0=\3#\2B\0\2\1K\0\1\0\15extensions\1\3\0\0\bfzf\14nvim-tree\22inactive_sections\1\2\0\0\rlocation\1\2\0\0\rfilename\1\0\0\rsections\14lualine_z\1\2\0\0\rlocation\14lualine_y\fsources\1\2\0\0\bale\1\2\0\0\16diagnostics\14lualine_x\1\2\0\0\tdiff\14lualine_c\14lualine_b\1\2\0\0\rfilename\1\0\2\ncolor\rErrorMsg\14full_path\2\0\1\2\0\0\rfilename\14lualine_a\1\0\0\vformat\0\1\2\0\0\vbranch\foptions\1\0\0\25component_separators\1\3\0\0\5\5\23section_separators\1\3\0\0\5\5\1\0\3\18icons_enabled\2\fpadding\3\2\ntheme\15tokyonight\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time("Config for lualine.nvim", false)
-- Config for: nvim-colorizer.lua
time("Config for nvim-colorizer.lua", true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time("Config for nvim-colorizer.lua", false)
-- Config for: tokyonight.nvim
time("Config for tokyonight.nvim", true)
try_loadstring("\27LJ\2\n`\0\0\2\0\5\0\t6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\4\0K\0\1\0\28tokyonight_dark_sidebar\nnight\21tokyonight_style\6g\bvim\0", "config", "tokyonight.nvim")
time("Config for tokyonight.nvim", false)
-- Config for: nvim-compe
time("Config for nvim-compe", true)
try_loadstring("\27LJ\2\nF\0\1\a\0\3\0\b6\1\0\0009\1\1\0019\1\2\1\18\3\0\0+\4\2\0+\5\2\0+\6\2\0D\1\5\0\27nvim_replace_termcodes\bapi\bvim£\1\0\0\6\0\b\2\0306\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\2\23\0\0\0\b\0\1\0X\1\16Ä6\1\0\0009\1\1\0019\1\4\1'\3\3\0B\1\2\2\18\3\1\0009\1\5\1\18\4\0\0\18\5\0\0B\1\4\2\18\3\1\0009\1\6\1'\4\a\0B\1\3\2\15\0\1\0X\2\3Ä+\1\2\0L\1\2\0X\1\2Ä+\1\1\0L\1\2\0K\0\1\0\a%s\nmatch\bsub\fgetline\6.\bcol\afn\bvim\2\0˝\1\0\0\4\2\n\1#6\0\0\0009\0\1\0009\0\2\0B\0\1\2\t\0\0\0X\0\16Ä6\0\0\0009\0\1\0009\0\3\0'\2\4\0005\3\5\0B\0\3\2\t\0\0\0X\0\4Ä-\0\0\0'\2\6\0D\0\2\0X\0\16Ä-\0\0\0'\2\a\0D\0\2\0X\0\fÄ-\0\1\0B\0\1\2\15\0\0\0X\1\4Ä-\0\0\0'\2\b\0D\0\2\0X\0\4Ä6\0\0\0009\0\1\0009\0\t\0D\0\1\0K\0\1\0\0¿\1¿\19compe#complete\n<Tab>\n<C-n>!<Plug>(vsnip-expand-or-jump)\1\2\0\0\3\1\20vsnip#available\tcall\15pumvisible\afn\bvim\2»\1\0\0\4\1\t\1\0266\0\0\0009\0\1\0009\0\2\0B\0\1\2\t\0\0\0X\0\4Ä-\0\0\0'\2\3\0D\0\2\0X\0\15Ä6\0\0\0009\0\1\0009\0\4\0'\2\5\0005\3\6\0B\0\3\2\t\0\0\0X\0\4Ä-\0\0\0'\2\a\0D\0\2\0X\0\3Ä-\0\0\0'\2\b\0D\0\2\0K\0\1\0\0¿\f<S-Tab>\28<Plug>(vsnip-jump-prev)\1\2\0\0\3ˇˇˇˇ\15\19vsnip#jumpable\tcall\n<C-p>\15pumvisible\afn\bvim\2ò\5\1\0\b\0\26\00026\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\0013\0\6\0003\1\a\0006\2\b\0003\3\n\0=\3\t\0026\2\b\0003\3\f\0=\3\v\0026\2\r\0009\2\14\0029\2\15\2'\4\16\0'\5\17\0'\6\18\0005\a\19\0B\2\5\0016\2\r\0009\2\14\0029\2\15\2'\4\20\0'\5\17\0'\6\18\0005\a\21\0B\2\5\0016\2\r\0009\2\14\0029\2\15\2'\4\16\0'\5\22\0'\6\23\0005\a\24\0B\2\5\0016\2\r\0009\2\14\0029\2\15\2'\4\20\0'\5\22\0'\6\23\0005\a\25\0B\2\5\0012\0\0ÄK\0\1\0\1\0\1\texpr\2\1\0\1\texpr\2\27v:lua.s_tab_complete()\f<S-Tab>\1\0\1\texpr\2\6s\1\0\1\texpr\2\25v:lua.tab_complete()\n<Tab>\6i\20nvim_set_keymap\bapi\bvim\0\19s_tab_complete\0\17tab_complete\a_G\0\0\vsource\1\0\n\nspell\2\15treesitter\2\18snippets_nvim\1\ttags\2\rnvim_lua\1\rnvim_lsp\1\nvsnip\2\tcalc\2\vbuffer\2\tpath\2\1\0\f\14preselect\venable\15min_length\3\1\17autocomplete\2\fenabled\2\ndebug\1\18documentation\2\19max_menu_width\3d\19max_kind_width\3d\19max_abbr_width\3d\21incomplete_delay\3ê\3\19source_timeout\3»\1\18throttle_time\3P\nsetup\ncompe\frequire\0", "config", "nvim-compe")
time("Config for nvim-compe", false)
-- Config for: nvim-block-paste
time("Config for nvim-block-paste", true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "nvim-block-paste")
time("Config for nvim-block-paste", false)
-- Config for: nvim-hlslens
time("Config for nvim-hlslens", true)
try_loadstring("\27LJ\2\nT\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\14calm_down\2\16auto_enable\2\nsetup\fhlslens\frequire\0", "config", "nvim-hlslens")
time("Config for nvim-hlslens", false)
-- Config for: vim-gitgutter
time("Config for vim-gitgutter", true)
try_loadstring("\27LJ\2\n—\3\0\0\2\0\15\0-6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\3\0=\1\4\0006\0\0\0009\0\1\0'\1\3\0=\1\5\0006\0\0\0009\0\1\0'\1\3\0=\1\6\0006\0\0\0009\0\1\0'\1\3\0=\1\a\0006\0\0\0009\0\1\0)\1\0\0=\1\b\0006\0\0\0009\0\1\0)\1\1\0=\1\t\0006\0\0\0009\0\1\0)\1\0\0=\1\n\0006\0\0\0009\0\1\0)\1\0\0=\1\v\0006\0\0\0009\0\1\0'\1\r\0=\1\f\0006\0\0\0009\0\1\0)\1\1\0=\1\14\0K\0\1\0#gitgutter_preview_win_floating\arg\19gitgutter_grep\20gitgutter_eager\23gitgutter_realtime#gitgutter_set_sign_backgrounds\23gitgutter_map_keys$gitgutter_sign_modified_removed&gitgutter_sign_removed_first_line\27gitgutter_sign_removed\28gitgutter_sign_modified\b‚îÇ\25gitgutter_sign_added\6g\bvim\0", "config", "vim-gitgutter")
time("Config for vim-gitgutter", false)
-- Config for: conflict-marker.vim
time("Config for conflict-marker.vim", true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "conflict-marker.vim")
time("Config for conflict-marker.vim", false)
-- Config for: vim-better-whitespace
time("Config for vim-better-whitespace", true)
try_loadstring("\27LJ\2\nÓ\1\0\0\2\0\a\0\0176\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\0\0009\0\1\0)\1\0\0=\1\4\0006\0\0\0009\0\1\0005\1\6\0=\1\5\0K\0\1\0\1\a\0\0\tdiff\14gitcommit\aqf\thelp\rmarkdown\vpacker*better_whitespace_filetypes_blacklist\29strip_whitespace_confirm\29strip_whitespace_on_save\30better_whitespace_enabled\6g\bvim\0", "config", "vim-better-whitespace")
time("Config for vim-better-whitespace", false)
-- Config for: fzf
time("Config for fzf", true)
try_loadstring("\27LJ\2\n°\1\0\0\2\0\a\0\r6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0005\1\4\0=\1\3\0006\0\0\0009\0\1\0'\1\6\0=\1\5\0K\0\1\0\19ripper-tags -R\21fzf_tags_command\1\3\0\0\21right:50%:hidden\vctrl-/\23fzf_preview_window\21fzf_buffers_jump\6g\bvim\0", "config", "fzf")
time("Config for fzf", false)
-- Config for: neoscroll.nvim
time("Config for neoscroll.nvim", true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14neoscroll\frequire\0", "config", "neoscroll.nvim")
time("Config for neoscroll.nvim", false)
-- Config for: ale
time("Config for ale", true)
try_loadstring("\27LJ\2\n°\5\0\0\3\0\30\00066\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\0016\0\0\0009\0\4\0)\1\1\0=\1\5\0006\0\0\0009\0\4\0005\1\b\0005\2\a\0=\2\t\0015\2\n\0=\2\v\0015\2\f\0=\2\r\0015\2\14\0=\2\15\0015\2\16\0=\2\17\1=\1\6\0006\0\0\0009\0\4\0005\1\20\0005\2\19\0=\2\t\1=\1\18\0006\0\0\0009\0\4\0'\1\22\0=\1\21\0006\0\0\0009\0\4\0'\1\24\0=\1\23\0006\0\0\0009\0\4\0'\1\22\0=\1\25\0006\0\0\0009\0\4\0)\1\1\0=\1\26\0006\0\0\0009\0\4\0)\1\0\0=\1\27\0006\0\0\0009\0\4\0005\1\29\0=\1\28\0K\0\1\0\1\2\0\0\rbrakeman\23ale_linters_ignore\27ale_virtualtext_cursor\20ale_echo_cursor\18ale_sign_info\b‚ñ¨\19ale_sign_error\b‚ñ™\21ale_sign_warning\1\0\0\1\2\0\0\frubocop\15ale_fixers\rmarkdown\1\2\0\0\tvale\ttext\1\2\0\0\tvale\14gitcommit\1\2\0\0\tvale\btxt\1\2\0\0\tvale\truby\1\0\0\1\2\0\0\frubocop\16ale_linters\20ale_disable_lsp\6gß\1    call ale#linter#Define('gitcommit', { 'name': 'vale', 'executable': 'vale', 'command': 'vale --output=JSON %t', 'callback': 'ale#handlers#vale#Handle' })\n    \17nvim_command\bapi\bvim\0", "config", "ale")
time("Config for ale", false)
-- Config for: which-key.nvim
time("Config for which-key.nvim", true)
try_loadstring("\27LJ\2\ná\4\0\0\5\0\26\0\0296\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\3\0005\4\4\0=\4\5\3=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\0025\3\f\0005\4\r\0=\4\14\0035\4\15\0=\4\16\3=\3\17\0025\3\19\0005\4\18\0=\4\20\0035\4\21\0=\4\22\3=\3\23\0025\3\24\0=\3\25\2B\0\2\1K\0\1\0\vhidden\1\t\0\0\r<silent>\n<cmd>\n<Cmd>\t<CR>\tcall\blua\a^:\a^ \vlayout\nwidth\1\0\2\bmin\3\20\bmax\0032\vheight\1\0\1\fspacing\3\3\1\0\2\bmin\3\4\bmax\3\25\vwindow\fpadding\1\5\0\0\3\2\3\2\3\2\3\2\vmargin\1\5\0\0\3\1\3\0\3\1\3\0\1\0\2\rposition\vbottom\vborder\vshadow\nicons\1\0\3\14separator\b‚ûú\ngroup\6+\15breadcrumb\a¬ª\14operators\1\0\1\agc\rComments\fplugins\1\0\1\14show_help\1\fpresets\1\0\a\6g\2\6z\2\bnav\2\fwindows\2\17text_objects\2\fmotions\2\14operators\2\1\0\2\14registers\2\nmarks\2\nsetup\14which-key\frequire\0", "config", "which-key.nvim")
time("Config for which-key.nvim", false)
-- Config for: echodoc.vim
time("Config for echodoc.vim", true)
try_loadstring("\27LJ\2\nd\0\0\2\0\5\0\t6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0005\1\4\0=\1\3\0K\0\1\0\1\0\1\ttype\rfloating\fechodoc\30echodoc_enable_at_startup\6g\bvim\0", "config", "echodoc.vim")
time("Config for echodoc.vim", false)
-- Config for: animate.vim
time("Config for animate.vim", true)
try_loadstring("\27LJ\2\nø\1\0\0\4\0\a\0\0196\0\0\0009\0\1\0009\0\2\0'\2\3\0)\3\0\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\4\0)\3ñ\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\5\0'\3\6\0B\0\3\1K\0\1\0\29animate#ease_in_out_sine\24animate#easing_func\21animate#duration\29animate#distribute_space\17nvim_set_var\bapi\bvim\0", "config", "animate.vim")
time("Config for animate.vim", false)
-- Config for: nvim-bufferline.lua
time("Config for nvim-bufferline.lua", true)
try_loadstring("\27LJ\2\n˘\2\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\foptions\1\0\0\1\0\15\18modified_icon\b‚óè\rmappings\1\22buffer_close_icon\bÔôï\fsort_by\23relative_directory\17number_style\16superscript\28show_buffer_close_icons\1\fnumbers\14buffer_id\22max_prefix_length\3\15\tview\16multiwindow\rtab_size\3\18\23right_trunc_marker\bÔÇ©\27always_show_bufferline\1\22left_trunc_marker\bÔÇ®\20max_name_length\3\18\15close_icon\bÔÄç\nsetup\15bufferline\frequire\0", "config", "nvim-bufferline.lua")
time("Config for nvim-bufferline.lua", false)
-- Config for: vim-matchup
time("Config for vim-matchup", true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "vim-matchup")
time("Config for vim-matchup", false)
-- Conditional loads
time("Condition for { 'vim-tmux-navigator' }", true)
if
try_loadstring("\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\v\0\0\0X\0\2Ä+\0\1\0X\1\1Ä+\0\2\0L\0\2\0\tTMUX\benv\bvim\0", "condition", '{ "vim-tmux-navigator" }')
then
time("Condition for { 'vim-tmux-navigator' }", false)
time("packadd for vim-tmux-navigator", true)
		vim.cmd [[packadd vim-tmux-navigator]]
	time("packadd for vim-tmux-navigator", false)
else
time("Condition for { 'vim-tmux-navigator' }", false)
end

-- Command lazy-loads
time("Defining lazy-load commands", true)
vim.cmd [[command! -nargs=* -range -bang -complete=file TestVisit lua require("packer.load")({'vim-test'}, { cmd = "TestVisit", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file TestLast lua require("packer.load")({'vim-test'}, { cmd = "TestLast", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file SplitjoinSplit lua require("packer.load")({'splitjoin.vim'}, { cmd = "SplitjoinSplit", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file SplitjoinJoin lua require("packer.load")({'splitjoin.vim'}, { cmd = "SplitjoinJoin", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file RepoEdit lua require("packer.load")({'vim-repo-edit'}, { cmd = "RepoEdit", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Xtract lua require("packer.load")({'vim-xtract'}, { cmd = "Xtract", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Switch lua require("packer.load")({'switch.vim'}, { cmd = "Switch", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file SwitchReverse lua require("packer.load")({'switch.vim'}, { cmd = "SwitchReverse", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Glow lua require("packer.load")({'glow.nvim'}, { cmd = "Glow", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file FloatermNew lua require("packer.load")({'vim-floaterm'}, { cmd = "FloatermNew", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file FloatermToggle lua require("packer.load")({'vim-floaterm'}, { cmd = "FloatermToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file NvimTreeFindFile lua require("packer.load")({'nvim-tree.lua'}, { cmd = "NvimTreeFindFile", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Neoformat lua require("packer.load")({'neoformat'}, { cmd = "Neoformat", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file ArgWrap lua require("packer.load")({'vim-argwrap'}, { cmd = "ArgWrap", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file AnyJumpVisual lua require("packer.load")({'any-jump.vim'}, { cmd = "AnyJumpVisual", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file AnyJump lua require("packer.load")({'any-jump.vim'}, { cmd = "AnyJump", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Sayonara lua require("packer.load")({'vim-sayonara'}, { cmd = "Sayonara", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Deleft lua require("packer.load")({'deleft.vim'}, { cmd = "Deleft", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file NvimTreeToggle lua require("packer.load")({'nvim-tree.lua'}, { cmd = "NvimTreeToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file TestNearest lua require("packer.load")({'vim-test'}, { cmd = "TestNearest", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file TestFile lua require("packer.load")({'vim-test'}, { cmd = "TestFile", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
time("Defining lazy-load commands", false)

-- Keymap lazy-loads
time("Defining lazy-load keymaps", true)
vim.cmd [[noremap <silent> sm <cmd>lua require("packer.load")({'multichange.vim'}, { keys = "sm", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>SidewaysArgumentTextobjA <cmd>lua require("packer.load")({'sideways.vim'}, { keys = "<lt>Plug>SidewaysArgumentTextobjA", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>(git-messenger) <cmd>lua require("packer.load")({'git-messenger.vim'}, { keys = "<lt>Plug>(git-messenger)", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>(EasyAlign) <cmd>lua require("packer.load")({'vim-easy-align'}, { keys = "<lt>Plug>(EasyAlign)", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> smm <cmd>lua require("packer.load")({'multichange.vim'}, { keys = "smm", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>SidewaysArgumentAppendAfter <cmd>lua require("packer.load")({'sideways.vim'}, { keys = "<lt>Plug>SidewaysArgumentAppendAfter", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>(gh-line-blame) <cmd>lua require("packer.load")({'vim-gh-line'}, { keys = "<lt>Plug>(gh-line-blame)", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>SidewaysArgumentInsertFirst <cmd>lua require("packer.load")({'sideways.vim'}, { keys = "<lt>Plug>SidewaysArgumentInsertFirst", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>(gh-line) <cmd>lua require("packer.load")({'vim-gh-line'}, { keys = "<lt>Plug>(gh-line)", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>SidewaysArgumentTextobjI <cmd>lua require("packer.load")({'sideways.vim'}, { keys = "<lt>Plug>SidewaysArgumentTextobjI", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>(LiveEasyAlign) <cmd>lua require("packer.load")({'vim-easy-align'}, { keys = "<lt>Plug>(LiveEasyAlign)", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>(esearch) <cmd>lua require("packer.load")({'vim-esearch'}, { keys = "<lt>Plug>(esearch)", prefix = "" }, _G.packer_plugins)<cr>]]
time("Defining lazy-load keymaps", false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time("Defining lazy-load filetype autocommands", true)
vim.cmd [[au FileType ruby ++once lua require("packer.load")({'rails_extra.vim'}, { ft = "ruby" }, _G.packer_plugins)]]
vim.cmd [[au FileType eruby ++once lua require("packer.load")({'rails_extra.vim'}, { ft = "eruby" }, _G.packer_plugins)]]
vim.cmd [[au FileType slim ++once lua require("packer.load")({'rails_extra.vim'}, { ft = "slim" }, _G.packer_plugins)]]
vim.cmd [[au FileType haml ++once lua require("packer.load")({'rails_extra.vim'}, { ft = "haml" }, _G.packer_plugins)]]
vim.cmd [[au FileType rspec ++once lua require("packer.load")({'rails_extra.vim'}, { ft = "rspec" }, _G.packer_plugins)]]
vim.cmd [[au FileType lua ++once lua require("packer.load")({'BetterLua.vim'}, { ft = "lua" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'mkdx'}, { ft = "markdown" }, _G.packer_plugins)]]
time("Defining lazy-load filetype autocommands", false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
