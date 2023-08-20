-- hello, you look nice today :)
if vim.fn.has('nvim-0.9.0dev') == 1 then
  vim.loader.enable()
end

require("utility")

vim.g.mapleader      = ","
vim.g.maplocalleader = "\\"

local lazypath       = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

---@diagnostic disable-next-line: param-type-mismatch, missing-parameter
require("lazy").setup("plugins", {
  change_detection = {
    enabled = true,
    notify = false,
  },
  ui = {
    size = { width = 0.99, height = 0.99 },
  },
  install = {
    colorscheme = { "monokai-pro", },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "loaded_remote_plugins",
        "loaded_tutor_mode_plugin",
        "logipat",
        "matchit",
        "matchparen",
        "netrw",
        "netrwFileHandlers",
        "netrwPlugin",
        "netrwSettings",
        "rrhelper",
        "spellfile_plugin",
        "tar",
        "tarPlugin",
        "tohtml",
        "tutor",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
      },
    },
  },
})

vim.opt.linebreak = true
vim.opt.wrap      = true
vim.opt.cmdheight = 1
vim.opt.expandtab = true
vim.opt.fillchars = {
  stlnc     = "·",
  fold      = "·",
  diff      = "-",
  eob       = "·",
  horiz     = "━",
  horizup   = "┻",
  horizdown = "┳",
  vert      = "┃",
  vertleft  = "┫",
  vertright = "┣",
  verthoriz = "╋",
}


vim.opt.foldlevelstart = 99
vim.opt.hidden         = true
vim.opt.ignorecase     = true
vim.opt.inccommand     = "split"
vim.opt.laststatus     = 3
vim.opt.list           = false
vim.opt.pumblend       = 0
vim.opt.pumheight      = 10
vim.opt.report         = 0
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.shiftround     = true
vim.opt.shiftwidth     = 2
vim.opt.showcmd        = false
vim.opt.showmode       = false
vim.opt.signcolumn     = "yes:1"
vim.opt.smartcase      = true
vim.opt.smartindent    = true
vim.opt.spell          = true
vim.opt.spelllang      = "en_us"
vim.opt.synmaxcol      = 180
vim.opt.tabstop        = 2
vim.opt.termguicolors  = true
vim.opt.timeoutlen     = 300
vim.opt.updatetime     = 300
vim.opt.virtualedit    = "block"
vim.opt.whichwrap      = "b,h,l,s,<,>,[,],~"
vim.opt.wildmode       = "longest:full,full"
vim.opt.winblend       = 0
vim.opt.wrap           = false

vim.opt.shortmess:append("AI")

vim.opt.wildignore = {
  ".DS_Store",
  "*.jpg",
  "*.jpeg",
  "*.gif",
  "*.png",
  "*.psd",
  "*.min.js",
  "*.sock",
  ".git/*",
  "*./log/*",
  "./tmp/*",
  ".keep",
  "./dotbot/*",
}

vim.opt.formatoptions:append({ "j", "n" })

require("folders")      -- setting up backup folders
require("commands")     -- neat functions
require("mappings")     -- basic keymaps
require("autocommands") -- color overrides, misc
require("operators")    -- custom operators

vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider   = 0
vim.g.loaded_perl_provider   = 0
