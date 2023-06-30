local M = {
  "loctvl842/monokai-pro.nvim",
  priority = 100,
}


  -- dark2 = "#191515",
  -- dark1 = "#211c1c",
  -- background = "#2c2525",
  -- text = "#fff1f3",
  -- accent1 = "#fd6883",
  -- accent2 = "#f38d70",
  -- accent3 = "#f9cc6c",
  -- accent4 = "#adda78",
  -- accent5 = "#85dacc",
  -- accent6 = "#a8a9eb",
  -- dimmed1 = "#c3b7b8",
  -- dimmed2 = "#948a8b",
  -- dimmed3 = "#72696a",
  -- dimmed4 = "#5b5353",
  -- dimmed5 = "#403838",

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
