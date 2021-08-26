local M = {
  "AndrewRadev/splitjoin.vim",
  keys = {
    { "sJ", vim.cmd.SplitjoinSplit, desc = "SplitJoin split" },
    { "sK", vim.cmd.SplitjoinJoin,  desc = "SplitJoin join" },
    { "sj", vim.cmd.SplitjoinSplit, desc = "SplitJoin split" },
    { "sk", vim.cmd.SplitjoinJoin,  desc = "SplitJoin join" },
  }
  -- { 'echasnovski/mini.nvim', version = false },
}

function M.config()
  vim.g.splitjoin_split_mapping = ""
  vim.g.splitjoin_join_mapping  = ""
  vim.g.splitjoin_align         = 1
end

return M
