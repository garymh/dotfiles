-- local M = {
--   "AndrewRadev/switch.vim",
--   keys = { "-" }
-- }
--
-- function M.config()
--   vim.g.switch_custom_definitions = {
--     vim.fn['switch#Words']({ "assert", "refute" }),
--     vim.fn['switch#Words']({ "if", "unless" }),
--     vim.fn['switch#Words']({ "pick", "squash" }),
--     { "let g:", "vim.g." },
--     vim.fn['switch#Words']({ "let", "let_it_be" }),
--     { "[ ]",    "[x]" },
--     { "- [ ]",  "- [x]" },
--     vim.fn['switch#Words']({ "1", "0" }),
--     vim.fn['switch#NormalizedCaseWords']({ "yes", "no" }),
--     vim.fn['switch#Words']({ "s_nmap", "nmap", "s_vmap", "vmap" }),
--     vim.fn['switch#NormalizedCaseWords']({ "on", "off" }),
--     { "\\([^. ]\\+\\)\\.should\\(_not\\|\\)': 'expect(\\1)\\.to\\2" },
--     { "expect(\\([^. ]\\+\\))\\.to\\(_not\\|\\)': '\\1.should\\2" },
--   }
--
--   vim.g.switch_mapping = ""
--   s_nmap("-", vim.cmd.Switch)
-- end
--
-- return M
local dial_inc_keep_cursor_pos = function()
  local pos = vim.api.nvim_win_get_cursor(0)
  local cmd = require('dial.map').inc_normal()
  local keys = vim.api.nvim_replace_termcodes(cmd, true, true, true)
  vim.api.nvim_feedkeys(keys, 'm', false)
  vim.schedule(function()
    vim.api.nvim_win_set_cursor(0, pos)
  end)
end


local M = {
  'monaqa/dial.nvim',
  opt = {},
  keys = {
    { "<C-a>",  "<Plug>(dial-increment)",  desc = "increment" },
    { "<C-x>",  "<Plug>(dial-decrement)",  desc = "increment" },
    { "g<C-a>", "g<Plug>(dial-increment)", desc = "increment" },
    { "g<C-x>", "g<Plug>(dial-decrement)", desc = "increment" },
    { "<C-a>",  "<Plug>(dial-increment)",  desc = "increment", mode = "v" },
    { "<C-x>",  "<Plug>(dial-decrement)",  desc = "increment", mode = "v" },
    { "g<C-a>", "g<Plug>(dial-increment)", desc = "increment", mode = "v" },
    { "g<C-x>", "g<Plug>(dial-decrement)", desc = "increment", mode = "v" },
    { "-",      dial_inc_keep_cursor_pos,  desc = "increment" },
  }
}

function M.config()
  local augend = require("dial.augend")

  local function word_augend(...)
    local elements = { ... } -- This creates a table with all arguments
    return augend.constant.new { elements = elements, word = true, cyclic = true }
  end

  local function case_word_augend(...)
    local elements = { ... } -- This creates a table with all arguments
    return augend.constant.new { elements = elements, word = true, cyclic = true, preserve_case = true }
  end

  local function any_augend(...)
    local elements = { ... } -- This creates a table with all arguments
    return augend.constant.new { elements = elements, word = false, cyclic = true, }
  end

  require("dial.config").augends:register_group {
    default = {
      -- uppercase hex number (0x1A1A, 0xEEFE, etc.)
      augend.integer.alias.decimal_int,
      augend.integer.alias.hex,

      augend.date.alias["%Y-%m-%d"],
      augend.date.alias["%Y/%m/%d"],

      augend.constant.alias.bool,
      augend.semver.alias.semver,
      augend.misc.alias.markdown_header,

      any_augend("&&", "||"),
      any_augend("let g:", "vim.g."),

      augend.case.new {
        types = { "camelCase", "snake_case", "PascalCase", "SCREAMING_SNAKE_CASE" },
        cyclic = true,
      },

      case_word_augend("and", "or"),
      case_word_augend("on", "off"),
      case_word_augend("yes", "no"),

      word_augend("- [ ]", "- [x]"),
      word_augend("1", "0"),
      word_augend("[ ]", "[x]"),
      word_augend("assert", "refute"),
      word_augend("if", "unless"),
      word_augend("let", "let!", "let_it_be"),
      word_augend("pick", "squash"),
      word_augend("s_nmap", "nmap", "s_vmap", "vmap"),
    },
    lua = {
      augend.paren.alias.lua_str_literal,
    }
  }
end

return M
