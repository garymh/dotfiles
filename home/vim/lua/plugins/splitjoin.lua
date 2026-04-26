local M = {
  "Wansmer/treesj",
  keys = {
    { "gsJ",                        vim.cmd.TSJJoin,   desc = "SplitJoin join" },
    { "gsK",                        vim.cmd.TSJSplit,  desc = "SplitJoin split" },
    { "gsj",                        vim.cmd.TSJJoin,   desc = "SplitJoin join" },
    { "gsk",                        vim.cmd.TSJSplit,  desc = "SplitJoin split" },
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
