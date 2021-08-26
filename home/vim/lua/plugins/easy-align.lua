local M = {
  "junegunn/vim-easy-align",
}

function M.config()
  vim.g.easy_align_delimiters = {
    ["/"] = {
      pattern = "//\\+\\|/\\*\\|\\*/",
      delimiter_align = "l",
      ignore_groups = { "!Comment" },
    },
    ["\\"] = { pattern = "\\$" },
    [";"] = { pattern = ";", delimiter_align = "l", ignore_groups = { "!Comment" } },
    ["("] = { pattern = "(", delimiter_align = "l", right_margin = 0 },
    ["]"] = {
      pattern = "[[\\]]",
      left_margin = 0,
      right_margin = 0,
      stick_to_left = 0,
    },
  }

  vim.g.easy_align_bypass_fold = 1

  -- s_vmap("<cr>", "<Plug>(LiveEasyAlign)", {}, "easy align")
  s_vmap("ga", "<Plug>(LiveEasyAlign)", {}, "easy align")
  -- s_nmap("<cr>", "<Plug>(LiveEasyAlign)", {}, "easy align")
  s_nmap("ga", "<Plug>(LiveEasyAlign)", {}, "easy align")
  s_nmap("<localleader>=", "<Plug>(EasyAlign)ip*=<CR>", {}, "align equal signs in paragraph")
  s_nmap("<localleader>,", "<Plug>(EasyAlign)ip*,<CR>", {}, "align commas in paragraph")
end

return M
