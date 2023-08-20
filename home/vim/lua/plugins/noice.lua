M = {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  enabled = false,
}

function M.config()
  local noice = require("noice")

  noice.setup({
    routes = {
      {
        view = "notify",
        filter = { event = "msg_showmode" },
      },
    },
    views = {
      cmdline_popup = {
        border = {
          style = "rounded",
          padding = { 2, 3 },
        },
        filter_options = {},
        win_options = {
          winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
        },
      },
      mini = {
        position = {
          row = 0,
          col = "100%",
        },
        -- border = {
        --   style = "single",
        -- },
      },
    },
    cmdline = {
      enabled = true,         -- enables the Noice cmdline UI
      view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
      format = {
        cmdline = { pattern = "^:", icon = " ", lang = "vim" },
        search_down = {
          kind = "search",
          pattern = "^/",
          icon = " ",
          lang = "regex",
          conceal = false,
        },
        search_up = {
          kind = "search",
          pattern = "^%?",
          icon = " ",
          lang = "regex",
          conceal = false,
        },
        filter = {
          pattern = "^:%s*!",
          icon = " ",
          lang = "bash",
          conceal = false,
        },
        lua = {
          pattern = "^:%s*lua%s+",
           icon = " ",
          lang = "lua",
          conceal = false,
        },
        help = {
          pattern = "^:%s*he?l?p?%s+",
          icon = " ",
          conceal = false,
        },
      },
    },
    messages = {
      enabled = true,
      view_search = false,
    },
    popupmenu = {
      enabled = true,
      backend = "cmp",
    },
    lsp_progress = {
      enabled = false,
    },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    presets = {
      command_palette = true, -- position the cmdline and popupmenu together
      lsp_doc_border = true,  -- add a border to hover docs and signature help
    },
    hover = {
      enabled = true,
      view = nil, -- when nil, use defaults from documentation
      opts = {},  -- merged with defaults from documentation
    },
  })
  cmap("<S-Enter>", function()
    noice.redirect(vim.fn.getcmdline())
  end, {}, "Redirect Cmdline")
end

return M
