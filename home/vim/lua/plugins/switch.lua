local M = {
  "AndrewRadev/switch.vim",
  keys = { "-" }
}

function M.config()
  vim.g.switch_custom_definitions = {
    { "assert", "refute" },
    { "if", "unless" },
    { "pick", "squash" },
    { "let g:", "vim.g." },
    { "let", "let_it_be" },
    { "[ ]", "[x]" },
    { "1", "0" },
    { "yes", "no" },
    { "on", "off" },
    { "\\([^. ]\\+\\)\\.should\\(_not\\|\\)': 'expect(\\1)\\.to\\2" },
    { "expect(\\([^. ]\\+\\))\\.to\\(_not\\|\\)': '\\1.should\\2" },
  }

  vim.g.switch_mapping = ""
  s_nmap("-", vim.cmd.Switch)
end

return M
