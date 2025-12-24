---@type vim.lsp.Config
return {
  capabilities = {
    textDocument = {
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      },
    },
  },
  settings = {
    yaml = {
      keyOrdering = false,
      format = {
        enable = true,
      },
      validate = true,
    },
  },
}
