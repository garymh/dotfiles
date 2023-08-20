local M = {
  -- 'nyoom-engineering/oxocarbon.nvim',
  -- init = function()
  --   vim.cmd.colorscheme 'oxocarbon'
  -- end

  'AlexvZyl/nordic.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require 'nordic'.load {
      bold_keywords = true,
      italic_comments = true,
      bright_border = false,
      reduced_blue = true,
      swap_backgrounds = true,
      override = {
        Visual = {
          bg = "#0F68E0"
        }
      },
      cursorline = {
        -- Bold font in cursorline.
        bold = false,
        -- Bold cursorline number.
        bold_number = true,
        -- Avialable styles: 'dark', 'light'.
        theme = 'dark',
        -- Blending the cursorline bg with the buffer bg.
        blend = 0.7,
      },
      noice = {
        -- Available styles: `classic`, `flat`.
        style = 'flat',
      },
      ts_context = {
        -- Enables dark background for treesitter-context window
        dark_background = true,
      }
    }
  end
}

return M
