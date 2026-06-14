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

  fzflua.setup({
    fzf_colors = true,

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

    lsp = { jump1 = true },

    helptags = {
      actions = {
        ["enter"] = actions.help_tab,
      },
    },

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
      stat_file = true,
    },

    grep = {
      multiprocess = true,
      multiline = 2,
      header_prefix = "" .. ' ',
      rg_glob_fn = function(query, opts)
        local regex, flags = query:match(string.format('^(.*)%s(.*)$', opts.glob_separator))
        -- Return the original query if there's no separator.
        return (regex or query), flags
      end,
    },
  })

  s_nmap("<c-p>", fzflua.files)
  s_nmap("<m-k>", fzflua.buffers)
  s_nmap("<c-s-k>", fzflua.tabs)
  s_nmap("<m-f>", function() fzflua.live_grep({}) end)

  s_nmap("<space>C", fzflua.git_bcommits, "git commits for this buffer")
  s_nmap("<space>F", fzflua.filetypes, "change vim filetype")
  s_nmap("<space>R", fzflua.command_history, "vim command history")
  s_nmap("<space>S", fzflua.colorschemes, "list colorschemes")
  s_nmap("<space>c", fzflua.git_commits, "git commits for this project")

  if not Nv12() then
    s_nmap("<space>u", fzflua.undotree, "undo tree")
  end

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
  s_nmap("<space>o", function() fzflua.files({ cwd = "~/.config/opencode", prompt = "OpenCode ❯ " }) end, {}, "opencode")

  s_nmap(
    "<space>G",
    function() fzflua.live_grep_resume({}) end,
    "list git modified files"
  )

  s_nmap("<space>T", function()
    fzflua.live_grep({
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

  s_nmap("<space>g", fzflua.git_status, "git status")
  s_nmap("<space>s", fzflua.lsp_finder, "LSP finder")
  s_nmap("<space>;", fzflua.resume, "resume last picker")
  s_nmap("<space>h", fzflua.helptags, "help tags")
end

return M
