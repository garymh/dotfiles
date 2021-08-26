local M = {
  "voldikss/vim-floaterm",
  cmd = { "FloatermNew", "FloatermToggle" },
  keys = {
    { "<leader>z",      "<CMD>FloatermNew --width=0.5 --height=0.99 --autoclose=1 --position=right zsh<CR>", desc = "zsh window" },
    { "<leader>c",      "<CMD>FloatermNew --width=1.00 --height=1.00 --autoclose=2 btop<CR>",                desc = "btop (cpu)" },
    { "<leader>g",      "<CMD>FloatermNew --width=1.0 --height=1.0 --autoclose=2 lazygit<CR>",               desc = "lazygit" },
    { "<localleader>t", "<CMD>FloatermSend<CR>",                                                             desc = "send command to term" },
    { "<localleader>t", "<CMD>FloatermSend<CR>",                               "v",                          desc = "send command to term" },
  },
}

function M.config()
  vim.g.floaterm_width = 0.9
  vim.g.floaterm_height = 0.9
  vim.g.floaterm_autoclose = 0
end

return M
