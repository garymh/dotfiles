local M = {
  "ibhagwan/fzf-lua",
  opts = {},
  dependencies = {
    "rktjmp/lush.nvim",
    "elanmed/fzf-lua-frecency.nvim" },
  enabled = true,
  init = function()
    vim.ui.select = function(items, opts, on_choice)
      local ui_select = require 'fzf-lua.providers.ui_select'

      -- Register the fzf-lua picker the first time we call select.
      if not ui_select.is_registered() then
        ui_select.register(function(ui_opts)
          if ui_opts.kind == 'luasnip' then
            ui_opts.prompt = 'Snippet choice: '
            ui_opts.winopts = {
              relative = 'cursor',
              height = 0.35,
              width = 0.3,
            }
          elseif ui_opts.kind == 'lsp_message' then
            ui_opts.winopts = { height = 0.4, width = 0.4 }
          else
            ui_opts.winopts = { height = 0.6, width = 0.5 }
          end

          return ui_opts
        end)
      end

      -- Don't show the picker if there's nothing to pick.
      if #items > 0 then
        return vim.ui.select(items, opts, on_choice)
      end
    end
  end,
}

function M.config()
  local fzflua = require("fzf-lua")
  local actions = require("fzf-lua.actions")
  local opts = { nowait = true, noremap = true }

  fzflua.setup({
    actions = {
      files = {
        ["enter"] = actions.file_edit,
        ["ctrl-q"] = actions.file_edit_or_qf,
      },
    },

    keymap = {
      builtin = {
        ["?"] = "toggle-preview",
      },
      fzf = {
        ["ctrl-a"] = "toggle-all",
      },
    },

    fzf_opts = {
      ['--info'] = 'default',
      ['--layout'] = 'reverse-list',
    },

    winopts = {
      height = 0.99,
      width = 0.85,
    },

    defaults = { git_icons = false },

    previewers = {
      codeaction = { toggle_behavior = 'extend' },
      builtin = {
        syntax_limit_b = 1024 * 100, -- 100KB
      },
    },

    -- added from https://old.reddit.com/r/neovim/comments/1mg3ygb/fzflua_better_file_picker_sorting_small_solution/
    files = {
      rg_opts = ' --files --hidden --ignore --glob "!.git" --sortr=modified',
      fzf_opts = {
        ["--scheme"] = "path",
        ["--tiebreak"] = "index"
      },
      winopts = {
        preview = { hidden = true },
      },
    },

    oldfiles = {
      include_current_session = true,
    },

    grep = {
      header_prefix = "" .. ' ',
      rg_glob_fn = function(query, opts)
        local regex, flags = query:match(string.format('^(.*)%s(.*)$', opts.glob_separator))
        -- Return the original query if there's no separator.
        return (regex or query), flags
      end,
    },
  })

  -- "default-title",
  -- -- defaults = { formatter = 'path.filename_first' },
  -- global_resume = true,
  -- global_resume_query = true,
  -- fzf_opts = {
  --   ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-history",
  -- },
  -- winopts = {
  --   height = 0.7,
  --   width = 1.0,
  --   row = 0.9,
  --   col = 0.0,
  --   on_create = function()
  --     tmap("<m-w>", function() Feedkeys('<c-u>') end, opts)
  --     -- tmap(";", "<CR>", opts)
  --
  --     -- vim.api.nvim_buf_set_keymap(0, "t", ";", "<CR>", opts)
  --   end,
  -- },
  -- buffers = {
  -- },
  -- grep = {
  --   fzf_opts = {
  --     ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-history",
  --   },
  -- },
  -- actions = {
  --   files = {
  --     ["enter"] = actions.file_edit,
  --     ["ctrl-q"] = actions.file_edit_or_qf,
  --   },
  -- },
  -- files = {
  --   git_icons = false,
  -- },
  -- keymap = {
  --   builtin = {
  --     ["?"] = "toggle-preview",
  --   },
  --   fzf = {
  --     ["ctrl-a"] = "toggle-all",
  --   },
  -- },

  local function patternFind(title, path, pattern, badPattern)
    local start = '":!:'

    if badPattern then
      badPattern = " " .. start .. badPattern .. '"'
    else
      badPattern = ""
    end

    fzflua.git_files({
      prompt = title .. " ❯ ",
      cmd = 'git ls-files "' .. path .. "\" '" .. pattern .. "'" .. badPattern,
      cwd = path,
    })
  end

  local function pattern(title, path, pattern, badPattern)
    patternFind(title, os.getenv("GITLAB_HOME") .. "/" .. path, pattern, badPattern)
  end

  s_nmap("<c-p>", fzflua.files)
  s_nmap("<m-k>", fzflua.buffers)
  s_nmap("<c-s-k>", fzflua.tabs)
  -- s_nmap("<leader>fb",
  --   function()
  --     require('fzf-lua').lgrep_curbuf {
  --       winopts = {
  --         height = 0.6,
  --         width = 0.5,
  --         preview = { vertical = 'up:70%' },
  --       },
  --     }
  --   end, "search buffer"
  -- )
  s_nmap("<space>C", fzflua.git_bcommits, "git commits for this buffer")
  s_nmap("<space>F", fzflua.filetypes, "change vim filetype")
  s_nmap("<space>R", fzflua.command_history, "vim command history")
  s_nmap("<space>S", fzflua.colorschemes, "list colorschemes")
  s_nmap("<space>c", fzflua.git_commits, "git commits for this project")

  if not Nv12() then
    s_nmap("<space>u", fzflua.undotree, "undo tree")
  end

  -- s_nmap("<space>f", fzflua.builtin, "FZF builtings")
  -- s_nmap("<space>h", fzflua.help_tags, "vim helptags")

  s_nmap("<space>f",
    function()
      require('fzf-lua-frecency').frecency({
        cwd_only = true,
        -- file_icons  = false,
        -- color_icons = false,
      })
    end, "list by frecency")

  s_nmap("<space>r", fzflua.oldfiles, "list old files")

  s_nmap("<space>y", vim.cmd.YankyRingHistory, "yank history")

  s_nmap("<space>d", function() fzflua.files({ cwd = "~/code/dotfiles", prompt = "Dotfiles ❯ " }) end, {}, "dotfiles")

  local CLI_dir = "~/code/work/cli/"

  s_nmap("<space>ect", function() patternFind("CLI Go Test files", CLI_dir, "*_test.go") end, "edit CLI test files")
  s_nmap("<space>ecm", function() patternFind("CLI Go files", CLI_dir, "*.go", "*_test.go") end, "edit CLI files")

  s_nmap("<space>em", function() pattern("Rails models", "app/models/", "*.rb") end, "edit GitLab models")
  s_nmap("<space>eem", function() pattern("Rails EE models", "ee/app/models/ee/", "*.rb") end, "edit GitLab EE models")
  s_nmap("<space>es", function() pattern("Rails services", "app/services/", "*.rb") end, "edit GitLab services")
  s_nmap(
    "<space>ees",
    function() pattern("Rails EE services", "ee/app/services/ee/", "*.rb") end,
    "edit GitLab EE services"
  )
  s_nmap("<space>ew", function() pattern("Rails workers", "app/workers/", "*.rb") end, "edit GitLab workers")
  s_nmap(
    "<space>eew",
    function() pattern("Rails EE workers", "ee/app/workers/ee/", "*.rb") end,
    "edit GitLab EE workers"
  )
  s_nmap("<space>etm", function() pattern("Rails model specs", "spec/models/", "*.rb") end, "edit GitLab model specs")
  s_nmap(
    "<space>etem",
    function() pattern("Rails EE model specs", "ee/spec/models/ee/", "*.rb") end,
    "edit GitLab EE model specs"
  )
  s_nmap(
    "<space>ets",
    function() pattern("Rails service specs", "spec/services/", "*.rb") end,
    "edit GitLab service specs"
  )
  s_nmap(
    "<space>etes",
    function() pattern("Rails EE service specs", "ee/spec/services/ee/", "*.rb") end,
    "edit GitLab EE service specs"
  )
  s_nmap(
    "<space>etw",
    function() pattern("Rails worker specs", "spec/workers/", "*.rb") end,
    "edit GitLab worker specs"
  )
  s_nmap(
    "<space>etew",
    function() pattern("Rails EE worker specs", "ee/spec/workers/ee/", "*.rb") end,
    "edit GitLab EE worker specs"
  )

  s_nmap(
    "<space>G",
    function() require("fzf-lua").live_grep_resume({ multiline = 2, multiprocess = true }) end,
    "list git modified files"
  )
  s_nmap("<m-f>", function() require("fzf-lua").live_grep({ multiline = 2, multiprocess = true }) end)
  -- s_nmap("gs", "<CMD>FzfLua grep_cword<CR>", "Grep word")
  -- s_nmap("gS", "<CMD>FzfLua grep_cWORD<CR>", "Grep WORD")
  -- s_nmap("<space><space>", function() require("fzf-lua").lsp_document_symbols() end, "see document symbols")


  s_nmap("<space>T", function()
    require("fzf-lua").live_grep({
      cmd = "git grep --ignore-case --extended-regexp --line-number --column --color=always --untracked",
      fn_transform_cmd = function(query, cmd, _)
        -- Extract search query and glob string separated by '--'
        local search_query, glob_str = query:match("(.-)%s-%-%-(.*)")

        if not glob_str then
          return -- Fallback to original command if no glob string
        end

        -- Convert glob string into git-compatible pathspecs
        local pathspecs = {}
        for pattern in glob_str:gmatch("%S+") do
          if pattern:sub(1, 1) == "!" then
            -- Convert '!pattern' to git's exclude pathspec
            table.insert(pathspecs, string.format("':(exclude)%s'", pattern:sub(2)))
          else
            table.insert(pathspecs, string.format("'%s'", pattern))
          end
        end

        -- Compose the final git grep command
        local new_cmd = string.format("%s %s %s", cmd, vim.fn.shellescape(search_query), table.concat(pathspecs, " "))
        return new_cmd, search_query
      end
    })
  end, "see document symbols")

  -- s_nmap("g<space>", function() require 'fzf-lua'.lsp_document_symbols() end)
  -- s_nmap("<F55>", "<Plug>(esearch)")
  -- s_nmap("<space>G", function() fzflua.live_grep({  multiline = 2 }) end, {}, "live grep")
  -- s_nmap("<localleader>e", "<CMD>lua vim.diagnostic.open_float()<CR>", "[LSP] line diagnostics")
  -- s_nmap("<localleader>ca", "<CMD>Lspsaga code_action<CR>", "[LSP] code actions")
  -- s_vmap("<localleader>ca", "<CMD>Lspsaga code_action<CR>", "[LSP] code actions")
  -- s_nmap("gR", "<CMD>Lspsaga rename ++project<CR>", "[LSP] rename for project")
  -- s_nmap("<space><space>", "<cmd>Lspsaga outline<CR>", "[LSP] outline")

  s_nmap("<space>g", fzflua.git_status, "git status")
  s_nmap("<space>s", fzflua.lsp_references, "references")

  -- s_nmap("<space>s", fzflua.lsp_document_symbols, {}, "document symbols")
  -- s_nmap("<space>A", fzflua.lsp_code_actions, {}, "code actions")
  -- s_nmap("<space>s", edit_snippets, {}, "edit snippets")

  -- We can use our new function on any folder or
  -- with any other fzf-lua options ('winopts', etc)
  -- _G.live_grep({ cwd = "<my folder>" })
  -- s_nmap("<space>f", _G.live_grep({  }))

  -- map_fzf('n', '<leader>fh', "oldfiles", { cwd = "~" })
  -- map_fzf('n', '<leader>fH', "oldfiles", function()
  --   return {
  --     cwd = vim.loop.cwd(),
  --     show_cwd_header = true,
  --     cwd_only = true,
  --   }
  -- end)
end

return M
