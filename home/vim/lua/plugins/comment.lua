local M = {
  "numToStr/Comment.nvim",
  keys = {
    "gc",
    { "gcc", desc = "comment out line" },
    { "gcb", desc = "block comment region" },
    { "gco", desc = "add comment below line" },
    { "gcO", desc = "add comment above line" },
    { "gcA", desc = "add comment to EOL" },
    { "g>",  desc = "Comment region linewise" },
    { "g<",  desc = "Uncomment region linewise" },
    { "gy",  desc = "Comment and copy blocks" },
    { "gc",  mode = "v" },
  },
}

-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
-- ^ If needed

function M.config()
  require("Comment").setup({
    mappings = {
      -- basic = true,
      -- extra = true,
    },

    toggler = {
      block = "gcbc",
    },
    opleader = {
      block = "gcb",
    },
  })

  local ft = require("Comment.ft")
  -- ft.lua = "-- %s"
  ft.vhs = "# %s"
  -- the [[comment]] style breaks things

  local U = require("Comment.utils")
  local A = require("Comment.api")

  function _G.___gdc(motion)
    local range = U.get_region(motion)
    local lines = U.get_lines(range)

    -- Copying the block
    local srow = range.erow
    vim.api.nvim_buf_set_lines(0, srow, srow, false, lines)

    -- Doing the comment
    A.comment.linewise(motion)

    -- Move the cursor
    local erow = srow + 1
    local line = U.get_lines({ srow = srow, erow = erow })
    local _, len = string.find(line[1], "^%s*")
    vim.api.nvim_win_set_cursor(0, { erow, len })
  end

  local expr = { expr = true }

  s_vmap("gy", "<ESC><CMD>lua ___gdc(vim.fn.visualmode())<CR>", "Comment out original and paste copy")
  s_nmap("gy", "<ESC><CMD>set operatorfunc=v:lua.___gdc<CR>g@", "Comment out original and paste copy")
  s_nmap("gyy", function()
    ___gdc(nil)
  end, "Comment out line and paste copy")

  s_nmap("g>", A.call("comment.linewise", "g@"), expr, "Comment region linewise")
  s_nmap("g>c", A.call("comment.linewise.current", "g@$"), expr, "Comment current line")
  s_nmap("g>b", A.call("comment.blockwise.current", "g@$"), expr, "Comment current block")
  s_nmap("g<", A.call("uncomment.linewise", "g@"), expr, "Uncomment region linewise")
  s_nmap("g<c", A.call("uncomment.linewise.current", "g@$"), expr, "Uncomment current line")
  s_nmap("g<b", A.call("uncomment.blockwise.current", "g@$"), expr, "Uncomment current block")

  local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

  s_vmap("g>", function()
    vim.api.nvim_feedkeys(esc, "nx", false)
    A.locked("comment.linewise")(vim.fn.visualmode())
  end, {}, "Comment region linewise (visual)")

  s_vmap("g<", function()
    vim.api.nvim_feedkeys(esc, "nx", false)
    A.locked("uncomment.linewise")(vim.fn.visualmode())
  end, {}, "Uncomment region linewise (visual)")
end

return M
