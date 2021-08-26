M = {
  "lukas-reineke/indent-blankline.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  enabled = false,
}

function M.config()
  -- "▏"
  vim.g.indent_blankline_char = "▏"
  vim.g.indent_blankline_context_char = "▏"

  require("indent_blankline").setup({
    show_current_context = true,
    show_current_context_start = true,
    filetype_exclude = {
      "help",
      "NvimTree",
      "Trouble",
    },
    buftype_exclude = {
      "terminal",
      "nofile",
    },
  })
end

return M
