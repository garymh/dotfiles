local indentChar = "┊"
-- alternate: "▎"

local M = {
  "folke/snacks.nvim",
  priority = 1000,
  enabled = true,
  lazy = false,
  opts = {
    animate      = {
      enabled = true,    -- ensure animations are active
      duration = 20,     -- duration per step in ms
      easing = "linear", -- easing function (default is "linear")
      fps = 60,          -- global frames per second for all animations
    },

    bigfile      = {},
    bufdelete    = {},
    debug        = {},
    dim          = {
      enabled = true,
      scope = {
        min_size = 5,
        max_size = 20,
        siblings = true,
      },
      animate = {
        easing = "outQuad",
        duration = {
          step = 20,
          total = 300,
        },
      },
      filter = function(buf)
        return vim.bo[buf].filetype ~= "markdown"
            and vim.g.snacks_dim ~= false
            and vim.b[buf].snacks_dim ~= false
            and vim.bo[buf].buftype == ""
      end,
    },

    explorer     = {
      enabled = false
    },
    image        = {},

    notify       = {},
    notifier     = {
      timeout = 3000,
      style = "compact",
    },

    indent       = {
      animate = {
        enabled = false,
      },
      indent  = {
        enabled = false, -- Turn off standard indent lines
      },
      scope   = {
        enabled      = true, -- Turn on scope lines
        priority     = 200,
        char         = indentChar,
        underline    = false,
        only_current = true, -- Only show scope lines for the scope under cursor
        hl           = "SnacksIndentScope",
      },
    },

    input        = {},
    git          = {},
    gitbrowse    = {},
    lazygit      = {},
    quickfile    = {},
    scope        = {},

    picker       = {
      enabled = false,
    },

    statuscolumn = {
      enabled = false,
      left    = { "mark", "sign" },
      right   = { "fold", "git" },
      folds   = {
        open   = false,
        git_hl = false,
      },
      git     = {
        patterns = { "GitSign", "MiniDiffSign" },
      },
      refresh = 50,
    },

    terminal     = {},
    toggle       = {},
    win          = {},
    words        = {},
    styles       = {
      notification = {
        wo = { wrap = true, }, -- Wrap notifications
      },
    },
    zen          = {},
  },

  keys = {
    { "<leader>un", function() Snacks.notifier.hide() end,      desc = "Dismiss All Notifications" },
    { "<leader>.",  function() Snacks.scratch() end,            desc = "Toggle Scratch Buffer" },
    { "<leader>bd", function() Snacks.bufdelete() end,          desc = "Delete Buffer" },
    { "<leader>gg", function() Snacks.lazygit() end,            desc = "Lazygit" },
    { "<leader>gb", function() Snacks.git.blame_line() end,     desc = "Git Blame Line" },
    { "<leader>gB", function() Snacks.gitbrowse() end,          desc = "Git Browse" },
    { "<leader>gf", function() Snacks.lazygit.log_file() end,   desc = "Lazygit Current File History" },
    { "<leader>gl", function() Snacks.lazygit.log() end,        desc = "Lazygit Log (cwd)" },
    { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
    { "<c-_>",      function() Snacks.terminal() end,           desc = "which_key_ignore" },

    { "yoz",        function() Snacks.zen() end,                desc = "Toggle Zen Mode" },
    { "yoZ",        function() Snacks.zen.zoom() end,           desc = "Toggle Zoom" },

    { "<leader>S",  function() Snacks.scratch.select() end,     desc = "Select Scratch Buffer" },

    -- { "<space>d",       function() filePicker("Dotfiles", D, "*") end,                                         desc = "Dotfiles" },
    -- -- { "<leader>T",   function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
    -- { "<space><space>", function() Snacks.picker() end,                                                        desc = "Command History" },
    -- { "<space>y",       vim.cmd.YankyRingHistory,                                                              desc = "yank history" },
    -- { "<leader>sw",     function() Snacks.picker.grep_word() end,                                              desc = "Visual selection or word",    mode = { "n", "x" } },
    -- { "<leader>sa",     function() Snacks.picker.autocmds() end,                                               desc = "Autocmds" },
    -- { "<leader>sC",     function() Snacks.picker.commands() end,                                               desc = "Commands" },
    -- { "<leader>sd",     function() Snacks.picker.diagnostics() end,                                            desc = "Diagnostics" },
    -- { "<leader>sH",     function() Snacks.picker.highlights() end,                                             desc = "Highlights" },
    -- { "<leader>sk",     function() Snacks.picker.keymaps() end,                                                desc = "Keymaps" },
    -- { "<leader>sl",     function() Snacks.picker.loclist() end,                                                desc = "Location List" },
    -- { "<leader>sM",     function() Snacks.picker.man() end,                                                    desc = "Man Pages" },
    -- { "<leader>sm",     function() Snacks.picker.marks() end,                                                  desc = "Marks" },
    -- { "<leader>sR",     function() Snacks.picker.resume() end,                                                 desc = "Resume" },
    -- { "<leader>sq",     function() Snacks.picker.qflist() end,                                                 desc = "Quickfix List" },
    -- { "<leader>uC",     function() Snacks.picker.colorschemes() end,                                           desc = "Colorschemes" },

    {
      "<D-d>",
      function()
        Snacks.terminal(nil, {
          win = { style = { position = "right", height = 0.5, width = 0.5 } }
        })
      end,
      desc = "Terminal bottom"
    },

    {
      "<D-D>",
      function()
        Snacks.terminal(nil, {
          win = { style = { position = "right", height = 0.5, width = 0.5 } }
        })
      end,
      desc = "Terminal right"
    },

    {
      "]]",
      function() Snacks.words.jump(vim.v.count1) end,
      desc = "Next Reference",
      mode = { "n" },
    },
    {
      "[[",
      function() Snacks.words.jump(-vim.v.count1) end,
      desc = "Prev Reference",
      mode = { "n" },
    },

    { "glb", function() Snacks.git.blame_line() end, desc = "Git blame" },
    { "glw", function() Snacks.gitbrowse() end,      desc = "browse on remote" },

    {
      "glw",
      function()
        Snacks.gitbrowse()
      end,
      desc = "browse on remote",
      mode = "v"
    },

    {
      "<leader>N",
      desc = "Neovim News",
      function()
        Snacks.win({
          file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = "yes",
            statuscolumn = " ",
            conceallevel = 3,
          },
        })
      end,
    },
  },

  init = function()
    Snacks = _G.Snacks

    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        _G.dd = function(...) Snacks.debug.inspect(...) end
        _G.bt = function() Snacks.debug.backtrace() end

        vim.print = _G.dd -- Override print to use snacks for `:=` command

        Snacks.toggle.option("colorcolumn", {
          off = "",
          on = "81",
          name = "Color column",
        }):map("yoC")

        Snacks.toggle
            .option("background", {
              off = "light",
              on = "dark",
              name = "Dark Background",
            })
            :map("yob")

        Snacks.toggle.indent():map("yoI")
        Snacks.toggle.line_number():map("yon")
        Snacks.toggle.dim():map("yoD")

        Snacks.toggle
            .option("background", {
              off = "light",
              on = "dark",
              name = "Dark Background",
            })
            :map("yob")
        Snacks.toggle
            .option("conceallevel", {
              off = 0,
              on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2,
            })
            :map("yo_")

        Snacks.toggle.option("cursorcolumn", { name = "Cursorcolumn" }):map("you")
        Snacks.toggle.option("cursorline", { name = "Cursorline" }):map("yoc")
        Snacks.toggle.option("hlsearch", { name = "Hlsearch" }):map("yoh")
        Snacks.toggle.option("ignorecase", { name = "Ignorecase" }):map("yoi")
        Snacks.toggle.option("list", { name = "Invisible characters" }):map("yol")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("yor")
        Snacks.toggle.option("spell", { name = "Spelling" }):map("yos")
        Snacks.toggle.option("virtualedit", { name = "Virtualedit" }):map("yov")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("yow")

        Snacks.toggle({
          name = "Auto Format",
          get = function() return not vim.b.disable_autoformat end,
          set = function(state) vim.b.disable_autoformat = not state end,
        }):map("yof")

        Snacks.toggle({
          name = "Markdown view",
          get = function()
            local state = require("markview.state")
            local attached = state.get_attached_buffers()
            if #attached == 0 then
              return state.get_buffer_state(-1, true).enable
            else
              return state.get_buffer_state(attached[1], false).enable
            end
          end,
          set = function(state)
            local markview = require("markview")
            if state then
              markview.commands.Enable()
            else
              markview.commands.Disable()
            end
          end,
        }):map("yom")

        Snacks.toggle({
          name = "QuickFix List",
          get = function()
            for _, win in pairs(vim.fn.getwininfo()) do
              if win["quickfix"] == 1 then
                return true
              end
            end
            return false
          end,
          set = function(open)
            if open then
              vim.cmd("copen")
              vim.api.nvim_feedkeys([['"]], "im", false)
            else
              vim.cmd("cclose")
            end
          end,
        }):map("yoq")

        vim.api.nvim_create_user_command("Notifications", Snacks.notifier.show_history, {})
      end,
    })
  end,
}

return M
