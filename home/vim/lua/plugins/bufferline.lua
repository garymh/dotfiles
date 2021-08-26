local M = {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  enabled = true,
}

function M.config()
  -- local highlights = require("nord").bufferline.highlights({
  --   italic = true,
  --   bold = true,
  -- })

  require("bufferline").setup({
    options = {
      -- view = "multiwindow",
      numbers = "none",
      color_icons = false,
      -- show_buffer_default_icon = false,
      separator_style = "thick",
      -- number_style = "superscript",
      -- mappings = false,
      buffer_close_icon = "",
      modified_icon = "●",
      close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      max_name_length = 15,
      -- max_prefix_length = 1,
      tab_size = 5,
      name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
        -- remove extension from markdown files for example
        -- if buf.name:match('%.md') then
        return vim.fn.fnamemodify(buf.name, ":t:r")
        -- end
      end,
      show_buffer_close_icons = false,
      enforce_regular_tabs = false,
      always_show_bufferline = false,
      offsets = { { filetype = "NvimTree", text = "File Explorer" } },
      sort_by = "id",
    },
    highlights = highlights,
    -- highlights = {
    --   buffer_selected = {
    --     fg = "#ffffff",
    --     bg = "#5A93A9",
    --     bold = true,
    --     italic = true,
    --   },
    --   background = {
    --     bg = "#2A3E41",
    --   },
    --   separator_selected = {
    --     fg = "#152528",
    --     bg = "#5A93A9",
    --   },
    --   separator = {
    --     fg = "#152528",
    --     bg = "#2A3E41",
    --   },
    -- },
  })

  -- BufferLineCloseRight
  -- BufferLineCloseLeft

  -- vim.api.nvim_set_hl(0, "BufferCurrent",     { background = "#506591", foreground = "#ffffff" })
  -- vim.api.nvim_set_hl(0, "BufferCurrentMod",  { background = "#506591", foreground = "#FF7570" })
  -- vim.api.nvim_set_hl(0, "BufferCurrentSign", { background = "#506591", foreground = "#ffffff" })
end

return M
