vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  group = Augroup("colorscheme_group"),
  callback = function()
    vim.api.nvim_set_hl(0, "GitSignsAdd", { foreground = "#608b4e" })
    vim.api.nvim_set_hl(0, "GitSignsChange", { foreground = "#dcdcaa" })
    vim.api.nvim_set_hl(0, "GitSignsDelete", { foreground = "#d16969" })
  end,
})

if InGui() == false and Nv12() then
  require("vim._core.ui2").enable {
    enable = true,
    msg = {
      target = "cmd",
      timeout = 4000,
    },
  }
end

vim.api.nvim_create_autocmd('BufReadPost', {
  group = Augroup("lastposition"),
  callback = function(args)
    local valid_line = vim.fn.line([['"]]) >= 1 and vim.fn.line([['"]]) < vim.fn.line('$')
    local not_commit = vim.b[args.buf].filetype ~= 'commit'

    if valid_line and not_commit then
      vim.cmd('normal! g`"zz')
    end
  end,
})

-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = "*.txt",
--   group = Augroup("vimrchelp"),
--   callback = function()
--     local buftype = vim.api.nvim_buf_get_option(0, "buftype")
--
--     if buftype == "help" then
--       vim.cmd("wincmd o")
--       vim.opt_local.number = nil
--       vim.opt_local.buflisted = true
--     end
--   end,
-- })

-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = "*",
--   group = Augroup("buffer_management"),
--   callback = function()
--     if vim.tbl_count(vim.fn.getbufinfo({ buflisted = 1 })) > 1 then
--       vim.opt.showtabline = 2
--     else
--       vim.opt.showtabline = 0
--     end
--   end,
-- })

-- trying to remove
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "*",
--   group = Augroup("grabbag"),
--   callback = function() vim.opt_local.formatoptions:remove({ "c", "r", "o" }) end,
-- })

local ns = vim.api.nvim_create_namespace("toggle_hlsearch")
local function toggle_hlsearch(char)
  if vim.fn.mode() == "n" then
    local keys = { "<CR>", "n", "N", "*", "#", "?", "/" }
    local new_hlsearch = vim.tbl_contains(keys, vim.fn.keytrans(char))

    if vim.opt.hlsearch:get() ~= new_hlsearch then vim.opt.hlsearch = new_hlsearch end
  end
end

vim.on_key(toggle_hlsearch, ns)

-- http://www.lazyvim.org/configuration/general
-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = Augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+://") then return end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})
