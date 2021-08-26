local M = {
  "tpope/vim-unimpaired",
}

function M.config()
  s_nmap("[t", vim.cmd.tabprev, {}, "Previous tab")
  s_nmap("]t", vim.cmd.tabnext, {}, "Next tab")
  s_nmap("[T", vim.cmd.tabfirst, {}, "First tab")
  s_nmap("]T", vim.cmd.tablast, {}, "Last tab")
  -- s_nmap("]F", "<Nop>", "", )
  -- s_nmap("[F", "<Nop>")
  -- s_nmap("]f", "<Nop>")
  -- s_nmap("[f", "<Nop>")
  -- s_nmap("[", "<Plug>unimpairedBPrevious", {}, "Last file" )
  -- s_nmap("]", "<Plug>unimpairedBNext", {}, "Next file" )
end

return M
