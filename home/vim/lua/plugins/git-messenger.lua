local M = {
  "rhysd/git-messenger.vim",
  keys = {
    { "glb", "<Plug>(git-messenger)", desc = "Git messenger (blame)" },
  }
}

function M.config()
  vim.g.git_messenger_include_diff = "none"
  vim.g.git_messenger_always_into_popup = true
  vim.g.git_messenger_no_default_mappings = true
  vim.g.git_messenger_floating_win_opts = { border = "single" }
end

return M
