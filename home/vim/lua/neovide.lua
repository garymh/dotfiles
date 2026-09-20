local function save() vim.cmd.write() end
local function copy() vim.cmd([[normal! "+y]]) end
local function paste() vim.api.nvim_paste(vim.fn.getreg("+"), true, -1) end


local change_scale_factor =
    function(delta)
      vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end

vim.keymap.set({ "n", "i" }, "<D-=>", function() change_scale_factor(1.25) end)
vim.keymap.set({ "n", "i" }, "<D-->", function() change_scale_factor(1 / 1.25) end)

vim.o.guifont                                = "FixedsysModernV05 Nerd Font Mono:h28:w1:#e-subpixelantialias:#h-none"
vim.opt.number                               = false
vim.opt.relativenumber                       = false

vim.opt.linespace                            = 2
vim.opt.laststatus                           = 0

vim.g.neovide_cursor_animation_length        = 0.01
vim.g.neovide_cursor_short_animation_length  = 0.01
vim.g.neovide_cursor_trail_length            = 0.005
vim.g.neovide_cursor_trail_size              = 0.1
vim.g.neovide_cursor_vfx_mode                = ""
vim.g.neovide_floating_shadow                = false
vim.g.neovide_input_macos_option_key_is_meta = "only_left"
vim.g.neovide_input_use_logo                 = true
vim.g.neovide_refresh_rate                   = 120
vim.g.neovide_remember_window_size           = true
vim.g.neovide_scroll_animation_length        = 0.01
vim.g.neovide_show_border                    = true
vim.g.neovide_underline_stroke_scale         = 0.3
vim.g.neovide_scale_factor                   = 1.0

vim.keymap.set({ "n", "i", "v" }, "<D-s>", save, { desc = "Save" })
vim.keymap.set("v", "<D-c>", copy, { silent = true, desc = "Copy" })
vim.keymap.set({ "n", "i", "v", "c", "t" }, "<D-v>", paste, { silent = true, desc = "Paste" })
vim.keymap.set("n", "<D-[>", "<C-w>w")
vim.keymap.set("n", "<D-]>", "<C-w>W")
vim.keymap.set("n", "<D-s>", ":w<CR>")
vim.keymap.set("n", "<D-k>", "<M-k>", { remap = true })
vim.keymap.set({ 'i', 'n' }, '<D-w>', vim.cmd.quit)

vim.g.neovide_padding_top    = 12
vim.g.neovide_padding_bottom = 12
vim.g.neovide_padding_right  = 12
vim.g.neovide_padding_left   = 12
