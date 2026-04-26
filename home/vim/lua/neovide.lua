vim.opt.guicursor = {
  "n-v-c-sm:block-Cursor", -- Use 'Cursor' highlight for normal, visual, and command modes
  "i-ci-ve:ver25-lCursor", -- Use 'lCursor' highlight for insert and visual-exclusive modes
  "r-cr:hor20-CursorIM",   -- Use 'CursorIM' for replace mode
}

vim.g.neovide_scale_factor = 1.0

local change_scale_factor =
    function(delta)
      vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end

vim.keymap.set({ "n", "i" }, "<D-=>", function() change_scale_factor(1.25) end)
vim.keymap.set({ "n", "i" }, "<D-->", function() change_scale_factor(1 / 1.25) end)


vim.g.neovide_cursor_short_animation_length  = 0.01
vim.g.neovide_cursor_animation_length        = 0.01
vim.g.neovide_cursor_trail_length            = 0.005
vim.g.neovide_cursor_trail_size              = 0.1
vim.g.neovide_cursor_vfx_mode                = ""
vim.g.neovide_floating_shadow                = false
vim.g.neovide_input_macos_option_key_is_meta = "only_left"
vim.g.neovide_input_use_logo                 = true
vim.g.neovide_refresh_rate                   = 120
vim.g.neovide_remember_window_size           = true
vim.g.neovide_scroll_animation_length        = 0.01

vim.keymap.set("c", "<D-v>", "<C-R>+")

vim.keymap.set("n", "<D-[>", "<C-w>w")
vim.keymap.set("n", "<D-]>", "<C-w>W")
vim.keymap.set("n", "<D-s>", ":w<CR>")
vim.keymap.set("n", "<D-v>", '"+P')
vim.keymap.set("n", "<D-k>", "<M-k>")
-- vim.keymap.set("i", "<D-k>", "<M-k>")

vim.keymap.set("v", "<D-c>", '"+y')
vim.keymap.set("v", "<D-v>", '"+P')
vim.keymap.set("i", '<D-v>', '<ESC>l"+Pli')

vim.g.neovide_padding_top = 1
vim.g.neovide_padding_bottom = 1
vim.g.neovide_padding_right = 1
vim.g.neovide_padding_left = 1
