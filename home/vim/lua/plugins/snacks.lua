-- local indentChar = "▎"
local indentChar = "┊"

local function filePicker(desc, dir, pattern, exclude)
  Snacks.picker.files({
    cwd = dir,
    title = string.format("%s", desc),
    args = { "-g", pattern },
    exclude = { exclude },
  })
end

local M = {
  "folke/snacks.nvim",
  priority = 1000,
  enabled = true,
  lazy = false,
  opts = {
    -- animate      = {
    --   enabled = false,
    -- },

    animate      = {
      enabled = true,    -- ensure animations are active
      duration = 20,     -- duration per step in ms
      easing = "linear", -- easing function (default is "linear")
      fps = 60,          -- global frames per second for all animations
    },

    bigfile      = {},
    bufdelete    = {},
    debug        = {},

    -- dim          = {
    --   animate = {
    --     enabled = true,
    --     duration = {
    --       total = 0,
    --     },
    --   },
    --   scope = {
    --     min_size = 10,
    --     max_size = 30,
    --     siblings = true,
    --   },
    -- },
    dim          = {
      enabled = true,
      scope = {
        min_size = 5,
        max_size = 20,
        siblings = true,
      },
      animate = {
        enabled = Nv10,
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

    -- indent       = {
    --   enabled = true,
    --   char = indentChar,
    -- },

    indent       = {
      animate = {
        enabled = false,
      },
      indent = {
        enabled = false, -- Turn off standard indent lines
      },
      scope = {
        enabled = true, -- Turn on scope lines
        priority = 200,
        char = indentChar,
        underline = false,
        only_current = true, -- Only show scope lines for the scope under cursor
        hl = "SnacksIndentScope",
      },
    },
    --   indent = {
    --     char = indentChar,
    --     only_current = true,
    --     only_scope = true,
    --   },
    --   scope = {
    --     char = indentChar,
    --     underline = true,
    --     only_current = true,
    --     hl = "LineNr",
    --   },
    --   chunk = {
    --     enabled = true,
    --     hl = "WarningMsg",
    --     char = {
    --       arrow = "─",
    --     },
    --   },
    -- },

    input        = {},
    git          = {},
    gitbrowse    = {},
    lazygit      = {},
    quickfile    = {},
    scope        = {},

    picker       = {
      icons = {
        files = {
          enabled = false
        },
      },

      layout = {
        cycle = true,
        --- Use the default layout or vertical if the window is too narrow
        preset = function()
          return vim.o.columns >= 120 and "default" or "ivy"
        end,
      },

      formatters = {
        file = {
          filename_first = true, -- display filename before the file path
        },
        selected = {
          show_always = true, -- only show the selected column when there are multiple selections
          unselected = true,  -- use the unselected icon for unselected items
        },
      },

      win = {
        input = {
          keys = {
            ["<Esc>"]  = { "close", mode = { "n", "i" } },
            ["<c-/>"]  = { "toggle_preview", mode = { "i", "n" } },
            ["<m-BS>"] = { "<c-s-w>", mode = { "i" }, expr = true, desc = "delete word" },
            ["<c-u>"]  = { "delete_line", mode = { "i" }, desc = "delete word" },
          },
        },
      },

      actions = {
        delete_line = function() vim.cmd.normal('c0') end,
      },

      debug = {
        scores = false, -- show scores in the list
      },
    },

    statuscolumn = {
      -- folds = {
      --   open = false,   -- show open fold icons
      --   git_hl = false, -- use Git Signs hl for fold icons
      -- },
      enabled = false,
      left = { "mark", "sign" },
      right = { "fold", "git" },
      folds = {
        open = false,
        git_hl = false,
      },
      git = {
        patterns = { "GitSign", "MiniDiffSign" },
      },
      refresh = 50,
    },


    terminal = {},
    toggle   = {},
    win      = {},
    words    = {},
    styles   = {
      notification = {
        wo = {
          wrap = true,
        }, -- Wrap notifications
      },
    },
    zen      = {},
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
    {
      "<m-k>",
      function()
        Snacks.picker.buffers({
          on_show = function() vim.cmd.stopinsert() end,
          finder = "buffers",
          format = "buffer",
          hidden = false,
          unloaded = true,
          current = true,
          sort_lastused = true,
          win = {
            input = {
              keys = {
                ["d"] = "bufdelete",
              },
            },
            list = { keys = { ["d"] = "bufdelete" } },
          },
        })
      end,
      desc = "Buffers"
    },
    -- { "<c-p>",    function() Snacks.picker.smart() end,           desc = "Smart Find" },
    -- { "<D-s-f>",  function() Snacks.picker.search_history() end,  desc = "Grep History" },
    -- { "<m-f>",    function() Snacks.picker.grep() end,            desc = "Grep" },
    -- { "<m-F>",    function() Snacks.picker.search_history() end,  desc = "Grep History" },
    -- { "<space>r", function() Snacks.picker.recent() end,          desc = "Recent" },
    -- { "<space>U", function() Snacks.picker.undo() end,            desc = "Undo" },
    -- { "<space>h", function() Snacks.picker.help() end,            desc = "Help files" },
    -- { "<space>L", function() Snacks.picker.git_log() end,         desc = "Git Log" },
    -- { "<space>a", function() Snacks.picker.explorer() end,        desc = "Dotfiles" },
    -- { "<space>R", function() Snacks.picker.command_history() end, desc = "Command History" },

    { "<space>y", function() Snacks.picker.yanky() end,   desc = "Paste picker" },

    {
      "<space>h",
      function()
        Snacks.picker.help(
          {
            confirm = function(picker, item)
              picker:norm(function()
                if item then
                  dd(item.tag)
                  picker:close()
                  vim.cmd("tab h " .. item.tag)
                end
              end)
            end,
          }
        )
      end,
      desc = "Help files"
    },
    -- {
    --   "<space>g",
    --   function()
    --     Snacks.picker.git_status({
    --       win = {
    --         input = {
    --           keys = {
    --             ["<Tab>"] = { "select_and_next", mode = { "i", "n" } },
    --           },
    --         },
    --       },
    --     }
    --     )
    --   end,
    --   desc = "Git Status"
    -- },
    --
    -- { "<space>d",       function() filePicker("Dotfiles", D, "*") end,                                         desc = "Dotfiles" },
    -- { "<space>t",       function() filePicker("CLI Go Test files", os.getenv("CLI_HOME"), "*_test.go") end,    desc = "edit CLI test files" },
    -- { "<space>m",       function() filePicker("CLI Go files", os.getenv("CLI_HOME"), "*.go", "*_test.go") end, desc = "edit CLI files" },
    -- { "<space>em",      function() filePicker("Rails models", "app/models/", "*.rb") end,                      desc = "edit GitLab models" },
    -- { "<space>eem",     function() filePicker("Rails EE models", "ee/app/models/ee/", "*.rb") end,             desc = "edit GitLab EE models" },
    -- { "<space>es",      function() filePicker("Rails services", "app/services/", "*.rb") end,                  desc = "edit GitLab services" },
    -- { "<space>ees",     function() filePicker("Rails EE services", "ee/app/services/ee/", "*.rb") end,         desc = "edit GitLab EE services" },
    -- { "<space>ew",      function() filePicker("Rails workers", "app/workers/", "*.rb") end,                    desc = "edit GitLab workers" },
    -- { "<space>eew",     function() filePicker("Rails EE workers", "ee/app/workers/ee/", "*.rb") end,           desc = "edit GitLab EE workers" },
    -- { "<space>etm",     function() filePicker("Rails model specs", "spec/models/", "*.rb") end,                desc = "edit GitLab model specs" },
    -- { "<space>etem",    function() filePicker("Rails EE model specs", "ee/spec/models/ee/", "*.rb") end,       desc = "edit GitLab EE model specs" },
    -- { "<space>ets",     function() filePicker("Rails service specs", "spec/services/", "*.rb") end,            desc = "edit GitLab service specs" },
    -- { "<space>etes",    function() filePicker("Rails EE service specs", "ee/spec/services/ee/", "*.rb") end,   desc = "edit GitLab EE service specs" },
    -- { "<space>etw",     function() filePicker("Rails worker specs", "spec/workers/", "*.rb") end,              desc = "edit GitLab worker specs" },
    -- { "<space>etew",    function() filePicker("Rails EE worker specs", "ee/spec/workers/ee/", "*.rb") end,     desc = "edit GitLab EE worker specs" },
    --
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

    { "glb",      function() Snacks.git.blame_line() end, desc = "Git blame" },
    { "glw",      function() Snacks.gitbrowse() end,      desc = "browse on GitLab" },

    {
      "glw",
      function()
        Snacks.gitbrowse()
      end,
      desc = "browse on GitLab",
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
          name = "Precognition",
          get = function() return require("precognition").is_visible end,
          set = function() require("precognition").toggle() end,
        }):map("yop")

        Snacks.toggle({
          name = "Precognition",
          get = function() return require("precognition").is_visible end,
          set = function() require("precognition").toggle() end,
        }):map("yop")

        Snacks.toggle({
          name = "Auto Format",
          get = function() return not vim.b.disable_autoformat end,
          set = function(state) vim.b.disable_autoformat = not state end,
        }):map("yof")

        Snacks.toggle({
          name = "Reader mode",
          get = function() return require("markview").state.enable end,
          set = function() vim.cmd.Markview() end,
        }):map("yom")

        vim.api.nvim_create_user_command("Notifications", Snacks.notifier.show_history, {})
      end,
    })
  end,
}

return M
