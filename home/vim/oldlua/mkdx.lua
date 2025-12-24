local M = {
  "SidOfc/mkdx",
  ft = "markdown",
  enabled = false
}
-- this doesnt work

function M.config()
  vim.api.nvim_set_var("mkdx#settings", {
    highlight = { enable = 1 },
    checkbox = { toggles = { " ", "x" } },
    enter = { shift = 1 },
    restore_visual = 1,
    links = { external = { enable = 1 } },
    toc = { text = "Table of Contents", update_on_write = 1 },
    fold = { enable = 1 },
    map = { prefix = "<localleader>m" },
  })
end

return M
