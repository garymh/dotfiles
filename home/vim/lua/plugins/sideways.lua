local M = {
  "AndrewRadev/sideways.vim",
  enabled = true
}

function M.config()
  -- s_omap("aa", "<Plug>SidewaysArgumentTextobjA")
  -- s_omap("ia", "<Plug>SidewaysArgumentTextobjI")
  -- s_vmap("aa", "<Plug>SidewaysArgumentTextobjA")
  -- s_vmap("ia", "<Plug>SidewaysArgumentTextobjI")
  s_nmap("<localleader>si", "<Plug>SidewaysArgumentInsertBefore", {}, "insert arg before", "insert arg before")
  s_nmap("<localleader>sa", "<Plug>SidewaysArgumentAppendAfter", {}, "insert arg after", "insert arg after")
  s_nmap("<localleader>sI", "<Plug>SidewaysArgumentInsertFirst", {}, "insert arg first", "insert arg first")
  s_nmap("<localleader>sA", "<Plug>SidewaysArgumentAppendLast", {}, "insert arg last", "insert arg last")
end

return M
