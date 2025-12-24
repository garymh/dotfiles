local M = {
  "junegunn/vim-easy-align",
  keys = {
    { "ga",             "<Plug>(LiveEasyAlign)",     mode = "n", desc = "easy align" },
    { "ga",             "<Plug>(LiveEasyAlign)",     mode = "v", desc = "easy align" },
    { "<localleader>=", "<Plug>(EasyAlign)ip*=<CR>", mode = "n", desc = "align equal signs in paragraph" },
    { "<localleader>,", "<Plug>(EasyAlign)ip*,<CR>", mode = "n", desc = "align commas in paragraph" },
  },
}

function M.config()
  vim.g.easy_align_delimiters = {
    ["/"]  = {
      pattern         = "//\\+\\|/\\*\\|\\*/",
      delimiter_align = "l",
      ignore_groups   = { "!Comment" },
    },
    ["\\"] = { pattern = "\\$" },
    [";"]  = { pattern = ";", delimiter_align = "l", ignore_groups = { "!Comment" } },
    ["("]  = { pattern = "(", delimiter_align = "l", right_margin = 0 },
    ["]"]  = {
      pattern       = "[[\\]]",
      left_margin   = 0,
      right_margin  = 0,
      stick_to_left = 0,
    },
  }

  vim.g.easy_align_bypass_fold = 1
end

return M
