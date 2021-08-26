local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "danielfalk/smart-open.nvim",
    "kkharji/sqlite.lua",
    "natecraddock/telescope-zf-native.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-smart-history.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "tsakirist/telescope-lazy.nvim",
    -- "aaronhallaert/ts-advanced-git-search.nvim",
    -- "kyazdani42/nvim-web-devicons",
  },
  enabled = false,
}

function M.config()
  local ts = require("telescope.builtin")
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local action_layout = require("telescope.actions.layout")
  local utils = require("telescope.utils")
  local theme = require("telescope.themes").get_ivy({ winblend = 10 })

  actions.git_reset_file = function(prompt_bufnr)
    local cwd = action_state.get_current_picker(prompt_bufnr).cwd
    local selection = action_state.get_selected_entry()
    if selection == nil then
      utils.__warn_no_selection("actions.git_reset_file")
      return
    end

    utils.get_os_command_output({ "git", "checkout", selection.value }, cwd)
    ts.git_status(theme)
  end

  -- TODO: this doesn't work
  local function custom_file_finder(path, string, description)
    ts.find_files({
      cwd = path,
      prompt_title = description,
      shorten_path = true,
      search_dirs = { path },
      search_file = string,
    })
  end

  telescope.setup({
    defaults = {
      history = {
        path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
        limit = 100,
      },
      mappings = {
        i = {
          -- ["/"] = "which_key",
          ["<esc>"] = actions.close,
          -- ["<CR>"] = custom_actions.multi_selection_open,
          ["<CR>"] = function(pb)
            local picker = action_state.get_current_picker(pb)
            local multi = picker:get_multi_selection()
            actions.select_default(pb)
            for _, j in pairs(multi) do
              if j.path ~= nil then
                vim.cmd(string.format("%s %s", "edit", j.path))
              end
            end
          end,
          ["<C-u>"] = false,
          ["<C-a>"] = actions.select_all,
          -- [";"] = action_layout.toggle_preview,
          ["<F6>"] = actions.cycle_history_next,
          ["<C-o>"] = actions.cycle_history_prev,
          ["%"] = function(prompt_bufnr)
            local selection = require("telescope.actions.state").get_selected_entry()
            local dir = vim.fn.fnamemodify(selection.path, ":p:h")
            require("telescope.actions").close(prompt_bufnr)
            vim.cmd(string.format("silent lcd %s", dir))
          end,
        },
      },
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--trim",
      },
    },
    pickers = {
      colorscheme = {
        enable_preview = true,
      },
      live_grep = {
        enable_preview = true,
      },
      git_status = {
        mappings = {
          i = {
            ["<c-;>"] = actions.git_reset_file,
            ["<TAB>"] = actions.toggle_selection + actions.move_selection_next,
            ["<S-TAB>"] = actions.toggle_selection + actions.move_selection_previous,
          },
        },
      },
      find_files = {
        mappings = {},
      },
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({
          -- even more opts
        }),

        -- pseudo code / specification for writing custom displays, like the one
        -- for "codeactions"
        -- specific_opts = {
        --   [kind] = {
        --     make_indexed = function(items) -> indexed_items, width,
        --     make_displayer = function(widths) -> displayer
        --     make_display = function(displayer) -> function(e)
        --     make_ordinal = function(e) -> string
        --   },
        --   -- for example to disable the custom builtin "codeactions" display
        --      do the following
        --   codeactions = false,
        -- }
      },
      ["zf-native"] = {
        file = {
          enable = true,
          highlight_results = true,
          match_filename = true,
        },

        generic = {
          enable = true,
          highlight_results = true,
          match_filename = false,
        },
      },
    },
  })

  telescope.load_extension("zf-native")
  telescope.load_extension("smart_open")
  telescope.load_extension("ui-select")
  telescope.load_extension("smart_history")

  -- telescope.load_extension("advanced_git_search")

  -- M.project_files = function()
  --   vim.fn.system("git rev-parse --is-inside-work-tree")
  --   if vim.v.shell_error == 0 then
  --     ts.git_files(theme)
  --   else
  --     ts.find_files(theme)
  --   end
  -- end

  -- s_nmap("<cr>",     ts.buffers)
  -- s_nmap("<space>2", edit_specs)
  -- s_nmap("<space>l", ts.grep_curbuf)
  -- s_nmap("<space>m", edit_models)
  -- s_nmap("<space>s",    edit_snippets,            {}, "edit snippets")

  s_nmap("<c-p>", function()
    telescope.extensions.smart_open.smart_open(theme)
  end)
  s_nmap("<C-S-P>", function()
    ts.find_files(theme)
  end)
  s_nmap("<M-k>", function()
    ts.buffers(theme)
  end)

  s_nmap("<space>t", function()
    custom_file_finder("$HOME/code/work/cli", "_test.go", "test files")
  end, "all CLI test files")
  s_nmap("<space>G", function()
    custom_file_finder("$HOME/code/work/cli", ".go", "cli go files")
  end, "all CLI go files")
  s_nmap("<space>C", function()
    ts.git_bcommits(theme)
  end, "git commits for this buffer")
  s_nmap("<space>F", function()
    ts.filetypes(theme)
  end, "change vim filetype")
  s_nmap("<space>R", function()
    ts.command_history(theme)
  end, "vim command history")
  s_nmap("<space>S", function()
    ts.colorscheme(theme)
  end, "list colorschemes")
  s_nmap("<space>c", function()
    ts.git_commits(theme)
  end, "git commits for this project")
  s_nmap("<space>g", function()
    ts.git_status(theme)
  end, "git status")
  s_nmap("<space>h", function()
    ts.help_tags(theme)
  end, "vim helptags")
  s_nmap("<space>r", function()
    ts.oldfiles(theme)
  end, "list old files")
  s_nmap("<space>v", function()
    ts.vim_options(theme)
  end, "list vim options")
  s_nmap("<space>T", function()
    ts.treesitter(theme)
  end, "treesitter variables")
  s_nmap("<space>y", vim.cmd.YankyRingHistory, "yank history")

  s_nmap("z=", ts.spell_suggest, "spelling suggestions")

  -- s_nmap("<m-f>", function()
  --   ts.live_grep(theme)
  -- end)
end

return M
