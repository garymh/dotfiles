local M = {
  -- "AndrewRadev/splitjoin.vim",
  "Wansmer/treesj",
  keys = {
    -- { "sJ", vim.cmd.SplitjoinSplit, desc = "SplitJoin split" },
    -- { "sK", vim.cmd.SplitjoinJoin,  desc = "SplitJoin join" },
    -- { "sj", vim.cmd.SplitjoinSplit, desc = "SplitJoin split" },
    -- { "sk", vim.cmd.SplitjoinJoin,  desc = "SplitJoin join" },
    { "sJ", vim.cmd.TSJJoin, desc = "SplitJoin split" },
    { "sK", vim.cmd.TSJSplit,  desc = "SplitJoin join" },
    { "sj", vim.cmd.TSJJoin, desc = "SplitJoin split" },
    { "sk", vim.cmd.TSJSplit,  desc = "SplitJoin join" },
    { "<localleader><localleader>", vim.cmd.TSJToggle,  desc = "SplitJoin join" },
  }
  -- { 'echasnovski/mini.nvim', version = false },
}

function M.config()
  -- vim.g.splitjoin_split_mapping = ""
  -- vim.g.splitjoin_join_mapping  = ""
  -- vim.g.splitjoin_align         = 1
  local tsj = require('treesj')

  tsj.setup({
    use_default_keymaps = false,
    check_syntax_error = true,
    max_join_length = 120,
    cursor_behavior = 'hold',
    notify = true,
    dot_repeat = true,
  })
end

return M
