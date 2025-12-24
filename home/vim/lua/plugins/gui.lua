return {
  {
    "sarrisv/readermode.nvim",
    cmd = { "ReaderMode" },
    opts = {}

  },

  {
    "rasulomaroff/reactive.nvim",
    enabled = true,
    config = function()
      require("reactive").add_preset({
        name = "custom",
        modes = {
          i = {
            winhl = {
              -- overwrites StatusLine highlight group in insert mode
            }
          },
          n = {
            -- hl is global and winhl is only for the current window
            hl = {
              CursorLine = { bg = "#0A2222" },
              CursorLineNr = { bg = "black" },
              Cursor = { fg = '#00ff00', bg = '#ff00ff' },
            },
          },
          no = {
            operators = {
              -- switch case
              [{ "gu", "gU", "g~", "~" }] = {
                winhl = {
                  CursorLine = { bg = "#334155" },
                  CursorLineNr = { fg = "#cbd5e1", bg = "#334155" },
                },
              },
              -- change
              c = {
                winhl = {
                  CursorLine = { bg = "#162044" },
                  CursorLineNr = { fg = "#93c5fd", bg = "#162044" },
                },
              },
              -- delete
              d = {
                winhl = {
                  CursorLine = { bg = "#350808" },
                  CursorLineNr = { fg = "#eb6f92", bg = "#350808" },
                },
              },
              -- yank
              y = {
                winhl = {
                  CursorLine = { bg = "#231e2a" },
                  CursorLineNr = { fg = "#f6c177", bg = "#2b242f" },
                },
              },
            },
          },
          -- visual
          [{ "v", "V", "\x16" }] = {
            winhl = {
              CursorLineNr = { fg = "#c4a7e7", bg = "#2F354D" },
              -- CursorLineNr = { fg = "#c4a7e7", bg = "#2e2438" },
              Visual = { bg = "#2F354D" },
            },
          },
        },
      })

      -- require('reactive').add_preset {
      --
      --   --  n	    Normal
      --   --  no	    Operator-pending
      --   --  nov	    Operator-pending (forced charwise |o_v|)
      --   --  noV	    Operator-pending (forced linewise |o_V|)
      --   --  noCTRL-V Operator-pending (forced blockwise |o_CTRL-V|)
      --   -- CTRL-V is one character
      --   --  niI	    Normal using |i_CTRL-O| in |Insert-mode|
      --   --  niR	    Normal using |i_CTRL-O| in |Replace-mode|
      --   --  niV	    Normal using |i_CTRL-O| in |Virtual-Replace-mode|
      --   --  nt	    Normal in |terminal-emulator| (insert goes to
      --   -- Terminal mode)
      --   --  ntT	    Normal using |t_CTRL-\_CTRL-O| in |Terminal-mode|
      --   --  v	    Visual by character
      --   --  vs	    Visual by character using |v_CTRL-O| in Select mode
      --   --  V	    Visual by line
      --   --  Vs	    Visual by line using |v_CTRL-O| in Select mode
      --   --  CTRL-V   Visual blockwise
      --   --  CTRL-Vs  Visual blockwise using |v_CTRL-O| in Select mode
      --   --  s	    Select by character
      --   --  S	    Select by line
      --   --  CTRL-S   Select blockwise
      --   --  i	    Insert
      --   --  ic	    Insert mode completion |compl-generic|
      --   --  ix	    Insert mode |i_CTRL-X| completion
      --   --  R	    Replace |R|
      --   --  Rc	    Replace mode completion |compl-generic|
      --   --  Rx	    Replace mode |i_CTRL-X| completion
      --   --  Rv	    Virtual Replace |gR|
      --   --  Rvc	    Virtual Replace mode completion |compl-generic|
      --   --  Rvx	    Virtual Replace mode |i_CTRL-X| completion
      --   --  c	    Command-line editing
      --   --  cr	    Command-line editing overstrike mode |c_<Insert>|
      --   --  cv	    Vim Ex mode |gQ|
      --   --  cvr	    Vim Ex mode while in overstrike mode |c_<Insert>|
      --   --  r	    Hit-enter prompt
      --   --  rm	    The -- more -- prompt
      --   --  r?	    A |:confirm| query of some sort
      --   --  !	    Shell or external command is executing
      --   --  t	    Terminal mode: keys go to the job
      --
      --   name = 'kanagawa',
      --   modes = {
      --     -- [{ 'i', 'niI' }] = {
      --     --   hl = {
      --     --     -- ReactiveCursor = { bg = '#98be65' },
      --     --     -- CursorLine = { bg = '#2f3b1e' },
      --     --     -- CursorLineNr = { fg = '#98be65', bg = '#2f3b1e' },
      --     --     ReactiveCursor = { bg = '#ff0000' },
      --     --     CursorLine = { bg = '#ff0000' },
      --     --     CursorLineNr = { fg = '#ff0000', bg = '#ff0000' },
      --     --   },
      --     -- },
      --     -- n = {
      --     --   hl = {
      --     --     ReactiveCursor = { bg = '#ffffff' },
      --     --     CursorLine = { bg = '#21202e' },
      --     --     CursorLineNr = { fg = '#ffffff', bg = '#21202e' },
      --     --   },
      --     -- },
      --     --
      --     -- no = {
      --     --   operators = {
      --     --     y = {
      --     --       hl = {
      --     --         -- ReactiveCursor = { bg = '#FFA066' },
      --     --         -- CursorLine = { bg = '#422006' },
      --     --         -- CursorLineNr = { fg = '#FFA066', bg = '#422006' },
      --     --         ReactiveCursor = { bg = '#ff0000' },
      --     --         CursorLine = { bg = '#ff0000' },
      --     --         CursorLineNr = { fg = '#ff0000', bg = '#ff0000' },
      --     --       },
      --     --     },
      --     --     -- delete
      --     --     d = {
      --     --       hl = {
      --     --         ReactiveCursor = { bg = '#fca5a5' },
      --     --         CursorLine = { bg = '#350808' },
      --     --         CursorLineNr = { fg = '#fca5a5', bg = '#350808' },
      --     --       },
      --     --     },
      --     --     c = {
      --     --       hl = {
      --     --         ReactiveCursor = { bg = '#93c5fd' },
      --     --         CursorLine = { bg = '#202020' },
      --     --         CursorLineNr = { fg = '#ffffff', bg = '#303030' },
      --     --       },
      --     --     },
      --     --   },
      --     -- },
      --     -- [{ 'v', 'V', '\x16' }] = {
      --     --   hl = {
      --     --     ReactiveCursor = { bg = '#7E9CD8' },
      --     --     CursorLine = { bg = '#223249' },
      --     --     CursorLineNr = { fg = '#7E9CD8', bg = '#223249' },
      --     --   },
      --     -- },
      --     -- c = {
      --     --   hl = {
      --     --     ReactiveCursor = { bg = '#ff0000' },
      --     --     CursorLine = { bg = '#ff0000' },
      --     --     CursorLineNr = { fg = '#ff0000', bg = '#ff0000' },
      --     --   },
      --     -- },
      --     -- -- [{ 's', 'S', '\x13' }] = {
      --     -- --   hl = {
      --     -- --     ReactiveCursor = { bg = '#c4b5fd' },
      --     -- --     CursorLineNr = { fg = '#c4b5fd' },
      --     -- --     Visual = { bg = '#2e1065' },
      --     -- --   },
      --     -- -- },
      --     -- [{ 'R', 'niR', 'niV' }] = {
      --     --   hl = {
      --     --     -- ReactiveCursor = { bg = '#67e8f9' },
      --     --     -- CursorLine = { bg = '#083344' },
      --     --     -- CursorLineNr = { fg = '#67e8f9', bg = '#083344' },
      --     --   },
      --     -- },
      --   },
      -- }

      require('reactive').setup {
        builtin = {
          cursorline = true,
          cursor = true,
          modemsg = true,
        },
      }
    end,
  },

  {
    "Wansmer/symbol-usage.nvim",
    event = "LspAttach",
    config = function()
      local function h(name) return vim.api.nvim_get_hl(0, { name = name }) end

      vim.api.nvim_set_hl(0, "SymbolUsageRounding", { fg = h("CursorLine").bg, italic = true })
      vim.api.nvim_set_hl(0, "SymbolUsageContent", { bg = h("CursorLine").bg, fg = h("Comment").fg, italic = true })
      vim.api.nvim_set_hl(0, "SymbolUsageRef", { fg = h("Function").fg, bg = h("CursorLine").bg, italic = true })
      vim.api.nvim_set_hl(0, "SymbolUsageDef", { fg = h("Type").fg, bg = h("CursorLine").bg, italic = true })
      vim.api.nvim_set_hl(0, "SymbolUsageImpl", { fg = h("@keyword").fg, bg = h("CursorLine").bg, italic = true })

      local function text_format(symbol)
        local res = {}
        local round_start = { "", "SymbolUsageRounding" }
        local round_end = { "", "SymbolUsageRounding" }

        if symbol.references then
          local usage = symbol.references <= 1 and "usage" or "usages"
          local num = symbol.references == 0 and "no" or symbol.references
          table.insert(res, round_start)
          table.insert(res, { "󰌹 ", "SymbolUsageRef" })
          table.insert(res, { ("%s %s"):format(num, usage), "SymbolUsageContent" })
          table.insert(res, round_end)
        end

        if symbol.definition then
          if #res > 0 then table.insert(res, { " ", "NonText" }) end
          table.insert(res, round_start)
          table.insert(res, { "󰳽 ", "SymbolUsageDef" })
          table.insert(res, { symbol.definition .. " defs", "SymbolUsageContent" })
          table.insert(res, round_end)
        end

        if symbol.implementation then
          if #res > 0 then table.insert(res, { " ", "NonText" }) end
          table.insert(res, round_start)
          table.insert(res, { "󰡱 ", "SymbolUsageImpl" })
          table.insert(res, { symbol.implementation .. " impls", "SymbolUsageContent" })
          table.insert(res, round_end)
        end

        return res
      end

      require("symbol-usage").setup({
        vt_position = "end_of_line",
        text_format = text_format,
        disable = { filetypes = { "ruby" } }, -- why bother, it's not going to work.
      })
    end,
  },

  -- lazy.nvim
  {
    "chrisgrieser/nvim-dr-lsp",
    event = "LspAttach",
    opts = {},
    config = function()
      require("dr-lsp").setup {
        highlightCursorWordReferences = {
          enable = true,
        },
      }
    end
  },

  {
    "tzachar/highlight-undo.nvim",
    event = "VeryLazy",
    config = function()
      require("highlight-undo").setup({
        duration = _G.HighlightDuration,
        keymaps = {
          Paste = { disabled = true },
        },
      })
    end,
  },

  {
    "tris203/precognition.nvim",
    event = "VeryLazy",
    opts = {
      -- startVisible = false,
      startVisible = true,
      showBlankVirtLine = false,
      highlightColor = { link = "Comment" },
      hints = {
        Caret = { text = "^", prio = 0 },
        Dollar = { text = "$", prio = 0 },
        MatchingPair = { text = "%", prio = 0 },
        Zero = { text = "0", prio = 0 },
        w = { text = "w", prio = 0 },
        b = { text = "b", prio = 0 },
        e = { text = "e", prio = 0 },
        W = { text = "W", prio = 0 },
        B = { text = "B", prio = 0 },
        E = { text = "E", prio = 0 },
      },
      gutterHints = {
        G = { text = "G", prio = 10 },
        gg = { text = "gg", prio = 9 },
        ["[m"] = { text = "[m", prio = 10 },
        ["]m"] = { text = "]m", prio = 9 },
        PrevParagraph = { text = "{", prio = 0 },
        NextParagraph = { text = "}", prio = 0 },
      },
      -- showBlankVirtLine = true,
      -- highlightColor = { link = "Comment" },
      -- hints = {
      --      Caret = { text = "^", prio = 2 },
      --      Dollar = { text = "$", prio = 1 },
      --      MatchingPair = { text = "%", prio = 5 },
      --      Zero = { text = "0", prio = 1 },
      --      w = { text = "w", prio = 10 },
      --      b = { text = "b", prio = 9 },
      --      e = { text = "e", prio = 8 },
      --      W = { text = "W", prio = 7 },
      --      B = { text = "B", prio = 6 },
      --      E = { text = "E", prio = 5 },
      -- },
      -- gutterHints = {
      --     G = { text = "G", prio = 10 },
      --     gg = { text = "gg", prio = 9 },
      --     PrevParagraph = { text = "{", prio = 8 },
      --     NextParagraph = { text = "}", prio = 8 },
      -- },
      -- disabled_fts = {
      --     "startify",
      -- },
    },
    config = function()
      local vanilla_motions = require("precognition.motions").get_motions()

      require("precognition.motions").register_motions({
        next_word_boundary = function(line_content, cursorcol, linelen, big_word)
          -- using the plugin custom implementation for the "W" motion
          if (big_word) then
            return plugin_custom_motion_logic(line_content, cursorcol, linelen, big_word)

            -- calling the default for the "w" motion
            -- useful the cases in which the plugin does not implement custom motions
          else
            return vanilla_motions.next_word_boundary(line_content, cursorcol, linelen, big_word)
          end
        end
      })
    end
  },
  -- TODO: config

  {
    "jinh0/eyeliner.nvim",
    event = "VeryLazy",
    config = function()
      require("eyeliner").setup({
        highlight_on_key = true, -- show highlights only after keypress
        dim = true,              -- dim all other characters if set to true (recommended!)
      })
    end,
    enabled = false,
  },
}
