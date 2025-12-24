local M = {
  'tummetott/unimpaired.nvim',
  event = 'VeryLazy',
  opts = {},
  keys = {
    { "[e", desc = "Exchange line with [count] lines above", mode = "v", },
    { "]e", desc = "Exchange line with [count] lines below", mode = "v", },
    { "[e", desc = "Move section [count] lines up" },
    { "]e", desc = "Move section [count] lines down" },
  },
}

function M.config()
  s_nmap("[t", vim.cmd.tabprev, {}, "Previous tab")
  s_nmap("]t", vim.cmd.tabnext, {}, "Next tab")
  s_nmap("[T", vim.cmd.tabfirst, {}, "First tab")
  s_nmap("]T", vim.cmd.tablast, {}, "Last tab")
  local unimpaired = require("unimpaired")

  unimpaired.setup({
    keymaps = {
      exchange_above = {
        mapping = '[e',
        description = 'Exchange line with [count] lines above',
        dot_repeat = true,
      },
      exchange_below = {
        mapping = ']e',
        description = 'Exchange line with [count] lines below',
        dot_repeat = true,
      },
      exchange_section_above = {
        mapping = '[e',
        description = 'Move section [count] lines up',
        dot_repeat = true,
      },
      exchange_section_below = {
        mapping = ']e',
        description = 'Move section [count] lines down',
        dot_repeat = true,
      },
    },

    default_keymaps = false,
  }
  )
end

return M
