local M = {
  dir   = "~/code/vim-sayonara",
  event = "BufRead",
  keys  = { "Q" }
}

function M.config()
  s_nmap("Q", "<CMD>Sayonara<CR>")
end

return M
