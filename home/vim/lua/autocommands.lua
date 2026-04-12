vim.api.nvim_create_autocmd("ColorScheme", { -- consistent git colors for my sanity
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
