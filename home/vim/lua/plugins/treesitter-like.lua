return {
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = true,
    lazy = false,
    build = ":TSUpdate",
    opts = {
      ensure_install = {
        'bash',
        'comment',
        'clojure',
        'css',
        'diff',
        'fish',
        'git_config',
        'git_rebase',
        'gitattributes',
        'gitcommit',
        'gitignore',
        'go',
        'gomod',
        'gosum',
        'gowork',
        'graphql',
        'html',
        'javascript',
        'json',
        'jsonc',
        'latex',
        'lua',
        'luadoc',
        'make',
        'markdown',
        'markdown_inline',
        'python',
        'query',
        'regex',
        'scss',
        'svelte',
        'toml',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
        'vue',
        'xml',
        'yaml',
      },
      allow_vim_regex = {
        "csv",
        "ruby"
      },
    },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        init = function()
          vim.g.no_plugin_maps = true
        end,
      },
      "HiPhish/rainbow-delimiters.nvim",
    },
    branch = "main",
    event = "BufReadPost",
    config = function(_, opts)
      local ns              = vim.api.nvim_create_namespace "treesitter.start"
      local tso             = require("nvim-treesitter-textobjects")
      local ts              = require("nvim-treesitter")

      local parsers_loaded  = {}
      local parsers_pending = {}
      local parsers_failed  = {}

      ---@param lang string
      local function start(lang)
        local ok = pcall(vim.treesitter.start, 0, lang)
        if not ok then
          return false
        end

        if vim.tbl_contains(opts.allow_vim_regex, vim.bo.filetype) then
          vim.bo.syntax = "on"
        end

        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"

        return true
      end

      vim.api.nvim_set_decoration_provider(ns, {
        on_start = vim.schedule_wrap(function()
          if #parsers_pending == 0 then
            return false
          end
          for _, data in ipairs(parsers_pending) do
            if vim.api.nvim_win_is_valid(data.winnr) and vim.api.nvim_buf_is_valid(data.bufnr) then
              vim._with({ buf = data.bufnr }, function()
                if start(data.lang) then
                  parsers_loaded[data.lang] = true
                else
                  parsers_failed[data.lang] = true
                end
              end)
            end
          end
          parsers_pending = {}
        end),
      })

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(event)
          local lang = vim.treesitter.language.get_lang(event.match)
          if not lang or parsers_failed[lang] then
            return
          end

          if parsers_loaded[lang] then
            start(lang)
          else
            table.insert(parsers_pending, {
              lang  = lang,
              winnr = vim.api.nvim_get_current_win(),
              bufnr = event.buf,
            })
          end
        end,
      })

      vim.api.nvim_create_user_command("TSInstallAll", function()
        ts.install(opts.ensure_install)
      end, {})

      tso.setup {}

      local ts_move = require("nvim-treesitter-textobjects.move")
      local ts_swap = require("nvim-treesitter-textobjects.swap")

      s_noxmap("[M", function() ts_move.goto_previous_end("@function.outer", "textobjects") end, "Previous function end")
      s_noxmap("[X", function() ts_move.goto_previous("@loop.outer", "textobjects") end, "Previous loop")
      s_noxmap("[d", function() ts_move.goto_previous("@conditional.outer", "textobjects") end, "Previous conditional")
      s_noxmap("[m", function() ts_move.goto_previous_start("@function.outer", "textobjects") end,
        "Previous function start")
      s_noxmap("[r", function() ts_move.goto_previous("@return.inner", "textobjects") end, "Previous return")
      s_noxmap("]M", function() ts_move.goto_next_end("@function.outer", "textobjects") end, "Next function end")
      s_noxmap("]X", function() ts_move.goto_next("@loop.outer", "textobjects") end, "Next loop")
      s_noxmap("]d", function() ts_move.goto_next("@conditional.outer", "textobjects") end, "Next conditional")
      s_noxmap("]m", function() ts_move.goto_next_start("@function.outer", "textobjects") end, "Next function start")
      s_noxmap("]o", function() ts_move.goto_next_start("@loop.*", "textobjects") end, "Next loop start")
      s_noxmap("]r", function() ts_move.goto_next("@return.inner", "textobjects") end, "Next return")
      s_noxmap("]s", function() ts_move.goto_next_start({ query = "@scope", query_group = "locals" }, "textobjects") end,
        "Next scope")
      s_noxmap("]z", function() ts_move.goto_next_start({ query = "@fold", query_group = "folds" }, "textobjects") end,
        "Next fold")

      s_nmap("<localleader>f", function() ts_swap.swap_next("@function.outer") end, "Swap with next function")
      s_nmap("<localleader>F", function() ts_swap.swap_previous("@function.outer") end, "Swap with previous function")

      local rainbow_delimiters = require("rainbow-delimiters")

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim  = rainbow_delimiters.strategy["local"],
          help = nil,
        },
        query = {
          [""] = "rainbow-delimiters",
          lua  = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end
  },

  {
    "Wansmer/sibling-swap.nvim",
    dependencies = { "nvim-treesitter" },
    keys = {
      { "<C-.>",    desc = "sibling swap: left" },
      { "<C-,>",    desc = "sibling swap: right" },
      { "<space>.", desc = "sibling swap: left with opp" },
      { "<space>,", desc = "sibling swap: right with opp" },
    },
    config = function()
      require("sibling-swap").setup({
        keymaps = {
          ["<C-.>"]    = "swap_with_right",
          ["<C-,>"]    = "swap_with_left",
          ["<space>."] = "swap_with_right_with_opp",
          ["<space>,"] = "swap_with_left_with_opp",
        },
      })
    end,
  },

  {
    "chrisgrieser/nvim-various-textobjs",
    enabled = true,
    dependencies = {
      "coderifous/textobj-word-column.vim",
    },

    init = function() vim.g.skip_default_textobj_word_column_mappings = true end,
    config = function()
      s_omap("io", [[:call TextObjWordBasedColumn("iw")<CR>]], "inner word in column")
      s_omap("ao", [[:call TextObjWordBasedColumn("aw")<CR>]], "around word in column")
      s_vmap("io", [[:<C-U>call TextObjWordBasedColumn("iw")<CR>]], "inner word in column")
      s_vmap("ao", [[:<C-U>call TextObjWordBasedColumn("aw")<CR>]], "around word in column")
      s_omap("iO", [[:call TextObjWordBasedColumn("iW")<CR>]], "inner WORD in column")
      s_omap("aO", [[:call TextObjWordBasedColumn("aW")<CR>]], "around WORD in column")
      s_vmap("iO", [[:<C-U>call TextObjWordBasedColumn("iW")<CR>]], "inner WORD in column")

      require("various-textobjs").setup({
        keymaps = {
          useDefaults = false,
        },
      })

      s_nmap("dsi", function()
        require("various-textobjs").indentation(true, true)

        local notOnIndentedLine = vim.fn.mode():find("V") == nil
        if notOnIndentedLine then return end

        vim.cmd.normal({ ">", bang = true })

        local endBorderLn   = vim.api.nvim_buf_get_mark(0, ">")[1] + 1
        local startBorderLn = vim.api.nvim_buf_get_mark(0, "<")[1] - 1
        vim.cmd(tostring(endBorderLn) .. " delete")
        vim.cmd(tostring(startBorderLn) .. " delete")
      end, "Delete surrounding indentation")

      s_oxmap("g;", "<cmd>lua require('various-textobjs').lastChange()<CR>", "last change")
      s_oxmap("i|", "<cmd>lua require('various-textobjs').column()<CR>", "column")
      s_oxmap("iC", "<cmd>lua require('various-textobjs').multiCommentedLines()<CR>", "commented lines")
    end,
  },
}
