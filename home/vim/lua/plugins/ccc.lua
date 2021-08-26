local M = {
  "uga-rosa/ccc.nvim",
}

function M.config()
  local ccc = require("ccc")

  ccc.setup({
    highlighter = {
      auto_enable = true,
      filetypes = { "html", "tmux", "css", "vim", "lua", "conf", "kitty" },
    },
  })
  -- :CccPick
end

return M
