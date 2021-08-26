local M = {
  "ray-x/go.nvim",
  dependencies = { "ray-x/guihua.lua" },
  ft = "go",
}

function M.config()
  require("go").setup({
    verbose = false, -- output loginf in messages

    dap_debug = true, -- set to true to enable dap
    dap_debug_keymap = false, -- set keymaps for debugger
    dap_debug_gui = true, -- set to true to enable dap gui, highly recommand
    dap_debug_vt = true, -- set to true to enable dap virtual text

    lsp_cfg = false, -- true: apply go.nvim non-default gopls setup
    lsp_gofumpt = false, -- true: set default gofmt in gopls format to gofumpt
    lsp_on_attach = false, -- if a on_attach function provided:  attach on_attach function to gopls
    gopls_cmd = nil, -- if you need to specify gopls path and cmd, e.g {"/home/user/lsp/gopls", "-logfile", "/var/log/gopls.log" }
  })
end

return M
