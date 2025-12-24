local M = {
  "Wansmer/treesj",
  keys = {
    { "sJ", vim.cmd.TSJJoin,  desc = "SplitJoin join" },
    { "sK", vim.cmd.TSJSplit, desc = "SplitJoin split" },
    { "sj", vim.cmd.TSJJoin,  desc = "SplitJoin join" },
    { "sk", vim.cmd.TSJSplit, desc = "SplitJoin split" },
    { "<localleader><localleader>", vim.cmd.TSJToggle, desc = "SplitJoin join" },
  }
}

function M.config()
  local tsj = require('treesj')

  tsj.setup({
    use_default_keymaps = false,
    check_syntax_error  = true,
    max_join_length     = 900,
    cursor_behavior     = 'hold',
    notify              = true,
    dot_repeat          = true,
  })
end

return M
