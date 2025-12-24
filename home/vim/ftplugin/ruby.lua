-- vim.opt_local.colorcolumn    = 81
vim.g.ruby_minlines          = 100
vim.g.ruby_no_expensive      = 1
vim.b.deleft_closing_pattern = '^\\s*end\\>'
vim.opt_local.formatoptions:remove({ "c", "r", "o" })

s_nmap("<m-p>", "Obinding.irb<ESC>j0", {}, "Add a irb", "Adding a irb")
