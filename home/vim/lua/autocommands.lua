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
  if Nv13() then
    -- 0.13: `msg.target` -> `msg.targets`; `msg.timeout` -> 'messagesopt'
    vim.opt.messagesopt:append("timeout:4000")
    require("vim._core.ui2").enable { enable = true, msg = { targets = "cmd" } }
  else
    require("vim._core.ui2").enable {
      enable = true,
      msg = {
        target = "cmd",
        timeout = 4000,
      },
    }
  end
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

-- auto-change cwd to nearest project root, unless we're inside an ignored subtree
local ignore_roots = {
  vim.fn.expand('~/code/dotfiles'),
  vim.fn.expand('~/.config'),
}
local function is_ignored(path)
  for _, r in ipairs(ignore_roots) do
    if path == r or path:sub(1, #r + 1) == r .. '/' then return true end
  end
  return false
end
vim.api.nvim_create_autocmd('BufEnter', {
  group = Augroup("auto_root"),
  callback = function()
    if is_ignored(vim.fn.getcwd()) then return end
    local found = vim.fs.find({ '.git', 'Makefile' }, { upward = true })[1]
    if found then
      local root = vim.fs.dirname(found)
      if root ~= vim.fn.getcwd() then vim.cmd.cd(root) end
    end
  end,
})
