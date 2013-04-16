-- require'nvim-treesitter.configs'.setup {
--   ensure_installed = "all",
--   highlight = {
--     enable = true,
--   },
--   -- navigation = {
--   --   enable = true,
--   --   keymaps = {
--   --     goto_definition = "gnd",
--   --     list_definitions = "gnD",
--   --   },
--   -- },
-- }

vim.lsp.callbacks['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.callbacks['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.callbacks['textDocument/definition'] = require'lsputil.locations'.definition_handler
vim.lsp.callbacks['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
vim.lsp.callbacks['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.callbacks['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.callbacks['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.callbacks['workspace/symbol'] = require'lsputil.symbols'.workspace_handler

local lsp_status = require('lsp-status')
 lsp_status.register_progress()
 local nvim_lsp = require('nvim_lsp')

 nvim_lsp.solargraph.setup({
  on_attach = lsp_status.on_attach,
  capabilities = lsp_status.capabilities
 })

 nvim_lsp.vimls.setup({
  on_attach = lsp_status.on_attach,
  capabilities = lsp_status.capabilities
 })
