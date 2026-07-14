local M = {
  "lewis6991/gitsigns.nvim",
  enabled = true,
  event = "BufReadPost",
}

function M.config()
  local gitsigns = require("gitsigns")

  require("gitsigns").setup({
    signs                        = {
      add          = { text = "▎", },
      change       = { text = "▎", },
      delete       = { text = "▓", },
      topdelete    = { text = "▓", },
      changedelete = { text = "▎", },
    },
    signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir                 = {
      interval     = 1000,
      follow_files = true,
    },
    attach_to_untracked          = true,
    current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts      = {
      virt_text         = true,
      virt_text_pos     = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay             = 1000,
      ignore_whitespace = false,
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    sign_priority                = 6,
    update_debounce              = 100,
    status_formatter             = nil, -- Use default
    max_file_length              = 40000,
    preview_config               = {
      border   = "single",
      style    = "minimal",
      relative = "cursor",
      row      = 0,
      col      = 1,
    },

    on_attach                    = function(bufnr)
      nmap("]g", function()
        if vim.wo.diff then return "]g" end
        vim.schedule(function() gitsigns.next_hunk() end)
        return "<Ignore>"
      end, "next git chunk", { expr = true })

      nmap("[g", function()
        if vim.wo.diff then return "[g" end
        vim.schedule(function() gitsigns.prev_hunk() end)
        return "<Ignore>"
      end, "previous git chunk", { expr = true })

      s_nmap("gld", [[<CMD>silent exec "!git -C %:p:h ksdiff"<CR>]], {}, "git diff in gui")

      nmap("glR", gitsigns.reset_buffer, {}, "Reset entire buffer")
      nmap("glp", gitsigns.preview_hunk, {}, "Preview hunk")
      nmap("glr", gitsigns.undo_stage_hunk, {}, "Undo stage hunk")
      nmap("gls", gitsigns.stage_hunk, {}, "Stage hunk")
      nmap("glu", gitsigns.reset_hunk, {}, "Reset hunk")
      nmap("gll", gitsigns.setloclist, {}, "Set changes to loclist")
      nmap("glq", gitsigns.setqflist, {}, "Set changes to qflist")
      nmap("yog", gitsigns.toggle_linehl, {}, "Toggle git line highlights")

      -- map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
      -- map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
      -- map('n', '<leader>hS', gitsigns.stage_buffer)
      -- map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end)
      -- map('n', '<leader>hd', gitsigns.diffthis)
      -- map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
      -- map('n', '<leader>td', gitsigns.toggle_deleted)

      -- doesnt work
      -- nmap("glB", gitsigns.toggle_current_line_blame, {}, "Toggle line blame mode")
      -- nmap("gla", gitsigns.get_actions,               {}, "Get git actions(?)")

      -- nmap("gld", "<CMD>", {}, "Git difftool")

      oxmap('ig', ':<C-U>Gitsigns select_hunk<CR>', "in git hunk")
    end,
  })
end

return M
