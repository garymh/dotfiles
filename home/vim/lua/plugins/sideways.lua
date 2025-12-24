local M = {
  "AndrewRadev/sideways.vim",
  keys = {
    { "<localleader>si", "<Plug>SidewaysArgumentInsertBefore", desc = "insert arg before" },
    { "<localleader>sa", "<Plug>SidewaysArgumentAppendAfter",  desc = "insert arg after" },
    { "<localleader>sI", "<Plug>SidewaysArgumentInsertFirst",  desc = "insert arg first" },
    { "<localleader>sA", "<Plug>SidewaysArgumentAppendLast",   desc = "insert arg last" },
  },
  enabled = true
}

function M.config()
end

return M
