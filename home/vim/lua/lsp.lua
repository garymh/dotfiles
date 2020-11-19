-- require'nvim-treesitter.configs'.setup {
--   ensure_installed = "all",
--   highlight = {
--     enable = true,
--   },
-- }

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  }
)

local lsp_status = require('lsp-status')
local lspconfig  = require('lspconfig')
lsp_status.register_progress()

lspconfig.solargraph.setup({
    on_attach = lsp_status.on_attach,
    capabilities = lsp_status.capabilities
  })

lspconfig.vimls.setup({
    on_attach    = lsp_status.on_attach,
    capabilities = lsp_status.capabilities
  })

lsp_status.config({
    kind_labels        = {},
    indicator_errors   = '',
    indicator_warnings = '',
    indicator_info     = '🛈',
    indicator_hint     = '❗',
    indicator_ok       = '',
    spinner_frames     = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' },
    status_symbol      = '𝓵',
    select_symbol      = nil
  })
