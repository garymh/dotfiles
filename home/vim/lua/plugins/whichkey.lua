local M = { "folke/which-key.nvim", }

function M.config()
  local presets = require("which-key.plugins.presets")
  local whichkey = require("which-key")

  local ignore_keys = { "a(", "a)", "i(", "i)", 'a"', 'i"', "a'", "i'", "a>", "i>", "a[", "i[", "a]", "i]", "a`", "i`",
    "a{", "i{", "a}", "i}", "a<", "i<", "aB", "iB", "ab", "ib" }

  for _, keybinding in ipairs(ignore_keys) do
    presets.objects[keybinding] = nil
  end

  whichkey.setup({
    plugins = {
      marks = true,       -- shows a list of your marks on ' and `
      registers = true,   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      spelling = {
        enabled = false,  -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        suggestions = 20, -- how many suggestions should be shown in the list?
      },
      presets = {
        operators = true,    -- adds help for operators like d, y, ... and registers them for motion / text object completion
        motions = true,      -- adds help for motions
        text_objects = true, -- help for text objects triggered after entering an operator
        windows = true,      -- default bindings on <c-w>
        nav = true,          -- misc bindings to work with windows
        z = true,            -- bindings for folds, spelling and others prefixed with z
        g = true,            -- bindings for prefixed with g
      },
    },
    operators = {
      gc            = "Comments",
      gy            = "Duplicate and comment",
      ga            = "Align",
      sa            = "Add surround to...",
      ["??"]        = "Google search..",
      ["?!"]        = "Google lucky search..",
      ["<leader>f"] = "Project search...",
      ["<leader>y"] = "System clipboard..",
    },
    key_labels = {},
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator  = "➜", -- symbol used between a key and it's label
      group      = "+", -- symbol prepended to a group
    },
    window = {
      border   = "none",         -- none, single, double, shadow
      position = "bottom",       -- bottom, top
      margin   = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
      padding  = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    },
    layout = {
      height  = { min = 4, max = 25 },                                            -- min and max height of the columns
      width   = { min = 20, max = 50 },                                           -- min and max width of the columns
      spacing = 3,                                                                -- spacing between columns
      align   = "left",                                                           -- align columns left, center or right
    },
    ignore_missing = false,                                                       -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<CMD>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = false,                                                            -- show help message on the command line when the popup is visible
    triggers = "auto",                                                            -- automatically setup triggers
    triggers_blacklist = {
      i = { "j", "k" },
      v = { "j", "k" },
    },
  })

  local ignore = [[which_key_ignore]]

  whichkey.register({
    g = {
      name  = "+goto",
      ["*"] = ignore,
      ["#"] = ignore,
      d     = [[definition]],
      D     = [[declaration]],
      g     = [[top]],
      I     = [[implementation]],
      l     = [[git...]],
      o     = [[open files...]],
      c     = {
        name = "+comment",
        c    = [[comment line]],
      },
    },

    y = {
      name = "+yank",
      ["o"] = {
        name = "+toggles",
        ["+"] = ignore,
        ["-"] = ignore,
        ["_"] = ignore,
        ["|"] = ignore,
        b = "background (dark/light)",
        c = "cursor line",
        d = "diffs",
        h = "highlight search",
        i = "ignorecase",
        l = "list chars",
        n = "absolute numbers",
        p = ignore,
        r = "relative numbers",
        s = "spelling",
        u = "cursor column",
        v = "virtualedit",
        w = "word wrapping",
        x = "cursor line + cursor column",
      },
    },

    z = {
      name = "+spelling/folds",
    },

    ["<leader>"] = {
      name = "+leader",
    },

    ["<space>"] = {
      name = "+spacebar",
      e    = [[Edit...]],
      ee   = [[in EE...]],
      et   = [[Specs...]],
      ete  = [[in EE...]]
    },

    ["\\"] = {
      name = "+localleader",
      c = [[Code Actions]],
      p = [[pry...]],
      s = [[Sideways...]]
    },

    ["["] = {
      name        = "+leftbrakcet",
      ["!"]       = [[prev diagnostic issue]],
      ["%"]       = [[prev unmatched group]],
      ["<C-L>"]   = ignore,
      ["<C-Q>"]   = ignore,
      ["<C-T>"]   = ignore,
      ["<space>"] = ignore,
      A           = ignore,
      B           = ignore,
      C           = ignore,
      L           = ignore,
      Q           = ignore,
      a           = ignore,
      e           = ignore,
      f           = [[prev file in directory]],
      l           = ignore,
      n           = [[git conflict marker]],
      q           = ignore,
      r           = ignore,
      s           = [[prev misspelled word]],
      t           = [[prev tab]],
      x           = ignore,
      o           = {
        name = [[Turn on...]],
        ["+"] = [[cursor line and column]],
        ["-"] = [[cursor line]],
        ["_"] = [[cursor line]],
        ["|"] = [[cursor column]],
        b = [[light background]],
        c = [[cursor line]],
        d = [[diff this]],
        h = [[search]],
        i = [[ignore case]],
        l = [[list characters]],
        n = [[numbers]],
        p = [[paste mode]],
        r = [[relative numbers]],
        s = [[spelling]],
        u = [[cursor column]],
        v = [[virtual edit]],
        w = [[wrap]],
        x = [[cursor line and column]],
      },
    },

    ["]"] = {
      name        = [[+rightbracket]],
      ["!"]       = [[next diagnostic issue]],
      ["%"]       = [[next unmatched group]],
      ["<C-L>"]   = ignore,
      ["<C-Q>"]   = ignore,
      ["<C-T>"]   = ignore,
      ["<space>"] = ignore,
      A           = ignore,
      B           = ignore,
      C           = ignore,
      L           = ignore,
      Q           = ignore,
      a           = ignore,
      e           = ignore,
      f           = [[next file in directory]],
      l           = ignore,
      n           = [[git conflict marker]],
      q           = ignore,
      r           = ignore,
      s           = [[next misspelled word]],
      t           = [[next tab]],
      x           = ignore,
      o           = {
        name = [[Turn off...]],
        ["+"] = [[cursor line and column]],
        ["-"] = [[cursor line]],
        ["_"] = [[cursor line]],
        ["|"] = [[cursor column]],
        b = [[light background]],
        c = [[cursor line]],
        d = [[diff this]],
        h = [[search]],
        i = [[ignore case]],
        l = [[list characters]],
        n = [[numbers]],
        p = [[paste mode]],
        r = [[relative numbers]],
        s = [[spelling]],
        u = [[cursor column]],
        v = [[virtual edit]],
        w = [[wrap]],
        x = [[cursor line and column]],
      },
    },
  })

  whichkey.register({
    ["\\"] = {
    },
  }, { mode = "v" })

  function ClearReg()
    print('Clearing registers')
    vim.cmd [[
    let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
    for r in regs
    call setreg(r, [])
    endfor
]]
  end

  --Make it so i can call ClearReg as a command
  vim.api.nvim_create_user_command('ClearReg', function()
    ClearReg()
  end, {})
end

return M
