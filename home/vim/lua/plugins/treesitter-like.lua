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
        'ruby',
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
      allow_vim_regex = {},
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
      local ts = require('nvim-treesitter')

      --
      -- local group = vim.api.nvim_create_augroup('TreesitterSetup', { clear = true })
      --
      -- local ignore_filetypes = {
      --   'checkhealth',
      --   'lazy',
      --   'mason',
      --   'snacks_dashboard',
      --   'snacks_notif',
      --   'snacks_win',
      -- }
      --
      -- vim.api.nvim_create_autocmd('FileType', {
      --   group = group,
      --   desc = 'Enable treesitter highlighting and indentation',
      --   callback = function(event)
      --     if vim.tbl_contains(ignore_filetypes, event.match) then
      --       return
      --     end
      --
      --     local lang = vim.treesitter.language.get_lang(event.match) or event.match
      --     local buf = event.buf
      --
      --     pcall(vim.treesitter.start, buf, lang)
      --
      --     vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      --     vim.wo.foldmethod = 'expr'
      --     vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      --
      --     ts.install({ lang })
      --   end,
      -- })

      local parsers_loaded = {}
      local parsers_pending = {}
      local parsers_failed = {}

      local ns = vim.api.nvim_create_namespace "treesitter.start"

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
              vim._with({ win = data.winnr, buf = data.bufnr }, function()
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
              lang = lang,
              winnr = vim.api.nvim_get_current_win(),
              bufnr = event.buf,
            })
          end
        end,
      })

      vim.api.nvim_create_user_command("TSInstallAll", function()
        require("nvim-treesitter").install(opts.ensure_install)
      end, {})
















      require("nvim-treesitter-textobjects").setup {}

      -- @assignment.inner @assignment.lhs @assignment.outer @assignment.rhs
      -- @attribute.inner @attribute.outer
      -- @block.inner @block.outer
      -- @call.inner @call.outer
      -- @class.inner @class.outer
      -- @comment.inner @comment.outer
      -- @conditional.inner @conditional.outer
      -- @frame.inner @frame.outer
      -- @function.inner @function.outer
      -- @loop.inner @loop.outer
      -- @number.inner
      -- @parameter.inner @parameter.outer
      -- @regex.inner @regex.outer
      -- @return.inner @return.outer
      -- @scopename.inner
      -- @statement.outer

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

      if Nv9 then
        local rainbow_delimiters = require("rainbow-delimiters")

        vim.g.rainbow_delimiters = {
          strategy = {
            [""] = rainbow_delimiters.strategy["global"],
            vim = rainbow_delimiters.strategy["local"],
            help = nil,
          },
          query = {
            [""] = "rainbow-delimiters",
            lua = "rainbow-blocks",
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
    end
  },

  {
    "Wansmer/sibling-swap.nvim", -- this is much better than stock treesitter's
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
    "nvim-mini/mini.nvim",
    version = false,
    enabled = true,
    opts = function()
      _G.plugin_on_load("which-key.nvim", function()
        local objects = {
          { " ", desc = "whitespace" },
          { "'", desc = "' string" },
          { "(", desc = "() block" },
          { ")", desc = "() block with ws" },
          { "-", desc = "line" },
          { "<", desc = "<> block" },
          { ">", desc = "<> block with ws" },
          { "?", desc = "user prompt" },
          { "D", desc = "date" },
          { "F", desc = "other? function" },
          { "L", desc = "to end of line" },
          { "S", desc = "subword" },
          { "U", desc = "function call" },
          { "[", desc = "[] block" },
          { "]", desc = "[] block with ws" },
          { "_", desc = "underscore" },
          { "`", desc = "` string" },
          { "a", desc = "argument" },
          { "b", desc = ")]} block" },
          { "c", desc = "class" },
          { "e", desc = "entire buffer" },
          { "f", desc = "function" },
          { "i", desc = "indent" },
          { "j", desc = "any bracket" },
          { "k", desc = "key" },
          { "#", desc = "number(s)" },
          { "o", desc = "block, conditional, loop" },
          { "q", desc = "quote `\"'" },
          { "r", desc = "return" },
          { "t", desc = "tag" },
          { "u", desc = "use/call" },
          { "v", desc = "value" },
          { "{", desc = "{} block" },
          { "}", desc = "{} with ws" },
          { '"', desc = '" string' },
          { "o", desc = "loop" },
          { "x", desc = "lhs" },
          { "y", desc = "rhs" },
          { "!", desc = "diagnostic" },
          { "/", desc = "regex" },
          { "z", desc = "something?" },
        }

        local ret = { mode = { "o", "x" } }
        local mappings = {
          around      = "a",
          inside      = "i",
          around_next = "an",
          inside_next = "in",
          around_last = "al",
          inside_last = "il",
          goto_left   = 'g[',
          goto_right  = 'g]',
        }
        for name, prefix in pairs(mappings) do
          name = name:gsub("^around_", ""):gsub("^inside_", "")
          ret[#ret + 1] = { prefix, group = name }
          for _, obj in ipairs(objects) do
            local desc = obj.desc
            if prefix:sub(1, 1) == "i" then desc = desc:gsub(" with ws", "") end
            ret[#ret + 1] = { prefix .. obj[1], desc = obj.desc }
          end
        end
        require("which-key").add(ret, { notify = false })
      end)
    end,

    config = function()
      require("mini.operators").setup({
        multiply = { prefix = "yd" },
        evaluate = { prefix = "g=" },
        exchange = { prefix = "gX", reindent_linewise = true },
        replace  = { prefix = "" },
        sort     = { prefix = "" },
      })

      local extra = require("mini.extra")
      local ai = require("mini.ai")
      local spec_treesitter = ai.gen_spec.treesitter
      local gen_ai_spec = extra.gen_ai_spec

      ai.setup({
        custom_textobjects = {

          F = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),

          D = { "()%d%d%d%d%-%d%d%-%d%d()" },

          S = { { '%u[%l%d]+%f[^%l%d]', '%f[%S][%l%d]+%f[^%l%d]', '%f[%P][%l%d]+%f[^%l%d]', '^[%l%d]+%f[^%l%d]', }, '^().*()$' },

          U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name

          -- a = spec_treesitter({ i = "@custom_capture", a = "@custom_capture" }),
          -- TODO: add this

          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class

          e = gen_ai_spec.buffer(),

          j = { { "%b()", "%b[]", "%b{}", "%b<>" }, "^.().*().$" },

          k = spec_treesitter({
            i = { "@assignment.lhs", "@key.inner" },
            a = { "@assignment.outer", "@key.inner" },
          }),

          h = spec_treesitter({ i = "@call.inner", a = "@call.outer" }),

          o = spec_treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),

          r = spec_treesitter({ i = "@return.inner", a = "@return.outer" }),

          u = ai.gen_spec.function_call(),

          v = spec_treesitter({
            i = { "@assignment.lhs", "@key.inner" },
            a = { "@assignment.outer", "@key.inner" },
          }),

          x = spec_treesitter({ i = { "@assignment.lhs" }, a = { "@assignment.lhs" } }),

          y = spec_treesitter({ i = { "@assignment.rhs" }, a = { "@assignment.rhs" } }),

          z = spec_treesitter({ i = { "@statement.outer" }, a = { "@statement.outer" } }),
          -- could this include line breaks?

          ["-"] = gen_ai_spec.line(),

          ["!"] = gen_ai_spec.diagnostic(),

          ["/"] = spec_treesitter({ i = { "@regex.inner" }, a = { "@regex.outer" } }),

          ["#"] = gen_ai_spec.number(),
        },
      })

      s_oxmap("L", "$", "endofline")
      vim.keymap.set({ "x", "o" }, "K", "g]j", { remap = true, desc = "end of brace" })
      vim.keymap.set({ "x", "o" }, "Q", "g]q", { remap = true, desc = "end of quote" })

      require("mini.operators").setup({
        multiply = { prefix = "yd" },
        evaluate = { prefix = "g=" },
        exchange = { prefix = "gX", reindent_linewise = true },
        replace  = { prefix = "" },
        sort     = { prefix = "" },
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

      local textobjs = require("various-textobjs")
      textobjs.setup({
        keymaps = {
          useDefaults = false,
        },
      })

      s_nmap("dsi", function()
        -- select inner indentation
        textobjs.indentation(true, true)

        local notOnIndentedLine = vim.fn.mode():find("V") == nil
        if notOnIndentedLine then return end

        vim.cmd.normal({ ">", bang = true })

        -- delete surrounding lines
        local endBorderLn = vim.api.nvim_buf_get_mark(0, ">")[1] + 1
        local startBorderLn = vim.api.nvim_buf_get_mark(0, "<")[1] - 1
        vim.cmd(tostring(endBorderLn) .. " delete") -- delete end first so line index is not shifted
        vim.cmd(tostring(startBorderLn) .. " delete")
      end, "Delete surrounding indentation")

      s_oxmap("g;", "<cmd>lua require('various-textobjs').lastChange()<CR>", "last change")

      s_oxmap("i|", "<cmd>lua require('various-textobjs').column()<CR>", "column")
      s_oxmap("iC", "<cmd>lua require('various-textobjs').multiCommentedLines()<CR>", "commented lines")
    end,
  },
}

-- -- "David-Kunz/markid",


-- s_oxmap("iv", "<cmd>lua require('various-textobjs').value('inner')<CR>", "inner value")
-- s_oxmap("av", "<cmd>lua require('various-textobjs').value('outer')<CR>", "outer value")
--
-- s_oxmap("ik", "<cmd>lua require('various-textobjs').key('inner')<CR>", "inner key")
-- s_oxmap("ak", "<cmd>lua require('various-textobjs').key('outer')<CR>", "outer key")
-- s_oxmap("im", "<cmd>lua require('various-textobjs').chainMember('inner')<CR>", "inner member")
-- s_oxmap("am", "<cmd>lua require('various-textobjs').chainMember('outer')<CR>", "outer member")
-- s_oxmap("ii", "<cmd>lua require('various-textobjs').indentation('inner', 'inner')<CR>", "inner indentation")
-- s_oxmap("ai", "<cmd>lua require('various-textobjs').indentation('outer', 'inner')<CR>", "around indentation")
-- s_oxmap("iI", "<cmd>lua require('various-textobjs').indentation('inner', 'inner')<CR>", "inner Indentation")
-- s_oxmap("aI", "<cmd>lua require('various-textobjs').indentation('outer', 'outer')<CR>", "around Indentation")

-- s_oxmap("iU", "<cmd>lua require('various-textobjs').greedyOuterIndentation('inner')<CR>", "inner OUTindentation")
-- s_oxmap("aU", "<cmd>lua require('various-textobjs').greedyOuterIndentation('outer')<CR>", "around OUTindentation")

-- s_oxmap("is", "<cmd>lua require('various-textobjs').subword('inner')<CR>", "inner subword")
-- s_oxmap("as", "<cmd>lua require('various-textobjs').subword('outer')<CR>", "award subword")

-- s_oxmap("J", "<cmd>lua require('various-textobjs').toNextClosingBracket()<CR>", "to next bracket")
-- s_oxmap("Q", "<cmd>lua require('various-textobjs').toNextQuotationMark()<CR>", "to next quote")
-- MiniIndentscope.textobject|

-- s_oxmap("as", "<cmd>lua require('various-textobjs').subword('outer')<CR>", "award subword")
--
-- s_oxmap("J", "<cmd>lua require('various-textobjs').toNextClosingBracket()<CR>", "to next bracket")
-- s_oxmap("Q", "<cmd>lua require('various-textobjs').toNextQuotationMark()<CR>", "to next quote")
--
-- s_oxmap("g;", "<cmd>lua require('various-textobjs').lastChange()<CR>", "last change")
--
-- s_oxmap("i-", "<cmd>lua require('various-textobjs').lineCharacterwise('inner')<CR>", "line characterwise")
-- s_oxmap("a-", "<cmd>lua require('various-textobjs').lineCharacterwise('outer')<CR>", "line characterwise")
--
-- s_oxmap("i|", "<cmd>lua require('various-textobjs').column()<CR>", "column")
-- s_oxmap("iC", "<cmd>lua require('various-textobjs').multiCommentedLines()<CR>", "commented lines")
--
-- s_oxmap("iv", "<cmd>lua require('various-textobjs').value('inner')<CR>", "inner value")
-- s_oxmap("av", "<cmd>lua require('various-textobjs').value('outer')<CR>", "outer value")
--
-- s_oxmap("ik", "<cmd>lua require('various-textobjs').key('inner')<CR>", "inner key")
-- s_oxmap("ak", "<cmd>lua require('various-textobjs').key('outer')<CR>", "outer key")
--
-- s_oxmap("iu", "<cmd>lua require('various-textobjs').url()<CR>", "url")
-- s_oxmap("au", "<cmd>lua require('various-textobjs').url()<CR>", "url")
--
-- s_oxmap("im", "<cmd>lua require('various-textobjs').chainMember('inner')<CR>", "inner member")
-- s_oxmap("am", "<cmd>lua require('various-textobjs').chainMember('outer')<CR>", "outer member")

-- s_omap("io", [[:call TextObjWordBasedColumn("iw")<CR>]], "inner word in column")
-- s_omap("ao", [[:call TextObjWordBasedColumn("aw")<CR>]], "around word in column")
-- s_vmap("io", [[:<C-U>call TextObjWordBasedColumn("iw")<CR>]], "inner word in column")
-- s_vmap("ao", [[:<C-U>call TextObjWordBasedColumn("aw")<CR>]], "around word in column")
-- s_omap("iO", [[:call TextObjWordBasedColumn("iW")<CR>]], "inner WORD in column")
-- s_omap("aO", [[:call TextObjWordBasedColumn("aW")<CR>]], "around WORD in column")
-- s_vmap("iO", [[:<C-U>call TextObjWordBasedColumn("iW")<CR>]], "inner WORD in column")
-- k = function()
-- if vim.bo.filetype == "help" then
-- 	dd("yo")
-- elseif vim.bofiletype == "lua" then
-- 	dd("yo")
-- else

-- ["ac"] = { query = "@conditional.outer", desc = "[TS] outer [c]onditional" },
-- ["ad"] = { query = "@assignment.inner", desc = "[TS] Outside a function" },
-- ["ad"] = { query = "@assignment.inner", desc = "[TS] Outside a function" },
-- ["ah"] = { query = "@assignment.outer", desc = "[TS] Outside a function" },
-- ["ah"] = { query = "@assignment.outer", desc = "[TS] Outside a function" },
-- ["al"] = { query = "@call.outer",        desc = "[TS] outer cal[l]" },
-- ["ar"] = { query = "@block.outer", desc = "[TS] Outside a block" },
-- ["ic"] = { query = "@conditional.inner", desc = "[TS] inner [c]onditional" },
-- ["il"] = { query = "@call.inner",        desc = "[TS] inner cal[l]" },
-- ["iq"] = { query = "@loop.inner",        desc = "[TS] inner loop" },
-- ["ir"] = { query = "@block.inner", desc = "[TS] Inside a block" },
-- ["aq"] = treesitterObject("@loop.outer",      "outer loop"),
--
-- ["aa"] = treesitterObject("@parameter.outer", "outside a function parameter"),
-- ["ia"] = treesitterObject("@parameter.inner", "inside a function parameter"),
--
-- ["aE"] = treesitterObject("@custom_capture.outer", "outside a function parameter"),
-- ["iE"] = treesitterObject("@custom_capture.inner", "inside a function parameter"),
--
-- ["af"] = treesitterObject("@function.outer", "inside a function"),
-- ["if"] = treesitterObject("@function.inner", "outside a function"),
--
-- -- ["in"] = treesitterObject("@number.inner",    "that thing"),
--
-- ["ix"] = treesitterObject("@assignment.lhs", "key value left"),
-- ["iy"] = treesitterObject("@assignment.rhs", "key value right"),
-- local hi_words = require('mini.extra').gen_highlighter.words
-- require('mini.hipatterns').setup({
--   highlighters = {
--     todo = hi_words({ 'TODO', 'Todo', 'todo' }, 'MiniHipatternsTodo'),
--   },
-- })
