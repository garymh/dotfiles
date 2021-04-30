-- hello, you look nice today :)
-- vi: foldmethod=marker
require 'util'
require 'plugins'

vim_command [[PackerInstall packadd packer.nvim | lua require('plugins').install()]]
vim_command [[PackerUpdate packadd packer.nvim  | lua require('plugins').update() ]]
vim_command [[PackerSync packadd packer.nvim    | lua require('plugins').sync()   ]]
vim_command [[PackerClean packadd packer.nvim   | lua require('plugins').clean()  ]]
vim_command [[PackerCompile packadd packer.nvim | lua require('plugins').compile()]]
vim_command [[PlugInstall packadd packer.nvim   | lua require('plugins').install()]]
vim_command [[PlugUpdate packadd packer.nvim    | lua require('plugins').update() ]]
vim_command [[PlugClean packadd packer.nvim     | lua require('plugins').clean()  ]]

vim.api.nvim_command [[ augroup auto_compile ]]
vim.api.nvim_command [[ autocmd! ]]
vim.api.nvim_command [[ autocmd BufWritePost plugins.lua PackerCompile ]]
vim.api.nvim_command [[ augroup END ]]

nvim_vsource [[vimscript/packer_compiled.vim]]

vim.o.cmdheight = 1
vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.expandtab = true
vim.o.fillchars = "stlnc:=,vert:│,fold:·,diff:-,eob:·"
vim.o.foldlevelstart = 5
vim.o.formatprg = "par 79"
vim.o.hidden = true
vim.o.ignorecase = true
vim.o.inccommand = "split"
vim.o.lazyredraw = true
vim.o.laststatus = 2
vim.o.list = true
vim.o.listchars = "nbsp:⦸,trail:•,tab:├─,precedes:«,extends:»"
vim.o.pumblend = 0
vim.o.report = 0
vim.o.shiftwidth = 2
vim.o.shiftround = true
vim.o.showcmd = false
vim.o.showmode = false
vim.o.signcolumn = "yes:1"
vim.o.smartcase = true
vim.o.spelllang = "en_us"
vim.o.synmaxcol = 180
vim.o.timeoutlen = 300
vim.o.updatetime = 100
vim.o.virtualedit = "block"
vim.o.whichwrap = "b,h,l,s,<,>,[,],~"
vim.o.wildmode = "longest:full,full"
vim.o.winblend = 0
vim.o.wrap = true

if plugin_loaded("nvim-treesitter") then
  vim.wo.foldmethod = "expr"
  vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
end

-- I have no idea why these need to be set with buffer settings
-- to actually be turned on. Maybe revisit this on occasion if
-- it's an nvim bug?
vim.bo.autoindent = true
vim.bo.expandtab = true
vim.bo.formatprg = "par 79"
vim.bo.spelllang = "en_us"
vim.bo.synmaxcol = 180

vim.o.wildignore = ".DS_Store"
setplus('shortmess', 'A')
setplus('shortmess', 'I')
setplus('shortmess', 'S')
setplus('formatoptions', 'j')
setplus('formatoptions', 'n')
setplus('wildignore', ',*.jpg,*.jpeg,*.gif,*.png,*.psd,*.min.js,*.sock')
setplus('wildignore', ',*/.git/*,*/log/*,*/tmp/*,.keep,.git/*,*/dotbot/*')

require 'folders'  -- Setting up backup folders
require 'mappings' -- Keymaps and whichkey settings

-- TODO: lua-ify these when nvim supports it
nvim_vsource [[vimscript/autocommands.vim]]
nvim_vsource [[vimscript/functions.vim]]

vim.api.nvim_command [[colorscheme tokyodark]]
-- vim.api.nvim_command [[colorscheme tokyonight]]
vim.api.nvim_command [[syntax sync minlines=256]]

-- providers i don't use:
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- disable some built-in plugins i don't use:
local disabled_built_ins = {
    'gzip', 'man', 'matchit', 'matchparen', 'shada_plugin', 'tarPlugin', 'tar',
    'zipPlugin', 'zip', 'netrwPlugin'
}

for i = 1, 10 do vim.g['loaded_' .. disabled_built_ins[i]] = 1 end
