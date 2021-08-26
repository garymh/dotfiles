local M = {
  "loctvl842/monokai-pro.nvim",
}

function M.opts()
  local monokai = require("monokai-pro")

  monokai.setup({
    transparent_background = false,
    terminal_colors        = true,
    devicons               = true,
    italic_comments        = true,
    filter                 = "octagon",    -- classic | octagon | pro | machine | ristretto | spectrum
    inc_search             = "background", -- underline | background
    background_clear       = {
      "float_win",
      "toggleterm",
      "which-key",
      "renamer",
    },
    plugins                = {
      bufferline = {
        underline_selected = false,
        underline_visible = false,
        underline_fill = true,
        bold = true,
      },
    },
  })
  monokai.load()
end

return M
