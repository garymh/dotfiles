vim.api.nvim_create_user_command("PlugUpdate", "<CMD>Lazy update<CR>", { desc = "Search projects folder" })

s_nmap("<space>l", vim.cmd.Lazy, {}, "Lazy plugins")

-- local w = vim.loop.new_fs_event()
-- local watchedFile = "/path/foo.bar"
--
-- local function executeOnFileChange()
-- 	-- DO SOMETHING
-- 	if w then
-- 		w:stop() -- prevent multiple executions
-- 		StartWatching()
-- 	end
-- end
--
-- function StartWatching()
-- 	if w then w:start(watchedFile, {}, vim.schedule_wrap(executeOnFileChange)) end
-- end
--
-- StartWatching()

return {
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    opts = function()
      vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
    end,
  },

  {
    "gbprod/yanky.nvim",
    dependencies = { "kkharji/sqlite.lua" },
    config = function()
      require("yanky").setup({
        ring = {
          storage = "sqlite",
        },
        highlight = {
          on_put = true,
          on_yank = true,
          timer = 300,
        },
        system_clipboard = {
          sync_with_ring = true,
        },
        preserve_cursor_position = {
          enabled = true,
        },
      })
      s_nmap("p", "<Plug>(YankyPutAfter)")
      s_nmap("P", "<Plug>(YankyPutBefore)")

      s_nmap("<down>", "<Plug>(YankyCycleForward)")
      s_nmap("<up>", "<Plug>(YankyCycleBackward)")

      s_nmap("]p", "<Plug>(YankyPutIndentAfterLinewise)", {}, "something with paste? fix me")
      s_nmap("[p", "<Plug>(YankyPutIndentBeforeLinewise)", {}, "something with paste? fix me")
      s_nmap("]P", "<Plug>(YankyPutIndentAfterLinewise)", {}, "something with paste? fix me")
      s_nmap("[P", "<Plug>(YankyPutIndentBeforeLinewise)", {}, "something with paste? fix me")

      s_nmap(">p", "<Plug>(YankyPutIndentAfterShiftRight)", {}, "something with paste? fix me")
      s_nmap("<p", "<Plug>(YankyPutIndentAfterShiftLeft)", {}, "something with paste? fix me")
      s_nmap(">P", "<Plug>(YankyPutIndentBeforeShiftRight)", {}, "something with paste? fix me")
      s_nmap("<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", {}, "something with paste? fix me")

      s_nmap("=p", "<Plug>(YankyPutAfterFilter)", {}, "something with paste? fix me")
      s_nmap("=P", "<Plug>(YankyPutBeforeFilter)", {}, "something with paste? fix me")

      vim.cmd([[hi YankyYanked guifg=#FFFFFF guibg=#FF9509]])
    end,
  },

  {
    "ghillb/cybu.nvim",
    requires = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" }, -- optional for icon support
    config = function()
      local ok, cybu = pcall(require, "cybu")
      if not ok then
        return
      end
      cybu.setup({
        position = {
          relative_to       = "editor",   -- win, editor, cursor
          anchor            = "topright", -- topleft, topcenter, topright, centerleft, center, centerright, bottomleft, bottomcenter, bottomright
          vertical_offset   = 2,          -- vertical offset from anchor in lines
          horizontal_offset = 0,          -- vertical offset from anchor in columns
          max_win_height    = 7,          -- height of cybu window in lines
          max_win_width     = 0.99,
        },
        display_time = 500, -- time the cybu window is displayed
      })

      s_nmap("[b", "<Plug>(CybuPrev)", {}, "prev buffer")
      s_nmap("]b", "<Plug>(CybuNext)", {}, "next buffer")
    end,
  },

  {
    "justinmk/vim-gtfo",
    keys = {
      { "got", desc = "go to current directory in terminal" },
      { "gof", desc = "go to current file in Finder" },
      { "goT", desc = "go to current working directory in terminal" },
      { "goF", desc = "go to current working file in Finder" },
    },
  },

  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      local notify = require("notify")

      local base = require("notify.render.base")
      local function gary_render(bufnr, notif, highlights)
        local namespace = base.namespace()
        local icon = notif.icon
        local title = notif.title[1]

        local prefix
        if type(title) == "string" and #title > 0 then
          prefix = string.format("%s %s:", icon, title)
        else
          prefix = string.format("%s", icon)
        end
        notif.message[1] = string.format("%s %s", prefix, notif.message[1])

        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, notif.message)

        local icon_length = vim.str_utfindex(icon)
        local prefix_length = vim.str_utfindex(prefix)

        vim.api.nvim_buf_set_extmark(bufnr, namespace, 0, 0, {
          hl_group = highlights.icon,
          end_col = icon_length + 1,
          priority = 50,
        })
        vim.api.nvim_buf_set_extmark(bufnr, namespace, 0, icon_length + 1, {
          hl_group = highlights.title,
          end_col = prefix_length + 1,
          priority = 50,
        })
        vim.api.nvim_buf_set_extmark(bufnr, namespace, 0, prefix_length + 1, {
          hl_group = highlights.body,
          end_line = #notif.message,
          priority = 50,
        })
      end

      notify.setup {
        background_colour = "NotifyBackground",
        fps = 60,
        icons = {
          DEBUG = " ",
          ERROR = " ",
          INFO  = " ",
          TRACE = " ✎",
          WARN  = " "
        },
        level = 2,
        minimum_width = 30,
        render = gary_render,
        stages = "fade",
        timeout = 700,
        top_down = false
      }

      vim.notify = notify
    end
  },

  {
    "liangxianzhe/floating-input.nvim",
    config = function()
      require("floating-input").setup()
    end,
  },

  {
    "foosoft/vim-argwrap",
    keys = {
      { "<localleader><localleader>", "<CMD>ArgWrap<CR>", desc = "toggle argument wrap" },
    },
  },

  {
    "m-demare/hlargs.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
    enabled = true,
    opts = function()
      require("hlargs").setup({
        excluded_argnames = {
          usages = {
            lua = { "self", "use" },
          },
        },
      })
    end,
  },

  {
    "HampusHauffman/block.nvim",
    cond = vim.fn.has('nvim-0.10.0dev') == 1,
    event = "VeryLazy",
    config = function()
      require("block").setup({
        automatic = true,
      })
    end
  },

  {
    'jinh0/eyeliner.nvim',
    config = function()
      require 'eyeliner'.setup {
        highlight_on_key = true, -- show highlights only after keypress
        dim = true               -- dim all other characters if set to true (recommended!)
      }
    end
  },

  {
    "echasnovski/mini.bracketed",
    version = false,
    config = function()
      require("mini.bracketed").setup({
        buffer     = { suffix = "",  options = {} },
        comment    = { suffix = "",  options = {} },
        conflict   = { suffix = "",  options = {} },
        diagnostic = { suffix = "",  options = {} },
        file       = { suffix = "",  options = {} },
        indent     = { suffix = "i", options = {} },
        jump       = { suffix = "",  options = {} },
        location   = { suffix = "",  options = {} },
        oldfile    = { suffix = "r", options = {} },
        quickfix   = { suffix = "",  options = {} },
        treesitter = { suffix = "t", options = {} },
        undo       = { suffix = "u", options = {} },
        window     = { suffix = "w", options = {} },
        yank       = { suffix = "y", options = {} },
      })
    end,
  },

  {
    "lukas-reineke/headlines.nvim",
    ft = "markdown",
    opts = function()
      vim.cmd([[highlight Headline1 guibg=#5C2E33]])
      vim.cmd([[highlight Headline2 guibg=#333C2D]])
      vim.cmd([[highlight Headline3 guibg=#2C414E]])
      vim.cmd([[highlight Headline4 guibg=#1E2717]])
      vim.cmd([[highlight Headline5 guibg=#2B2725]])
      vim.cmd([[highlight Headline6 guibg=#0F1C1E]])
      vim.cmd([[highlight CodeBlock guibg=#1c1c1c]])
      vim.cmd([[highlight Dash guibg=#D19A66 gui=bold]])

      require("headlines").setup({
        markdown = {
          headline_highlights = {
            "Headline1",
            "Headline2",
            "Headline3",
            "Headline4",
            "Headline5",
            "Headline6",
          },
        },
      })
    end,
  },

  {
    "AckslD/muren.nvim",
    config = true,
    cmd = { "MurenToggle", "MurenOpen" },
  -- investigate this?
  },

  {
    'tzachar/highlight-undo.nvim',
    config = function()
      require('highlight-undo').setup({
        hlgroup = 'HighlightUndo',
        duration = 300,
        keymaps = {
          { 'n', 'u',     'undo', {} },
          { 'n', '<C-r>', 'redo', {} },
        }
      })
    end
  },

  {
    "lewis6991/spaceless.nvim",
    opts = function()
      require("spaceless").setup()
    end,
  },

  { "kana/vim-niceblock" },
  { "kevinhwang91/nvim-bqf",       ft = "qf" },
  { "m4xshen/smartcolumn.nvim" },
  { "shortcuts/no-neck-pain.nvim", cmd = "NoNeckPain" },
  { "stsewd/gx-extended.vim" },
  { "tpope/vim-abolish" },
  { "tpope/vim-apathy" },
  { "tpope/vim-eunuch" },
  { "Rasukarusan/nvim-block-paste", cmd = { "Block" } },

  { "tpope/vim-repeat" },
  { "tpope/vim-rsi" },
  -- TODO: this was disabled?

  { "duggiefresh/vim-easydir" },
  { "fladson/vim-kitty",            ft = "kitty" },
  { "itchyny/vim-highlighturl" },

  -- {
  --   "ckolkey/ts-node-action",
  --   dependencies = { "nvim-treesitter" },
  --   enabled = false,
  --   config = function()
  --     -- local helpers = require("ts-node-action.helpers")
  --     require("ts-node-action").setup({
  --       -- ["*"] = {
  --       --   ["string"] = function(node)
  --       --     local text = helpers.node_text(node)
  --       --     return [["hi"]]
  --       --   end,
  --       -- },
  --     })
  --     -- vim.keymap.set({ "n" }, "<leader>-", require("ts-node-action").debug, { desc = "Trigger Node Action" })
  --   end,
  -- },

  -- {
  --   "rareitems/printer.nvim",
  --   config = function()
  --     require("printer").setup({ keymap = "gp" })
  --   end,
  -- },

  -- {
  --   "gbprod/stay-in-place.nvim",
  --   opts = function()
  --     require("stay-in-place").setup({})
  --   end,
  -- },

}
