local M = {
  "rebelot/heirline.nvim",
  dependencies = { "Zeioth/heirline-components.nvim" },
  event = "VeryLazy",
}

function M.config()
  local conditions          = require("heirline.conditions")
  local utils               = require("heirline.utils")
  local heirline            = require("heirline")
  local heirline_components = require "heirline-components.all"

  local FileNameBlock       = {
    init = function(self)
      self.filename = vim.api.nvim_buf_get_name(0)
    end,
  }

  local FileIcon            = {
    init = function(self)
      local filename = self.filename
      local extension = vim.fn.fnamemodify(filename, ":e")
      self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
    end,
    provider = function(self)
      return self.icon and (self.icon .. " ")
    end,
    hl = function(self)
      return { fg = self.icon_color }
    end
  }

  local FileName            = {
    provider = function(self)
      local filename = vim.fn.fnamemodify(self.filename, ":.")
      if filename == "" then return "[No Name]" end
      if not conditions.width_percent_below(#filename, 0.25) then
        filename = vim.fn.pathshorten(filename)
      end
      return filename
    end,
    hl = { fg = utils.get_highlight("Directory").fg },
  }

  local FileFlags           = {
    {
      condition = function() return vim.bo.modified end,
      provider = "[+]",
      hl = { fg = "green" },
    },
    {
      condition = function()
        return not vim.bo.modifiable or vim.bo.readonly
      end,
      provider = "",
      hl = { fg = "orange" },
    },
  }

  local FileNameModifer     = {
    hl = function()
      if vim.bo.modified then
        return { fg = "cyan", bold = true, force = true }
      end
    end,
  }

  FileNameBlock             = utils.insert(FileNameBlock, FileIcon, utils.insert(FileNameModifer, FileName), FileFlags,
    { provider = '%<' }
  )

  heirline_components.init.subscribe_to_events()
  heirline.load_colors(heirline_components.hl.get_colors())

  heirline.setup({
    statusline   = nil,
    winbar       = {
      heirline_components.component.fill(),
      heirline_components.component.git_branch(),
      FileNameBlock,
      heirline_components.component.git_diff(),
      heirline_components.component.breadcrumbs(),
      heirline_components.component.fill(),
    },
    statuscolumn = {
      init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
      heirline_components.component.foldcolumn(),
      heirline_components.component.numbercolumn(),
      heirline_components.component.signcolumn(),
    } or nil,

    opts         = {
      disable_winbar_cb = function(args)
        return conditions.buffer_matches({
          buftype = { "nofile", "prompt", "help", "quickfix" },
          filetype = { "^git.*", "fzf" },
        }, args.buf)
      end,
    },
  })
end

return M
