-- hello, you look nice today :)
if vim.loader then
  vim.loader.enable()
end

require("utility")

vim.g.mapleader      = ","
vim.g.maplocalleader = "\\"

local lazypath       = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.runtimepath:prepend(lazypath)

-- nvim built in plugins
if Nv12() then
  vim.cmd("packadd justify")
  vim.cmd("packadd nohlsearch")
  vim.cmd("packadd nvim.undotree")
  s_nmap("<space>u", require("undotree").open, {}, "Undo tree")
end

require("lazy").setup("plugins", {
  change_detection = { enabled = true, notify = false },
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

vim.opt.linebreak      = true
vim.opt.wrap           = true
vim.opt.expandtab      = true
vim.opt.conceallevel   = 2
vim.opt.cmdheight      = 0
vim.opt.fillchars      = {
  stlnc     = icons["stlnc"],
  fold      = icons["fold"],
  diff      = icons["diff"],
  eob       = icons["eob"],
  horiz     = icons["horiz"],
  horizup   = icons["horizup"],
  horizdown = icons["horizdown"],
  vert      = icons["vert"],
  vertleft  = icons["vertleft"],
  vertright = icons["vertright"],
  verthoriz = icons["verthoriz"],
  foldsep   = icons["foldsep"],
  foldopen  = icons["foldopen"],
  foldclose = icons["foldclose"],
}

vim.opt.foldenable     = true
vim.opt.foldlevel      = 99
vim.opt.foldmethod     = "expr"
vim.opt.foldtext       = ""
vim.opt.foldcolumn     = "auto"
vim.opt.formatoptions  = "jcrqlnt"
vim.opt.ignorecase     = true
vim.opt.inccommand     = "split"
vim.opt.laststatus     = 3
vim.opt.list           = false
vim.opt.number         = true
vim.opt.pumblend       = 50
vim.opt.pumheight      = 10
vim.opt.relativenumber = true
vim.opt.report         = 0
vim.opt.scrolloff      = 8
vim.opt.shiftround     = true
vim.opt.shiftwidth     = 2
vim.opt.showcmd        = false
vim.opt.showmode       = true
vim.opt.shortmess:append("AI")
vim.opt.smartcase     = true
vim.opt.smartindent   = true
vim.opt.smoothscroll  = true
vim.opt.spell         = true
vim.opt.spelllang     = "en_us"
vim.opt.synmaxcol     = 180
vim.opt.tabstop       = 2
vim.opt.termguicolors = true
vim.opt.timeoutlen    = 300
vim.opt.updatetime    = 300
vim.opt.virtualedit   = "block"
vim.opt.whichwrap     = "b,h,l,s,<,>,[,],~"
vim.opt.wildmode      = "longest:full,full"
vim.opt.winblend      = 0
vim.opt.winborder     = "bold"

vim.opt.wildignore    = {
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

for _, mod in ipairs({
  "folders",
  "commands",
  "mappings",
  "autocommands",
  "operators",
}) do
  require(mod)
end

vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider   = 0
vim.g.loaded_perl_provider   = 0

if InNeovide() then
  require("neovide")
end
