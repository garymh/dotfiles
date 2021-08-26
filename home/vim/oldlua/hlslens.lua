local M = {
  "kevinhwang91/nvim-hlslens",
  enabled = false
}

function M.config()
  require("hlslens").setup({
    auto_enable = true,
    calm_down = true,
    override_line_lens = nil,
  })

  s_map("n", "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>", { noremap = true })
  s_map("N", "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>", { noremap = true })

  s_map("*", "<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>")
  s_map("#", "<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>")
  s_map("g*", "<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>")
  s_map("g#", "<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>")
end

return M
