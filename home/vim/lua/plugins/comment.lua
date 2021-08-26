local M = {
  "numToStr/Comment.nvim",
  keys = {
    "gc",
    { "gcc", desc = "comment out line" },
    { "gbc", desc = "block comment region" },
    { "g>",  desc = "Comment region linewise" },
    { "g<",  desc = "Uncomment region linewise" },
    { "gy",  desc = "Comment and copy blocks" },
    { "gc",  mode = "v" }
  },
}

function M.config()
  require("Comment").setup({
    mappings = {
      basic = true,
      extra = true,
    },
  })

  local ft = require("Comment.ft")
  ft.lua = "-- %s"
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

  s_vmap("gy", "<ESC><CMD>lua ___gdc(vim.fn.visualmode())<CR>", {}, "Comment out original and paste copy")
  s_nmap("gy", "<ESC><CMD>set operatorfunc=v:lua.___gdc<CR>g@", {}, "Comment out original and paste copy")

  s_nmap("g>",  A.call("comment.linewise",            "g@"),  { expr = true }, "Comment region linewise" )
  s_nmap("g>c", A.call("comment.linewise.current",    "g@$"), { expr = true }, "Comment current line" )
  s_nmap("g>b", A.call("comment.blockwise.current",   "g@$"), { expr = true }, "Comment current block" )
  s_nmap("g<",  A.call("uncomment.linewise",          "g@"),  { expr = true }, "Uncomment region linewise" )
  s_nmap("g<c", A.call("uncomment.linewise.current",  "g@$"), { expr = true }, "Uncomment current line" )
  s_nmap("g<b", A.call("uncomment.blockwise.current", "g@$"), { expr = true }, "Uncomment current block" )

  local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

  s_vmap("g>", function()
    vim.api.nvim_feedkeys(esc, "nx", false)
    A.locked("comment.linewise")(vim.fn.visualmode())
  end, {}, "Comment region linewise (visual)" )

  s_vmap("g<", function()
    vim.api.nvim_feedkeys(esc, "nx", false)
    A.locked("uncomment.linewise")(vim.fn.visualmode())
  end, {}, "Uncomment region linewise (visual)" )
end

return M
