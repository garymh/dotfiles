local M = {
  "willothy/nvim-cokeline",
  event        = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  enabled      = function()
    if vim.fn.has('nvim-0.9.0dev') == 1 then
      return true
    else
      return false
    end
  end,
}

function M.config()
  local get_hex  = require('cokeline/utils').get_hex
  local mappings = require('cokeline/mappings')

  local comments_fg = get_hex('Comment', 'fg')
  local errors_fg   = get_hex('DiagnosticError', 'fg')
  local warnings_fg = get_hex('DiagnosticWarn', 'fg')

  local red    = vim.g.terminal_color_1
  local yellow = vim.g.terminal_color_3

  local rhs_components = {
    branch = {
      text = function()
        if vim.b.gitsigns_head then
          return "  " .. vim.b.gitsigns_head:sub(1, 20) .. " "
        else
          return ""
        end
      end,
      fg = "#B4BDC3",
      bg = "#65435E",
      style = function()
        return 'bold,underline'
      end
    }
  }

  local components = {
    space = {
      text       = ' ',
      truncation = { priority = 1 }
    },

    two_spaces = {
      text       = '  ',
      truncation = { priority = 1 },
    },


    ee = {
      text = function(buffer)
        if string.find(buffer.path, "ee/", nil, true) then
          return "EE"
        else
          return ""
        end
      end,

      fg = function(buffer)
        if buffer.is_focused then
          return "#ffffff"
        else
          return nil
        end
      end,

      bg = function(buffer)
        if buffer.is_focused then
          return get_hex('ErrorMsg', 'fg')
        else
          return nil
        end
      end,
      style = 'bold',
      -- truncation = { priority = 1 },
    },
    separator = {
      text = function(buffer)
        return buffer.index ~= 1 and '▏' or ''
      end,
      truncation = { priority = 1 }
    },

    devicon = {
      text = function(buffer)
        return
            (mappings.is_picking_focus() or mappings.is_picking_close())
            and buffer.pick_letter .. ' '
            or buffer.devicon.icon
      end,
      fg = function(buffer)
        return
            (mappings.is_picking_focus() and yellow)
            or (mappings.is_picking_close() and red)
            or buffer.devicon.color
      end,
      style = function(_)
        return
            (mappings.is_picking_focus() or mappings.is_picking_close())
            and 'italic,bold'
            or nil
      end,
      truncation = { priority = 1 }
    },

    index = {
      text = function(buffer)
        return buffer.index .. ': '
      end,
      truncation = { priority = 1 }
    },

    unique_prefix = {
      text = function(buffer)
        return buffer.unique_prefix
      end,
      fg = comments_fg,
      style = 'italic',
      truncation = {
        priority = 3,
        direction = 'left',
      },
    },

    filename = {
      text = function(buffer)
        return buffer.filename
      end,
      style = function(buffer)
        return
            ((buffer.is_focused and buffer.diagnostics.errors ~= 0)
              and 'bold,underline')
            or (buffer.is_focused and 'bold')
            or (buffer.diagnostics.errors ~= 0 and 'underline')
            or nil
      end,
      truncation = {
        priority = 2,
        direction = 'left',
      },
    },

    diagnostics = {
      text = function(buffer)
        return
            (buffer.diagnostics.errors ~= 0 and '  ' .. buffer.diagnostics.errors)
            or (buffer.diagnostics.warnings ~= 0 and '  ' .. buffer.diagnostics.warnings)
            or ''
      end,
      fg = function(buffer)
        return
            (buffer.diagnostics.errors ~= 0 and errors_fg)
            or (buffer.diagnostics.warnings ~= 0 and warnings_fg)
            or nil
      end,
      truncation = { priority = 1 },
    },

    close_or_unsaved = {
      text = function(buffer)
        return buffer.is_modified and '●' or ''
      end,
      fg = function(buffer)
        return buffer.is_modified and "#BAD761" or nil
      end,
      delete_buffer_on_left_click = true,
      truncation = { priority = 1 },
    },
  }

  require('cokeline').setup({
    show_if_buffers_are_at_least = 2,

    buffers = {
      -- filter_valid = function(buffer) return buffer.type ~= 'terminal' end,
      -- filter_visible = function(buffer) return buffer.type ~= 'terminal' end,
      new_buffers_position = 'next',
    },

    -- rendering = {
    --   max_buffer_width = 30,
    -- },

    default_hl = {
      fg = function(buffer)
        return
            buffer.is_focused
            and get_hex('normal', 'fg')
            or get_hex('comment', 'fg')
      end,
      bg = function(buffer)
        return
            buffer.is_focused
            and get_hex('BufferLineDuplicateSelected', 'fg')
            or get_hex('ColorColumn', 'fg')
      end,
    },

    components = {
      components.space,
      components.devicon,
      -- components.index,
      -- components.unique_prefix,
      components.filename,
      components.space,
      components.ee,
      components.diagnostics,
      -- components.two_spaces,
      components.space,
      components.close_or_unsaved,
    },

    rhs = {
      rhs_components.branch
    }
  })
end

return M
