local colorscheme_group = vim.api.nvim_create_augroup("ColorSchemeGroup", { clear = true })

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  group = colorscheme_group,
  callback = function()
    -- vim.api.nvim_set_hl(0, "Comment",           { foreground = "#999999", italic = true, bold = false })
    -- vim.api.nvim_set_hl(0, "Type", { bold = true })
    -- vim.api.nvim_set_hl(0, "WinSeparator", { background = nil })
    -- vim.api.nvim_set_hl(0, "MatchParen", { foreground = "#fff000" })
    -- vim.api.nvim_set_hl(0, "BufferCurrent", { background = "#506591", foreground = "#ffffff" })
    -- vim.api.nvim_set_hl(0, "BufferCurrentMod", { background = "#506591", foreground = "#FF7570" })
    -- vim.api.nvim_set_hl(0, "BufferCurrentSign", { background = "#506591", foreground = "#ffffff" })
    vim.api.nvim_set_hl(0, "GitSignsAdd", { foreground = "#608b4e" })
    vim.api.nvim_set_hl(0, "GitSignsChange", { foreground = "#dcdcaa" })
    vim.api.nvim_set_hl(0, "GitSignsDelete", { foreground = "#d16969" })
    -- vim.api.nvim_set_hl(0, "WinBarNC",          { link = "WinBar" })

    vim.api.nvim_set_hl(0, "lualine_transitional_lualine_y_filetype_DevIconVim_normal_to_lualine_c_normal",
      { background = "#ff0000" })
    vim.api.nvim_set_hl(0, "lualine_transitional_lualine_a_tabs_active_to_lualine_b_buffers_inactive",
      { background = "#ff0000" })
    vim.api.nvim_set_hl(0, "lualine_transitional_lualine_y_filetype_DevIconVim_command_to_lualine_c_command",
      { background = "#ff0000" })
    vim.api.nvim_set_hl(0, "lualine_transitional_lualine_a_command_to_lualine_c_command", { background = "#ff0000" })
  end,
})

-- lualine_transitional_LspSagaWinbarObject_to_lualine_c_insert xxx guibg=#0f1c1e
-- lualine_transitional_LspSagaWinbarFunction_to_lualine_c_visual xxx guibg=#0f1c1e
-- lualine_transitional_LspSagaWinbarArray_to_lualine_c_insert xxx guibg=#0f1c1e

-- winbar=%<%#lualine_c_command#%=%#lualine_transitional_lualine_a_command_to_lualine_c_command# %#lualine_a_command# [No Name]
-- lualine_x_filetype_DevIconVim_normal xxx guifg=#019833 guibg=#0f1c1e
-- lualine_x_filetype_DevIconVim_insert xxx guifg=#019833 guibg=#0f1c1e
-- lualine_x_filetype_DevIconVim_visual xxx guifg=#019833 guibg=#0f1c1e
-- lualine_x_filetype_DevIconVim_replace xxx guifg=#019833 guibg=#0f1c1e
-- lualine_x_filetype_DevIconVim_command xxx guifg=#019833 guibg=#0f1c1e
-- lualine_x_filetype_DevIconVim_terminal xxx guifg=#019833 guibg=#0f1c1e
-- lualine_x_filetype_DevIconVim_inactive xxx guifg=#019833 guibg=#0f1c1e
-- lualine_transitional_lualine_a_tabs_active_to_lualine_b_buffers_inactive xxx guifg=#5a93aa guibg=#0f1c1e
-- lualine_transitional_lualine_b_buffers_inactive_to_lualine_b_buffers_active xxx guifg=#0f1c1e guibg=#506591
-- lualine_y_filetype_DevIconVim_normal xxx guifg=#019833 guibg=#253f48
-- lualine_y_filetype_DevIconVim_insert xxx guifg=#019833 guibg=#2f4445
-- lualine_y_filetype_DevIconVim_visual xxx guifg=#019833 guibg=#3e2f3a
-- lualine_y_filetype_DevIconVim_replace xxx guifg=#019833 guibg=#502f2d
-- lualine_y_filetype_DevIconVim_command xxx guifg=#019833 guibg=#56443b
-- lualine_y_filetype_DevIconVim_terminal xxx guifg=#019833 guibg=#573a2a
-- lualine_y_filetype_DevIconVim_inactive xxx guifg=#019833 guibg=#243839 #0F1B1E
-- lualine_transitional_lualine_y_filetype_DevIconVim_normal_to_lualine_c_normal xxx guifg=#253f48 guibg=#0f1c1e
-- lualine_transitional_lualine_a_normal_to_lualine_b_normal xxx guifg=#5a93aa guibg=#253f48
-- lualine_transitional_lualine_y_filetype_DevIconVim_command_to_lualine_c_command xxx guifg=#56443b guibg=#0f1c1e
-- lualine_transitional_lualine_a_command_to_lualine_b_command xxx guifg=#fda47f guibg=#56443b

local vimrchelp_group = vim.api.nvim_create_augroup("VimrcHelp", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.txt",
  group = vimrchelp_group,
  callback = function()
    local buftype = vim.api.nvim_buf_get_option(0, "buftype")

    if buftype == "help" then
      vim.cmd("wincmd o")
      vim.opt_local.number = nil
      vim.opt_local.buflisted = true
    end
  end,
})

local buffer_management = vim.api.nvim_create_augroup("BufferManagement", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  group = buffer_management,
  callback = function()
    if vim.tbl_count(vim.fn.getbufinfo({ buflisted = 1 })) > 1 then
      vim.opt.showtabline = 2
    else
      vim.opt.showtabline = 0
    end
  end,
})

local grabbag_group = vim.api.nvim_create_augroup("GrabBag", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  group = grabbag_group,
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

vim.api.nvim_create_autocmd("BufDelete", {
  pattern = "*",
  group = grabbag_group,
  callback = function()
    vim.g.latest_deleted_buffer = vim.fn.expand("<afile>:p")
  end,
})

-- taken care of by yanky.nvim
-- vim.api.nvim_create_autocmd('TextYankPost', {
--   pattern = "*",
--   group = grabbag_group,
--   callback = function()
--     vim.highlight.on_yank()
--   end,
-- })

local ns = vim.api.nvim_create_namespace("toggle_hlsearch")

local function toggle_hlsearch(char)
  if vim.fn.mode() == "n" then
    local keys = { "<CR>", "n", "N", "*", "#", "?", "/" }
    local new_hlsearch = vim.tbl_contains(keys, vim.fn.keytrans(char))

    if vim.opt.hlsearch:get() ~= new_hlsearch then
      vim.opt.hlsearch = new_hlsearch
    end
  end
end

vim.on_key(toggle_hlsearch, ns)

-- local golang_group = vim.api.nvim_create_augroup( "Golang", { clear = true })
--
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*",
--   group = golang_group,
--   callback = function()
--     vim.lsp.buf.formatting_sync(nil,500)
--   end,
-- })

-- TODO: Lua-fy this

vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)
