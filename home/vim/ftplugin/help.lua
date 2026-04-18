vim.o.list          = false
vim.o.colorcolumn   = ""
vim.o.concealcursor = "nc"
vim.o.number        = nil

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "help",
--   callback = function()
--     vim.cmd("wincmd o")
--   end,
-- })

vim.keymap.set("n", "<cr>", "<c-]>", { buffer = true, noremap = true })
vim.keymap.set("n", "o", "<c-]>", { buffer = true, noremap = true })
vim.keymap.set("n", "<bs>", "<c-T>", { buffer = true, noremap = true })
