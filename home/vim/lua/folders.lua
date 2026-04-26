vim.fn.mkdir(Home .. '/.local/share/nvim/backup', 'p')
vim.fn.mkdir(Home .. '/.local/share/nvim/undo', 'p')

if os.getenv("SUDO_USER") then
  vim.o.backup      = false
  vim.o.writebackup = false
  vim.o.swapfile    = false
  vim.o.undofile    = false
else
  vim.o.backupdir   = Home .. "/.local/share/nvim/backup"
  vim.o.undofile    = true
  vim.o.backup      = true
  vim.o.writebackup = true
  vim.o.swapfile    = true
end
