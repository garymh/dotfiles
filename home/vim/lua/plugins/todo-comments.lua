local M = {
  "folke/todo-comments.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  event = "BufReadPost",
}

function M.config()
  require("todo-comments").setup()
  nmap("]n", require("todo-comments").jump_next, {}, "Next todo comment")
  nmap("[n", require("todo-comments").jump_prev, {}, "Previous todo comment")
end

return M
