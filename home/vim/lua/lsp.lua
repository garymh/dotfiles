local lsp_status = require('lsp-status')
lsp_status.register_progress()

local lspconfig  = require('lspconfig')

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  }
)

lspconfig.solargraph.setup({
    on_attach    = lsp_status.on_attach,
    capabilities = lsp_status.capabilities
  })

lspconfig.vimls.setup({
    on_attach    = lsp_status.on_attach,
    capabilities = lsp_status.capabilities
  })

lsp_status.config({
    indicator_errors   = '',
    indicator_warnings = '',
    indicator_info     = '🛈',
    indicator_hint     = '❗',
    indicator_ok       = '',
    spinner_frames     = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' },
    status_symbol      = '𝓵',
  })

local mapper = function(mode, key, result)
  vim.api.nvim_buf_set_keymap(0, mode, key, result, {noremap = true, silent = true})
end

mapper('n', '<space>sl', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
