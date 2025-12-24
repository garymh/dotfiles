vim.keymap.set("n", "<localleader>p", "<CMD>Pick<CR>", { buffer = true, noremap = true, silent = true })
vim.keymap.set("n", "<localleader>s", "<CMD>Squash<CR>", { buffer = true, noremap = true, silent = true })
vim.keymap.set("n", "<localleader>e", "<CMD>Edit<CR>", { buffer = true, noremap = true, silent = true })
vim.keymap.set("n", "<localleader>r", "<CMD>Reword<CR>", { buffer = true, noremap = true, silent = true })
vim.keymap.set("n", "<localleader>f", "<CMD>Fixup<CR>", { buffer = true, noremap = true, silent = true })
vim.keymap.set("n", "<localleader>c", "<CMD>Cycle<CR>", { buffer = true, noremap = true, silent = true })

vim.wo.wrap = false
