
local M = {
  dir = "~/code/vim-sayonara",
  event = "BufRead",
  keys = { "Q" }
}

function M.config()
-- local buffers = require('buffers')
--
-- nmap("<leader>x", buffers.only)
-- nmap("<leader>X", buffers.clear)
s_nmap("Q", "<CMD>Sayonara<CR>")

end

return M
