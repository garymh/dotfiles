local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "RRethy/nvim-treesitter-endwise",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "git@gitlab.com:HiPhish/rainbow-delimiters.nvim.git",
    { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
  },
  event = "BufReadPost",
}

-- "RRethy/nvim-treesitter-textsubjects",
-- "David-Kunz/markid",

function M.config()
  require("nvim-treesitter.configs").setup({
    additional_vim_regex_highlighting = false,
    ensure_installed = {
      "arduino",
      "dockerfile",
      "bash",
      "c",
      "cmake",
      "cpp",
      "css",
      "diff",
      "fish",
      "git_config",
      "git_rebase",
      "gitattributes",
      "gitcommit",
      "gitignore",
      "go",
      "gosum",
      "graphql",
      -- "help",
      "html",
      "http",
      "java",
      "javascript",
      "jsdoc",
      "json",
      "jsonnet",
      "jsonc",
      "lua",
      "luap",
      "make",
      "markdown",
      "markdown_inline",
      "php",
      "python",
      "query",
      "regex",
      "scss",
      "sql",
      "toml",
      "vim",
      "vue",
      "yaml",
    },
    sync_install = false,
    auto_install = true,
    -- ignore_install = { "comment" },
    highlight = {
      enable = true,
      disable = {
        "markdown",
      },
    },
    indent = {
      enable = false,
    },
    matchup = {
      enable = true,
    },
    endwise = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<Enter>",
        node_incremental = "<Enter>",
        node_decremental = "<BS>",
      },
    },
    textobjects = {
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]g"] = "@comment.outer",
          ["]]"] = { query = "@class.outer", desc = "Next class start" },
          --
          -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
          ["]o"] = "@loop.*",
          -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
          --
          -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
          -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
          ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
          ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
          ["[g"] = "@comment.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
        -- Below will go to either the start or the end, whichever is closer.
        -- Use if you want more granular movements
        -- Make it even more gradual by adding multiple queries and regex.
        goto_next = {
          ["]d"] = "@conditional.outer",
        },
        goto_previous = {
          ["[d"] = "@conditional.outer",
        },
      },
      select = {
        enable = true,
        lookahead = true,
        include_surrounding_whitespace = false,
        keymaps = {
          ["i/"] = { query = "@regex.inner", desc = "[TS] inner regex" },
          ["a/"] = { query = "@regex.outer", desc = "[TS] outer regex" },
          ["ic"] = { query = "@conditional.inner", desc = "[TS] inner [c]onditional" },
          ["ac"] = { query = "@conditional.outer", desc = "[TS] outer [c]onditional" },
          -- ["il"] = { query = "@call.inner",        desc = "[TS] inner cal[l]" },
          -- ["al"] = { query = "@call.outer",        desc = "[TS] outer cal[l]" },
          -- ["aa"] = { query = "@parameter.outer", desc = "[TS] Outside a function parameter" },
          -- ["ia"] = { query = "@parameter.inner", desc = "[TS] Inside a function parameter" },
          ["if"] = { query = "@function.inner", desc = "[TS] Outside a function" },
          ["af"] = { query = "@function.outer", desc = "[TS] Inside a function" },
          ["ar"] = { query = "@block.outer", desc = "[TS] Outside a block" },
          ["ir"] = { query = "@block.inner", desc = "[TS] Inside a block" },
          ["in"] = { query = "@number.inner", desc = "[TS] that thing" },
          -- ["iu"] = { query = "@loop.inner",        desc = "[TS] inner loop" },
          -- ["au"] = { query = "@loop.outer",        desc = "[TS] outer loop" },
          -- ["ik"] = { query = "@assignment.lhs", desc = "[TS] Outside a function" },
          -- ["iv"] = { query = "@assignment.rhs", desc = "[TS] Outside a function" },
          -- ["ak"] = { query = "@assignment.inner", desc = "[TS] Outside a function" },
          -- ["av"] = { query = "@assignment.outer", desc = "[TS] Outside a function" },
        },
      },
      --

      -- @assignment.inner
      -- @assignment.lhs
      -- @assignment.outer
      -- @assignment.rhs
      -- @attribute.inner
      -- @attribute.outer
      -- @block.inner
      -- @block.outer
      -- @call.inner
      -- @call.outer
      -- @class.inner
      -- @class.outer
      -- @comment.inner
      -- @comment.outer
      -- @conditional.inner
      -- @conditional.outer
      -- @frame.inner
      -- @frame.outer
      -- @function.inner
      -- @function.outer
      -- @loop.inner
      -- @loop.outer
      -- @number.inner
      -- @parameter.inner
      -- @parameter.outer
      -- @regex.inner
      -- @regex.outer
      -- @return.inner
      -- @return.outer
      -- @scopename.inner
      -- @statement.outer

      swap = {
        enable = true,
        swap_next = {
          ["<localleader><tab>"] = "@parameter.inner",
        },
        swap_previous = {
          ["<localleader><s-tab>"] = "@parameter.inner",
        },
      },
      lsp_interop = {
        enable = true,
        border = "none",
        peek_definition_code = {
          ["<leader>df"] = "@function.outer",
          ["<leader>dF"] = "@class.outer",
        },
      },
    },
    -- textsubjects = {
    --   enable = true,
    --   keymaps = {
    --     ["."] = "textsubjects-smart",
    --     [";"] = "textsubjects-container-outer",
    --   },
    -- },
  })
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

  -- vim.treesitter.language.register("bash", "zsh")

  -- This module contains a number of default definitions

  if vim.fn.has('nvim-0.9.0dev') == 1 then
    local rainbow_delimiters = require 'rainbow-delimiters'

    vim.g.rainbow_delimiters = {
      strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        vim = rainbow_delimiters.strategy['local'],
      },
      query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
      },
      highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
      },
    }
  end
end

return M

-- @assignment.inner
-- @assignment.lhs
-- @assignment.outer
-- @assignment.rhs
-- @attribute.inner
-- @attribute.outer
-- @block.inner
-- @block.outer
-- @call.inner
-- @call.outer
-- @class.inner
-- @class.outer
-- @comment.inner
-- @comment.outer
-- @conditional.inner
-- @conditional.outer
-- @frame.inner
-- @frame.outer
-- @function.inner
-- @function.outer
-- @loop.inner
-- @loop.outer
-- @number.inner
-- @parameter.inner
-- @parameter.outer
-- @regex.inner
-- @regex.outer
-- @return.inner
-- @return.outer
-- @scopename.inner
-- @statement.outer
