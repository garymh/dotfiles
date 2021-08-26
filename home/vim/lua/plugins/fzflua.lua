local M = {
  "ibhagwan/fzf-lua",
  dependencies = {
    "kyazdani42/nvim-web-devicons",
  },
  enabled = true,
}

function M.config()
  local fzflua = require("fzf-lua")
  local actions = require("fzf-lua.actions")

  fzflua.setup({
    global_resume = true,
    global_resume_query = true,
    winopts = {
      -- split = "belowright new",
      height = 0.7,
      width = 1.0,
      row = 0.9,
      col = 0.0,
      border = "thicc",
      fullscreen = false,
      preview = {
        border = "border",
        wrap = "nowrap",
        hidden = "nohidden",
        vertical = "down:45%",
        horizontal = "right:50%",
        layout = "flex",
        flip_columns = 80,
        title = false,
        scrollbar = "float",
        scrolloff = "-2",
        scrollchars = { "█", "" },
        delay = 100,
        winopts = {
          number = true,
          relativenumber = false,
          cursorline = true,
          cursorlineopt = "both",
          cursorcolumn = false,
          signcolumn = "no",
          list = false,
          foldenable = false,
          foldmethod = "manual",
        },
      },
      on_create = function()
        vim.api.nvim_buf_set_keymap(
          0,
          "t",
          "<m-w>",
          "<cmd>lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<c-u>', true, false, true), 'n', true)<cr>",
          { nowait = true, noremap = true }
        )
        vim.api.nvim_buf_set_keymap(0, "t", ";", "<CR>", { nowait = true, noremap = true })
      end,
    },
    keymap = {
      builtin = {
        ["<F1>"] = "toggle-help",
        ["<F2>"] = "toggle-fullscreen",
        ["?"] = "toggle-preview",
        ["<F5>"] = "toggle-preview-ccw",
        ["<F6>"] = "toggle-preview-cw",
        ["<S-down>"] = "preview-page-down",
        ["<S-up>"] = "preview-page-up",
        ["<S-left>"] = "preview-page-reset",
      },
      fzf = {
        ["ctrl-z"] = "abort",
        ["ctrl-u"] = "unix-line-discard",
        ["ctrl-f"] = "half-page-down",
        ["ctrl-b"] = "half-page-up",
        ["ctrl-a"] = "toggle-all",
        ["ctrl-e"] = "end-of-line",
        ["alt-a"] = "toggle-all",
        ["f3"] = "toggle-preview-wrap",
        ["f4"] = "toggle-preview",
        ["shift-down"] = "preview-page-down",
        ["shift-up"] = "preview-page-up",
      },
    },
    actions = {
      files = {
        ["default"] = actions.file_edit,
        ["ctrl-s"] = actions.file_split,
        ["ctrl-v"] = actions.file_vsplit,
        ["ctrl-t"] = actions.file_tabedit,
        ["alt-q"] = actions.file_sel_to_qf,
        ["ctrl-y"] = function(selected)
          print(selected[2])
        end,
      },
      buffers = {
        ["default"] = actions.buf_edit,
        ["ctrl-s"] = actions.buf_split,
        ["ctrl-v"] = actions.buf_vsplit,
        ["ctrl-t"] = actions.buf_tabedit,
      },
    },
    fzf_opts = {
      ["--ansi"] = "",
      ["--info"] = "inline",
      ["--height"] = "100%",
      ["--layout"] = "reverse",
      ["--border"] = "none",
    },
    previewers = {
      cat = {
        cmd = "cat",
        args = "--number",
      },
      bat = {
        cmd = "bat",
        args = "--style=numbers,changes --color always",
        theme = "1337",
        config = nil,
      },
      head = {
        cmd = "head",
        args = nil,
      },
      git_diff = {
        cmd_deleted = "git diff --color HEAD --",
        cmd_modified = "git diff --color HEAD",
        cmd_untracked = "git diff --color --no-index /dev/null",
        pager = "delta --width=$FZF_PREVIEW_COLUMNS",
      },
      man = {
        cmd = "man -c %s | col -bx",
      },
      builtin = {
        syntax = true,
        syntax_limit_l = 0,
        syntax_limit_b = 1024 * 1024,
        limit_b = 1024 * 1024 * 10,
        extensions = {
          ["png"] = { "viu", "-b" },
          ["jpg"] = { "ueberzug" },
        },
        ueberzug_scaler = "cover",
      },
    },
    files = {
      prompt = "Files ❯ ",
      multiprocess = true,
      git_icons = true,
      file_icons = false,
      color_icons = true,
      find_opts = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
      rg_opts = "--color=never --files --hidden --follow -g '!.git'",
      fd_opts = "--color=never --type f --hidden --follow --exclude .git",
      actions = {
        ["default"] = actions.file_edit,
        ["ctrl-y"] = function(selected)
          print(selected[1])
        end,
      },
    },
    git = {
      files = {
        prompt = "GitFiles ❯ ",
        cmd = "git ls-files --exclude-standard",
        multiprocess = true,
        git_icons = false,
        file_icons = false,
        color_icons = false,
        show_cwd_header = true,
      },
      status = {
        prompt = "GitStatus ❯ ",
        cmd = "git status -su",
        file_icons = true,
        git_icons = true,
        color_icons = true,
        previewer = "git_diff",
        preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
        actions = {
          ["right"] = { actions.git_unstage, actions.resume },
          ["left"] = { actions.git_stage, actions.resume },
        },
      },
      commits = {
        prompt = "Commits ❯ ",
        cmd =
        "git log --color --pretty=format:'%C(yellow)%h%Creset %Cgreen(%><(12)%cr%><|(12))%Creset %s %C(blue)<%an>%Creset'",
        preview = "git show --pretty='%Cred%H%n%Cblue%an <%ae>%n%C(yellow)%cD%n%Cgreen%s' --color {1}",
        preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
        actions = {
          ["default"] = actions.git_checkout,
        },
      },
      bcommits = {
        prompt = "BCommits ❯ ",
        cmd =
        "git log --color --pretty=format:'%C(yellow)%h%Creset %Cgreen(%><(12)%cr%><|(12))%Creset %s %C(blue)<%an>%Creset' <file>",
        preview = "git diff --color {1}~1 {1} -- <file>",
        preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
        actions = {
          ["default"] = actions.git_buf_edit,
          ["ctrl-s"] = actions.git_buf_split,
          ["ctrl-v"] = actions.git_buf_vsplit,
          ["ctrl-t"] = actions.git_buf_tabedit,
        },
      },
      branches = {
        prompt = "Branches ❯ ",
        cmd = "git branch --all --color",
        preview = "git log --graph --pretty=oneline --abbrev-commit --color {1}",
        actions = {
          ["default"] = actions.git_switch,
        },
      },
      stash = {
        prompt = "Stash> ",
        cmd = "git --no-pager stash list",
        preview = "git --no-pager stash show --patch --color {1}",
        actions = {
          ["default"] = actions.git_stash_apply,
          ["ctrl-x"] = { actions.git_stash_drop, actions.resume },
        },
        fzf_opts = {
          ["--no-multi"] = "",
          ["--delimiter"] = "'[:]'",
        },
      },
      icons = {
        ["R"] = { icon = "R", color = "yellow" },
        ["C"] = { icon = "C", color = "yellow" },
        ["T"] = { icon = "T", color = "magenta" },
        ["?"] = { icon = "?", color = "magenta" },
        ["M"] = { icon = "★", color = "red" },
        ["D"] = { icon = "✗", color = "red" },
        ["A"] = { icon = "+", color = "green" },
      },
    },
    grep = {
      prompt = "Rg ❯ ",
      input_prompt = "Grep For ❯ ",
      multiprocess = true, -- run command in a separate process
      git_icons = true,    -- show git icons?
      file_icons = true,   -- show file icons?
      color_icons = true,  -- colorize file|git icons
      -- executed command priority is 'cmd' (if exists)
      -- otherwise auto-detect prioritizes `rg` over `grep`
      -- default options are controlled by 'rg|grep_opts'
      -- cmd            = "rg --vimgrep",
      grep_opts = "--binary-files=without-match --line-number --recursive --color=auto --perl-regexp",
      rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=512",
      -- set to 'true' to always parse globs in both 'grep' and 'live_grep'
      -- search strings will be split using the 'glob_separator' and translated
      -- to '--iglob=' arguments, requires 'rg'
      -- can still be used when 'false' by calling 'live_grep_glob' directly
      rg_glob = true,            -- default to glob parsing?
      glob_flag = "--iglob",     -- for case sensitive globs use '--glob'
      glob_separator = "%s%-%-", -- query separator pattern (lua): ' --'
      -- advanced usage: for custom argument parsing define
      -- 'rg_glob_fn' to return a pair:
      --   first returned argument is the new search query
      --   second returned argument are addtional rg flags
      -- rg_glob_fn = function(query, opts)
      --   ...
      --   return new_query, flags
      -- end,
      actions = {
        -- actions inherit from 'actions.files' and merge
        -- this action toggles between 'grep' and 'live_grep'
        ["ctrl-g"] = { actions.grep_lgrep },
      },
      no_header = false,   -- hide grep|cwd header?
      no_header_i = false, -- hide interactive header?
    },
    args = {
      prompt = "Args ❯ ",
      files_only = true,
      -- actions inherit from 'actions.files' and merge
      actions = { ["ctrl-x"] = { actions.arg_del, actions.resume } },
    },
    oldfiles = {
      prompt = "History ❯ ",
      cwd_only = false,
      stat_file = true,               -- verify files exist on disk
      include_current_session = true, -- include bufs from current session
    },
    buffers = {
      prompt = "Buffers ❯ ",
      file_icons = true,    -- show file icons?
      color_icons = true,   -- colorize file|git icons
      sort_lastused = true, -- sort buffers() by last used
      preview_opts = "nowrap:hidden",
      preview_wrap = "hidden:down:0",
      actions = {
        ["ctrl-x"] = { actions.buf_del, actions.resume },
      },
    },
    tabs = {
      prompt = "Tabs ❯ ",
      tab_title = "Tab",
      tab_marker = "<<",
      sort_lastused = true,
      file_icons = false,
      color_icons = false,
      preview_opts = "nowrap:hidden",
      preview_wrap = "hidden:down:0",
      actions = {
        ["default"] = actions.buf_switch,
        ["ctrl-x"] = { actions.buf_del, actions.resume },
      },
      fzf_opts = {
        ["--delimiter"] = "'[\\):]'",
        ["--with-nth"] = "2..",
      },
    },
    lines = {
      previewer = "builtin",  -- set to 'false' to disable
      prompt = "Lines ❯ ",
      show_unlisted = false,  -- exclude 'help' buffers
      no_term_buffers = true, -- exclude 'term' buffers
      fzf_opts = {
        -- do not include bufnr in fuzzy matching
        -- tiebreak by line no.
        ["--delimiter"] = "'[\\]:]'",
        ["--nth"] = "2..",
        ["--tiebreak"] = "index",
      },
      -- actions inherit from 'actions.buffers' and merge
      actions = {
        ["default"] = { actions.buf_edit_or_qf },
        ["alt-q"] = { actions.buf_sel_to_qf },
      },
    },
    blines = {
      previewer = "builtin",   -- set to 'false' to disable
      prompt = "BLines ❯ ",
      show_unlisted = true,    -- include 'help' buffers
      no_term_buffers = false, -- include 'term' buffers
      fzf_opts = {
        -- hide filename, tiebreak by line no.
        ["--delimiter"] = "'[\\]:]'",
        ["--with-nth"] = "2..",
        ["--tiebreak"] = "index",
      },
      -- actions inherit from 'actions.buffers' and merge
      actions = {
        ["default"] = { actions.buf_edit_or_qf },
        ["alt-q"] = { actions.buf_sel_to_qf },
      },
    },
    tags = {
      prompt = "Tags ❯ ",
      ctags_file = "tags",
      multiprocess = true,
      file_icons = true,
      git_icons = true,
      color_icons = true,
      -- 'tags_live_grep' options, `rg` prioritizes over `grep`
      rg_opts = "--no-heading --color=always --smart-case",
      grep_opts = "--color=auto --perl-regexp",
      actions = {
        -- actions inherit from 'actions.files' and merge
        -- this action toggles between 'grep' and 'live_grep'
        ["ctrl-g"] = { actions.grep_lgrep },
      },
      no_header = false,   -- hide grep|cwd header?
      no_header_i = false, -- hide interactive header?
    },
    btags = {
      prompt = "BTags ❯ ",
      ctags_file = "tags",
      multiprocess = true,
      file_icons = true,
      git_icons = true,
      color_icons = true,
      rg_opts = "--no-heading --color=always",
      grep_opts = "--color=auto --perl-regexp",
      fzf_opts = {
        ["--delimiter"] = "'[\\]:]'",
        ["--with-nth"] = "2..",
        ["--tiebreak"] = "index",
      },
      -- actions inherit from 'actions.files'
    },
    colorschemes = {
      prompt = "Colorschemes ❯ ",
      live_preview = true, -- apply the colorscheme on preview?
      actions = { ["default"] = actions.colorscheme },
      winopts = { height = 0.55, width = 0.30 },
      post_reset_cb = function()
        -- reset statusline highlights after
        -- a live_preview of the colorscheme
        -- require('feline').reset_highlights()
      end,
    },
    quickfix = {
      file_icons = true,
      git_icons = true,
    },
    lsp = {
      prompt_postfix = " ❯ ", -- will be appended to the LSP label
      -- to override use 'prompt' instead
      cwd_only = false,        -- LSP/diagnostics for cwd only?
      async_or_timeout = 3000, -- timeout(ms) or 'true' for async calls
      file_icons = true,
      git_icons = false,
      ui_select = true, -- use 'vim.ui.select' for code actions
      -- settings for 'lsp_{document|workspace|lsp_live_workspace}_symbols'
      symbols = {
        async_or_timeout = true, -- symbols are async by default
        symbol_style = 1,        -- style for document/workspace symbols
        -- false: disable,    1: icon+kind
        --     2: icon only,  3: kind only
        -- NOTE: icons are extracted from
        -- vim.lsp.protocol.CompletionItemKind
        -- colorize using nvim-cmp's CmpItemKindXXX highlights
        -- can also be set to 'TS' for treesitter highlights ('TSProperty', etc)
        -- or 'false' to disable highlighting
        symbol_hl_prefix = "CmpItemKind",
        -- additional symbol formatting, works with or without style
        symbol_fmt = function(s)
          return "[" .. s .. "]"
        end,
      },
    },
    diagnostics = {
      prompt = "Diagnostics ❯ ",
      cwd_only = false,
      file_icons = true,
      git_icons = false,
      diag_icons = true,
      icon_padding = "", -- add padding for wide diagnostics signs
      -- by default icons and highlights are extracted from 'DiagnosticSignXXX'
      -- and highlighted by a highlight group of the same name (which is usually
      -- set by your colorscheme, for more info see:
      --   :help DiagnosticSignHint'
      --   :help hl-DiagnosticSignHint'
      -- only uncomment below if you wish to override the signs/highlights
      -- define only text, texthl or both (':help sign_define()' for more info)
      -- signs = {
      --   ["Error"] = { text = "", texthl = "DiagnosticError" },
      --   ["Warn"]  = { text = "", texthl = "DiagnosticWarn" },
      --   ["Info"]  = { text = "", texthl = "DiagnosticInfo" },
      --   ["Hint"]  = { text = "", texthl = "DiagnosticHint" },
      -- },
      -- limit to specific severity, use either a string or num:
      --   1 or "hint"
      --   2 or "information"
      --   3 or "warning"
      --   4 or "error"
      -- severity_only:   keep any matching exact severity
      -- severity_limit:  keep any equal or more severe (lower)
      -- severity_bound:  keep any equal or less severe (higher)
    },
    -- uncomment to use the old help previewer which used a
    -- minimized help window to generate the help tag preview
    -- helptags = { previewer = "help_tags" },
    -- uncomment to use `man` command as native fzf previewer
    -- (instead of using a neovim floating window)
    -- manpages = { previewer = "man_native" },
    --
    -- optional override of file extension icon colors
    -- available colors (terminal):
    --    clear, bold, black, red, green, yellow
    --    blue, magenta, cyan, grey, dark_grey, white

    file_icon_colors = {
      ["sh"] = "green",
    },
    -- padding can help kitty term users with
    -- double-width icon rendering
    file_icon_padding = "",
    -- uncomment if your terminal/font does not support unicode character
    -- 'EN SPACE' (U+2002), the below sets it to 'NBSP' (U+00A0) instead
    -- nbsp = '\xc2\xa0',
  })

  local function customDirFinder(title, path, pattern, badPattern)
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

  local function railsCustomDirFinder(title, path, pattern, badPattern)
    customDirFinder(title, os.getenv("GITLAB_HOME") .. "/" .. path, pattern, badPattern)
  end

  -- local function gitFilesPlusOld()
  --   local contents = function(cb)
  --     coroutine.wrap(function()
  --       local co = coroutine.running()
  --
  --       local function on_event(_, data, event)
  --         if event == "stdout" then
  --           for _, file in ipairs(data) do
  --             cb(require("fzf-lua").make_entry.file(file, {}), function()
  --               coroutine.resume(co, 0)
  --             end)
  --           end
  --         elseif event == "stderr" then
  --           vim.cmd("echohl Error")
  --           vim.cmd('echomsg "' .. table.concat(data, "") .. '"')
  --           vim.cmd("echohl None")
  --           coroutine.resume(co, 2)
  --         elseif event == "exit" then
  --           coroutine.resume(co, 1)
  --         end
  --       end
  --
  --       local fd_cmd = "fd --type f --absolute-path  --color=never --hidden --follow --exclude .git"
  --       vim.fn.jobstart(fd_cmd, {
  --         on_stderr = on_event,
  --         on_stdout = on_event,
  --         on_exit = on_event,
  --         -- cwd = cwd,
  --       })
  --
  --       repeat
  --         -- waiting for a call to 'resume'
  --         local ret = coroutine.yield()
  --         print("yielded", ret)
  --       until ret ~= 0
  --
  --       -- process oldfiles
  --
  --       -- only when done procesing we call EOF once
  --       cb(nil)
  --     end)()
  --   end
  --
  --   require("fzf-lua").fzf_exec(contents)
  -- end

  -- local function edit_snippets()
  --   fzflua.files({ cwd = "~/.vsnip", prompt = "Snippets  ❯ " })
  -- end

  -- s_nmap("<cr>",     fzflua.buffers)
  -- s_nmap("<space>2", edit_specs)
  -- s_nmap("<space>l", fzflua.grep_curbuf)
  -- s_nmap("<space>m", edit_models)

  s_nmap("<c-p>", fzflua.files)
  -- s_nmap("<c-s-p>", gitFilesPlusOld)
  s_nmap("<m-k>", fzflua.buffers)
  s_nmap("<c-s-k>", fzflua.tabs)
  s_nmap("<space>C", fzflua.git_bcommits, {}, "git commits for this buffer")
  s_nmap("<space>F", fzflua.filetypes, {}, "change vim filetype")
  s_nmap("<space>R", fzflua.command_history, {}, "vim command history")
  s_nmap("<space>S", fzflua.colorschemes, {}, "list colorschemes")
  s_nmap("<space>c", fzflua.git_commits, {}, "git commits for this project")
  s_nmap("<space>g", fzflua.git_status, {}, "git status")
  s_nmap("<space>h", fzflua.help_tags, {}, "vim helptags")
  s_nmap("<space>d", function()
    fzflua.files({ cwd = "~/code/dotfiles", prompt = "Dotfiles ❯ " })
  end, {}, "dotfiles")
  s_nmap("<space>r", fzflua.oldfiles, {}, "list old files")
  -- s_nmap("<space>s", edit_snippets, {}, "edit snippets")
  s_nmap("<space>y", vim.cmd.YankyRingHistory, {}, "yank history")

  local CLI_dir = "~/code/work/cli/"

  s_nmap("<space>t", function()
    customDirFinder("CLI Go Test files", CLI_dir, "*_test.go")
  end, {}, "edit CLI test files")
  s_nmap("<space>m", function()
    customDirFinder("CLI Go files", CLI_dir, "*.go", "*_test.go")
  end, {}, "edit CLI files")

  s_nmap("<space>em", function()
    railsCustomDirFinder("Rails models", "app/models/", "*.rb")
  end, {}, "edit GitLab models")
  s_nmap("<space>eem", function()
    railsCustomDirFinder("Rails EE models", "ee/app/models/ee/", "*.rb")
  end, {}, "edit GitLab EE models")
  s_nmap("<space>es", function()
    railsCustomDirFinder("Rails services", "app/services/", "*.rb")
  end, {}, "edit GitLab services")
  s_nmap("<space>ees", function()
    railsCustomDirFinder("Rails EE services", "ee/app/services/ee/", "*.rb")
  end, {}, "edit GitLab EE services")
  s_nmap("<space>ew", function()
    railsCustomDirFinder("Rails workers", "app/workers/", "*.rb")
  end, {}, "edit GitLab workers")
  s_nmap("<space>eew", function()
    railsCustomDirFinder("Rails EE workers", "ee/app/workers/ee/", "*.rb")
  end, {}, "edit GitLab EE workers")

  s_nmap("<space>etm", function()
    railsCustomDirFinder("Rails model specs", "spec/models/", "*.rb")
  end, {}, "edit GitLab model specs")
  s_nmap("<space>etem", function()
    railsCustomDirFinder("Rails EE model specs", "ee/spec/models/ee/", "*.rb")
  end, {}, "edit GitLab EE model specs")
  s_nmap("<space>ets", function()
    railsCustomDirFinder("Rails service specs", "spec/services/", "*.rb")
  end, {}, "edit GitLab service specs")
  s_nmap("<space>etes", function()
    railsCustomDirFinder("Rails EE service specs", "ee/spec/services/ee/", "*.rb")
  end, {}, "edit GitLab EE service specs")
  s_nmap("<space>etw", function()
    railsCustomDirFinder("Rails worker specs", "spec/workers/", "*.rb")
  end, {}, "edit GitLab worker specs")
  s_nmap("<space>etew", function()
    railsCustomDirFinder("Rails EE worker specs", "ee/spec/workers/ee/", "*.rb")
  end, {}, "edit GitLab EE worker specs")

-- s_nmap("<F55>", "<Plug>(esearch)")
  -- s_nmap("<m-f>", "<CMD>FzfLua live_grep_resume<CR>")
  -- s_nmap("gs", "<CMD>FzfLua grep_cword<CR>")
  -- s_nmap("gS", "<CMD>FzfLua grep_cWORD<CR>")
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
