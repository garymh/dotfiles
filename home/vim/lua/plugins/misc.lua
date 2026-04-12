s_nmap("<space>l", vim.cmd.Lazy, {}, "Lazy plugins")

HighlightDuration = 300

return {
  -- ./blink-cmp.lua

  -- ./bufferline.lua

  -- ./colors.lua

  -- ./comment.lua

  -- ./conform.lua

  -- ./debugprint.lua

  -- ./easy-align.lua

  -- ./edgy.lua

  -- ./flash.lua

  -- ./fzflua.lua

  -- ./gitsigns.lua

  -- ./golang.lua

  -- ./gui.lua

  -- ./markdown.lua

  -- ./mason_lsp.lua

  -- ./mini.lua

  -- ./neotest.lua

  -- ./other.lua

  -- ./sideways.lua

  -- ./snacks.lua

  -- ./splitjoin.lua

  -- ./surround.lua

  -- ./switch.lua

  -- ./todo-comments.lua

  -- ./treesitter-like.lua

  -- ./unimpaired.lua

  -- ./whichkey.lua

  {
    "ghostty",
    dir = "/Applications/Ghostty.app/Contents/Resources/vim/vimfiles/",
    lazy = false,
  },

  {
    "kevinhwang91/nvim-fundo",
    event = { "BufReadPre" },
    dependencies = "kevinhwang91/promise-async",
    build = function()
      require("fundo").install()
    end,
    opts = {},
  },

  {
    "iamyoki/buffer-reopen.nvim",
    opts = {},
    config = function()
      require("buffer-reopen").setup()

      vim.keymap.del({ "n" }, "<leader>bt")
      vim.keymap.del({ "n" }, "<C-S-t>")
      s_nmap("<space><space>", "<CMD>BufferHistory reopen<CR>", "undo close last buffer")
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    enabled = true,
    config = function()
      require("nvim-autopairs").setup({
        enabled = false,
        --   return true
        -- end,                        -- control if auto-pairs should be enabled when attaching to a buffer
        -- disable_filetype = { "TelescopePrompt", "spectre_panel", "snacks_picker_input" },
        -- disable_in_macro = true,    -- disable when recording or executing a macro
        -- disable_in_visualblock = false, -- disable when insert after visual block mode
        -- disable_in_replace_mode = true,
        -- ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
        -- enable_moveright = true,
        -- enable_afterquote = true,     -- add bracket pairs after quote
        -- enable_check_bracket_line = true, --- check bracket in same line
        -- enable_bracket_in_quote = true, --
        -- enable_abbr = false,          -- trigger abbreviation
        -- break_undo = true,            -- switch for basic rule break undo sequence
        -- check_ts = false,
        -- map_cr = true,
        -- map_bs = true, -- map the <BS> key
        -- map_c_h = false, -- Map the <C-h> key to delete a pair
        -- map_c_w = false, -- map <c-w> to delete a pair if possible
      })
    end,
  },

  {
    "duqcyxwd/stringbreaker.nvim",
    enabled = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("string-breaker").setup()
    end,
  },

  {
    "gbprod/substitute.nvim",
    keys = {
      {
        "s",
        function()
          require("substitute").operator()
        end,
        desc = "sub operator",
        noremap = true,
        mode = "n",
      },
      {
        "_",
        function()
          require("substitute").line()
        end,
        desc = "sub line",
        noremap = true,
        mode = "n",
      },
      {
        "s",
        function()
          require("substitute").visual()
        end,
        desc = "sub visual",
        noremap = true,
        mode = "x",
      },
      --
      -- { "sx",  function() require("substitute.exchange").operator() end, desc = "substitute exchange", noremap = true, mode = "n", },
      -- { "sxx", function() require("substitute.exchange").line() end,     desc = "substitute line",     noremap = true, mode = "n", },
      -- { "sxc", function() require("substitute.exchange").cancel() end,   desc = "substitute cancel",   noremap = true, mode = "n", },
      -- { "X",   function() require("substitute.exchange").visual() end,   desc = "substitute visual",   noremap = true, mode = "x", },
    },
    opts = {},
    config = function()
      require("substitute").setup({
        on_substitute = require("yanky.integration").substitute(),
      })
    end,
  },

  { "jparise/vim-graphql", ft = "graphql" },

  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    opts = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
      vim.g.matchup_matchparen_nomode    = "i" -- disables highlighting in insert mode
      -- z%: jump inside match
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    enabled = false,
    opts = {
      cmdline = {
        format = {
          cmdline = { icon = " ", lang = "vim" },
          search_down = { kind = "search", icon = "    ", lang = "regex" },
          search_up = { kind = "search", icon = "    ", lang = "regex" },
          lua = { icon = " ", lang = "lua" },
          help = { icon = "" },
          input = { view = "cmdline_input", icon = " 󰥻  " },
        },
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
      },
    },
    dependencies = { "MunifTanjim/nui.nvim" },
  },

  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    keys = {
      {
        "<m-g>",
        function()
          require("grug-far").grug_far({ prefills = { flags = vim.fn.expand("%") } })
        end,
        mode = "n",
        desc = "Grug finder",
      },
    },
    config = function()
      -- there is also ~/code/dotfiles/home/vim/ftplugin/grug-far.lua
      require("grug-far").setup({
        windowCreationCommand = "new",
        keymaps = {
          abort                      = { n = "<localleader>b" },
          applyNext                  = { n = "<localleader>j" },
          applyPrev                  = { n = "<localleader>k" },
          close                      = { n = "<localleader>c" },
          gotoLocation               = { n = "<enter>" },
          help                       = { n = "g?" },
          historyAdd                 = { n = "<localleader>a" },
          historyOpen                = { n = "<localleader>t" },
          openLocation               = { n = "<localleader>o" },
          openNextLocation           = { n = "<down>" },
          openPrevLocation           = { n = "<up>" },
          pickHistoryEntry           = { n = "<enter>" },
          previewLocation            = { n = "<localleader>i" },
          qflist                     = { n = "<localleader>q" },
          refresh                    = { n = "<localleader>f" },
          replace                    = { n = "<localleader>r" },
          swapEngine                 = { n = "<localleader>e" },
          swapReplacementInterpreter = { n = "<localleader>x" },
          syncLine                   = { n = "<localleader>l" },
          syncLocations              = { n = "<localleader>s" },
          toggleShowCommand          = { n = "<localleader>p" },
        },
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("grug-far-keymap", { clear = true }),
        pattern = { "grug-far" },
        callback = function()
          -- jump back to search input by hitting left arrow in normal mode:
          vim.keymap.set("n", "<left>", function()
            vim.api.nvim_win_set_cursor(vim.fn.bufwinid(0), { 2, 0 })
          end, { buffer = true })
        end,
      })

      -- :lua require('grug-far').grug_far({ prefills = { search = vim.fn.expand("<cword>") } })
      -- Launch with the current file as a flag, which limits search/replace to it
      --
      -- :lua require('grug-far').grug_far({ prefills = { flags = vim.fn.expand("%") } })
      -- Launch with the current visual selection, searching only current file
      --
      -- :<C-u>lua require('grug-far').with_visual_selection({ prefills = { flags = vim.fn.expand("%") } })
      -- require('grug-far').grug_far({ prefills = { search = vim.fn.expand("<cword>") } })
      -- nmap("<m-f>", function() require("grug-far").grug_far({ prefills = { flags = "--ignore-case" } }) end)

      -- vim.keymap("n", )
    end,
  },

  {
    "gbprod/yanky.nvim",
    enabled = true,
    dependencies = { "kkharji/sqlite.lua" },
    config = function()
      require("yanky").setup({
        preserve_cursor_position = {
          enabled = true,
        },
        textobj = {
          enabled = true,
        },
        ring = {
          storage = "sqlite",
        },
        highlight = {
          on_put = true,
          on_yank = true,
          timer = HighlightDuration,
        },
      })
      s_nmap("p", "<Plug>(YankyPutAfter)")
      s_nmap("P", "<Plug>(YankyPutBefore)")

      s_nmap("]y", "<Plug>(YankyCycleForward)", "Next paste")
      s_nmap("[y", "<Plug>(YankyCycleBackward)", "Last paste")

      vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")

      vim.keymap.set({ "o" }, "P", function()
        require("yanky.textobj").last_put()
      end, { desc = "last put" })

      s_nmap("=p", "<Plug>(YankyPutAfterFilter)", "paste with autoindent below")
      s_nmap("=P", "<Plug>(YankyPutBeforeFilter)", "paste with autoindent above")

      -- { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank Text" },
      -- { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put Text After Cursor" },
      -- { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put Text Before Cursor" },
      -- { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put Text After Selection" },
      -- { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put Text Before Selection" },
      -- { "[y", "<Plug>(YankyCycleForward)", desc = "Cycle Forward Through Yank History" },
      -- { "]y", "<Plug>(YankyCycleBackward)", desc = "Cycle Backward Through Yank History" },
      -- { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put Indented After Cursor (Linewise)" },
      -- { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put Indented Before Cursor (Linewise)" },
      -- { "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put Indented After Cursor (Linewise)" },
      -- { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put Indented Before Cursor (Linewise)" },
      -- { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and Indent Right" },
      -- { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and Indent Left" },
      -- { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put Before and Indent Right" },
      -- { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put Before and Indent Left" },
      -- { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put After Applying a Filter" },
      -- { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put Before Applying a Filter" },

      vim.cmd([[hi YankyYanked guifg=#FFFFFF guibg=#FF9509]])
    end,
  },

  {
    "justinmk/vim-gtfo",
    keys = {
      { "got", desc = "go to current directory in terminal" },
      { "goT", desc = "go to current working directory in terminal" },
      { "gof", desc = "go to current file in Finder" },
      { "goF", desc = "go to current working file in Finder" },
    },
    config = function()
      vim.g["gtfo#terminals"] = { ["mac"] = "ghostty" }
    end,
  },

  {
    "chrisgrieser/nvim-scissors",
    cmd = { "Esnippets", "Asnippet" },
    config = function()
      local scissors = require("scissors")

      scissors.setup({
        snippetDir = vim.fn.stdpath("config") .. "/snippets",
        editSnippetPopup = {
          height = 0.95,
          width = 0.95,
          keymaps = {
            saveChanges = "<leader>w",
          },
        },
        jsonFormatter = "jq",
      })

      User("Esnippets", function()
        scissors.editSnippet()
      end, {})
      User("Asnippet", function()
        scissors.addNewSnippet()
      end, {})

      s_vmap("<leader>n", function()
        scissors.addNewSnippet()
      end, {}, "Add Snippet")
    end,
  },

  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    -- config = function()
    --   s_nmap("<space>q", vim.cmd.cclose, "close quickfix")
    --   require("bqf").setup({
    --     func_map = {
    --       stoggleup = "",
    --       -- stoggledown = "",
    --     },
    --   })
    -- end,
  },

  {
    "mrshmllow/open-handlers.nvim",
    cond = vim.ui.open ~= nil,
    config = function()
      local oh = require("open-handlers")

      local function git_url(path)
        local match = string.match(path, "^([^/][A-Z,a-z,0-9,_.-]+/+[A-Z,a-z,0-9,_.-]+)")
        if match then
          return oh.native("https://github.com/" .. match)
        end

        return nil, nil
      end

      local function github_url(path)
        local match = string.match(path, "^github.com/([^/][A-Z,a-z,0-9,_.-]+/+[A-Z,a-z,0-9,_.-]+)")
        if match then
          return oh.native("https://github.com/" .. match)
        end

        return nil, nil
      end

      oh.setup({
        handlers = { github_url, git_url, oh.issue, oh.commit, oh.native },
      })
    end,
  },

  { "tpope/vim-abolish" },
  { "tpope/vim-eunuch" },
  { "tpope/vim-repeat" },
  { "tpope/vim-rsi" },

  {
    "serhez/bento.nvim",
    opts = { ui = {} }
  }, -- buffer management
  -- ALT: "aidancz/buvvers.nvim",
  -- come back when https://github.com/neovim/neovim/issues/29365 is fixed
  -- ALT: https://github.com/otavioschwanck/arrow.nvim
  -- ALT: https://github.com/j-morano/buffer_manager.nvim
  -- ALT: https://github.com/cbochs/grapple.nvim
  -- ALT: https://github.com/neovim-idea/switcher-nvim
  -- ALT: https://github.com/voxelprismatic/rabbit.nvim

  -- {
  --   "m4xshen/hardtime.nvim",
  --   lazy = false,
  --   dependencies = { "MunifTanjim/nui.nvim" },
  --   opts = function(_, opts)
  --     opts.restriction_mode = "hint"
  --     opts.hints = {
  --       ["v[{}]"] = {
  --         message = function(keys)
  --           return "Try to select with motions instead of " .. keys
  --         end,
  --         length = 3,
  --       },
  --     }
  --
  --     opts.restricted_keys = opts.restricted_keys or {}
  --     opts.restricted_keys["gj"] = false
  --     opts.restricted_keys["gk"] = false
  --     opts.restricted_keys["j"] = false
  --     opts.restricted_keys["k"] = false
  --   end,
  -- },


  -- https://github.com/tpope/vim-apathy
  -- https://github.com/kana/vim-niceblock
  -- https://github.com/rbong/vim-buffest
  -- https://github.com/EggbertFluffle/beepboop.nvim
  -- https://github.com/esmuellert/codediff.nvim
  -- https://github.com/KabbAmine/lazyList.vim
  -- https://github.com/Makaze/watch.nvim
  -- https://github.com/TheNoeTrevino/haunt.nvim
  -- https://github.com/folke/trouble.nvim
  -- https://github.com/jay-babu/mason-nvim-dap.nvim
  -- https://github.com/jokajak/keyseer.nvim
  -- https://github.com/yujinyuz/gitpad.nvim
}
