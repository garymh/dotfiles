return {
  "mason-org/mason.nvim",
  dependencies = {
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "neovim/nvim-lspconfig",
    "yorickpeterse/nvim-dd",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")
    local diag = vim.diagnostic

    diag.config({
      signs = {
        text = {
          [diag.severity.ERROR] = tools.ui.icons["diagnostic"],
          [diag.severity.WARN] = tools.ui.icons["diagnostic"],
          [diag.severity.HINT] = tools.ui.icons["diagnostic"],
          [diag.severity.INFO] = tools.ui.icons["diagnostic"],
        },
      },
      severity_sort = true,
      underline = true,
      update_in_insert = false,
      virtual_lines = false,
      virtual_text = {
        current_line = true,
      },
      float = {
        header = "diagnostics:",
        border = "rounded",
        -- source = true,
      },
    })

    -- vim.api.nvim_create_autocmd("CursorHold", {
    --   callback = function()
    --     diag.open_float(nil, { focusable = false, source = "if_many" })
    --     fasdkfljasldkf
    --   end,
    -- })

    s_nmap("gK", function()
      local new_config = not diag.config().virtual_lines
      diag.config({ virtual_lines = new_config })
    end, "Toggle diagnostic virtual_lines")
    s_nmap("<localleader>e", diag.open_float, "[LSP] line diagnostics")
    s_nmap("]!", function()
      diag.jump({ float = true, count = 1 })
    end, "Next diagnostic issue")
    s_nmap("[!", function()
      diag.jump({ float = true, count = -1 })
    end, "Previous diagnostic issue")

    s_xmap('<A-o>', function()
      vim.lsp.buf.selection_range(1)
    end, "vim.lsp.buf.selection_range('outer')")

    s_xmap('<A-i>', function()
      vim.lsp.buf.selection_range(-1)
    end, "vim.lsp.buf.selection_range('inner')")

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function()
        if _G.Snacks ~= nil then
          Snacks.toggle.inlay_hints():map("yot")
          Snacks.toggle.diagnostics():map("yod")
        end

        -- "grn" is mapped in Normal mode to vim.lsp.buf.rename()
        -- "gra" is mapped in Normal and Visual mode to vim.lsp.buf.code_action()
        -- "grr" is mapped in Normal mode to vim.lsp.buf.references()
        -- "gri" is mapped in Normal mode to vim.lsp.buf.implementation()
        -- "gO" is mapped in Normal mode to vim.lsp.buf.document_symbol()

        s_nmap("grD", vim.lsp.buf.declaration, "LSP: Go to declaration")
        s_nmap("grt", vim.lsp.buf.type_definition, "LSP: Go to type definition")
      end,
    })

    vim.api.nvim_create_autocmd("ModeChanged", {
      pattern = { "n:i", "v:s" },
      desc = "Disable diagnostics in insert and select mode",
      callback = function(e)
        diag.enable(false, { bufnr = e.buf })
      end,
    })

    vim.api.nvim_create_autocmd("ModeChanged", {
      pattern = "i:n",
      desc = "Enable diagnostics when leaving insert mode",
      callback = function(e)
        diag.enable(true, { bufnr = e.buf })
      end,
    })

    require("dd").setup({ timeout = 2000 })

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      handlers = {
        function(server_name)
          vim.lsp.enable(server_name)
        end,
      },
    })

    mason_tool_installer.setup({
      auto_update = true,
      ensure_installed = {
        "fixjson",
        "gofumpt",
        "goimports",
        "goimports-reviser",
        "golangci-lint",
        "golines",
        "gomodifytags",
        "gopls",
        "gotests",
        "htmlbeautifier",
        "jq",
        "json-to-struct",
        "lua-language-server",
        "luacheck",
        "prettier",
        "shellcheck",
        "shfmt",
        "staticcheck",
        -- 'stylua',
        "vim-language-server",
        "yamlfix",
      },
    })
  end,
}
