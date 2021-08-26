local M = {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
}

function M.config()
  local gitsigns = require("gitsigns")

  require("gitsigns").setup({
    signs = {
      -- add          = {hl = 'GitSignsAdd'   , text = '▓', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
      -- change       = {hl = 'GitSignsChange', text = '▓', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
      -- delete       = {hl = 'GitSignsDelete', text = '▓', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
      -- topdelete    = {hl = 'GitSignsDelete', text = '▓', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
      -- changedelete = {hl = 'GitSignsChange', text = '▓', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
      add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
      change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
      delete = { hl = "GitSignsDelete", text = "▓", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
      topdelete = { hl = "GitSignsDelete", text = "▓", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
      changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000,
    preview_config = {
      -- Options passed to nvim_open_win
      border = "single",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    yadm = {
      enable = false,
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map("n", "]c", function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return "<Ignore>"
      end, { expr = true, desc = "next git chunk"})

      map("n", "[c", function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end, { expr = true, desc = "previous git chunk"})

      -- doesnt work
      -- nmap("glB", gitsigns.toggle_current_line_blame, {}, "Toggle line blame mode")
      -- nmap("gla", gitsigns.get_actions,               {}, "Get git actions(?)")

      -- nmap("gld", "<CMD>", {}, "Git difftool")

      s_nmap("gld", [[<CMD>silent exec "!git -C %:p:h ksdiff"<CR>]], {}, "git diff in gui")

      nmap("glR", gitsigns.reset_buffer,              {}, "Reset entire buffer")
      nmap("glp", gitsigns.preview_hunk,              {}, "Preview hunk")
      nmap("glr", gitsigns.undo_stage_hunk,           {}, "Undo stage hunk")
      nmap("gls", gitsigns.stage_hunk,                {}, "Stage hunk")
      nmap("glu", gitsigns.reset_hunk,                {}, "Reset hunk")
      nmap("gll", gitsigns.setloclist,                {}, "Set changes to loclist")
      nmap("glq", gitsigns.setqflist,                 {}, "Set changes to qflist")
      nmap("yog", gitsigns.toggle_linehl,             {}, "toggle git line highlights")

      map({'o', 'x'}, 'ig', ':<C-U>Gitsigns select_hunk<CR>', { desc = "in git hunk" })

    end,
  })
end

return M
