vim.opt_local.foldenable  = false
vim.opt_local.spell       = true
vim.opt_local.textwidth   = 51
vim.opt_local.colorcolumn = { 51, 73 }

vim.cmd([[normal gg]])

local function startInsertIfEmpty()
  if vim.fn.empty(vim.fn.getline(1)) == 1 then
    vim.cmd([[startinsert!]])
  end
end

startInsertIfEmpty()
