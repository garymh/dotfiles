local M = {
  "wincent/command-t",
  build = "cd lua/wincent/commandt/lib && make",
  init = function()
    vim.g.CommandTPreferredImplementation = "lua"
  end,
  enabled = false,
}

function M.config()
  require("wincent.commandt").setup({
    always_show_dot_files = false,
    height = 30,
    ignore_case = nil, -- nil means "infer from Neovim's 'ignorecase'".
    mappings = {
      i = {
        ["<C-a>"] = "<Home>",
        ["<esc>"] = "close",
        ["<C-c>"] = "close",
        ["<C-e>"] = "<End>",
        ["<C-h>"] = "<Left>",
        ["<C-j>"] = "select_next",
        ["<C-k>"] = "select_previous",
        ["<C-l>"] = "<Right>",
        ["<C-n>"] = "select_next",
        ["<C-p>"] = "select_previous",
        ["<C-s>"] = "open_split",
        ["<C-t>"] = "open_tab",
        ["<C-v>"] = "open_vsplit",
        ["<CR>"] = "open",
        ["<Down>"] = "select_next",
        ["<Up>"] = "select_previous",
      },
    },
    margin = 10,
    never_show_dot_files = false,
    order = "forward",   -- 'forward' or 'reverse'.
    position = "center", -- 'bottom', 'center' or 'top'.
    -- open = function(item, kind)
    --   commandt.open(item, kind)
    -- end,
    scanners = {
      git = {
        submodules = false,
        untracked = true,
      },
    },
    selection_highlight = "PMenuSel",
    smart_case = nil, -- nil means "infer from Neovim's 'smartcase'".
    threads = nil,    -- nil means "auto".
  })

  s_nmap("<m-k>", "<Plug>(CommandTBuffer)")
  -- s_map( '<Plug>(CommandTJump)')
  s_nmap("<c-p>", "<Plug>(CommandT)")
  s_nmap("<space>g", "<Plug>(CommandTGit)")
  -- s_nmap("<cr>",     fzflua.buffers)
  -- s_nmap("<space>2", edit_specs)
  -- s_nmap("<space>l", fzflua.grep_curbuf)
  -- s_nmap("<space>m", edit_models)
  -- s_nmap("<c-p>", fzflua.files)
  -- s_nmap("<m-k>", fzflua.buffers)
  -- s_nmap("<space>C", fzflua.git_bcommits, {}, "git commits for this buffer")
  -- s_nmap("<space>F", fzflua.filetypes, {}, "change vim filetype")
  -- s_nmap("<space>R", fzflua.command_history, {}, "vim command history")
  -- s_nmap("<space>S", fzflua.colorschemes, {}, "list colorschemes")
  -- s_nmap("<space>c", fzflua.git_commits, {}, "git commits for this project")
  -- s_nmap("<space>g", fzflua.git_status, {}, "git status")
  -- s_nmap("<space>h", fzflua.help_tags, {}, "vim helptags")
  -- s_nmap("<space>r", fzflua.oldfiles, {}, "list old files")
  -- s_nmap("<space>s", edit_snippets, {}, "edit snippets")
  -- s_nmap("<space>y", vim.cmd.YankyRingHistory, {}, "yank history")
  -- s_nmap("<space>t", edit_go_test_files, {}, "edit go test files")
  -- s_nmap("<space>m", edit_go_files, {}, "edit go files")
end

return M
