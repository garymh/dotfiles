local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "jayp0521/mason-null-ls.nvim",
    "ray-x/lsp_signature.nvim",
    "jose-elias-alvarez/null-ls.nvim",
    "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
    "yorickpeterse/nvim-dd",
    {
      "glepnir/lspsaga.nvim",
      opt = true,
      event = "LspAttach",
      requires = {
        { "nvim-tree/nvim-web-devicons" },
        { "nvim-treesitter/nvim-treesitter" },
      },
    },
  },
}

function M.config()
  require("mason").setup()
  require("mason-lspconfig").setup({
    -- ensure_installed = { "lua_ls" },
  })
  require("mason-null-ls").setup({
    -- ensure_installed = {},
    automatic_installation = true,
    automatic_setup = true,
    handlers = {},
  })
  require('dd').setup({
    -- The time to wait before displaying newly produced diagnostics.
    timeout = 2000
  })

  local lspconfig = require("lspconfig")

  local lua_globals = { "vim", "hs", "Util" }

  for _, mode in pairs(VimModes) do
    table.insert(lua_globals, mode .. "map")
    table.insert(lua_globals, "s_" .. mode .. "map")
  end

  local signs = {
    Error = "● ",
    Warn = "● ",
    Hint = "● ",
    Info = "● ",
  }

  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = false,
    float = {
      border = "rounded",
    },
  })

  local null_ls = require("null-ls")
  local actions = null_ls.builtins.code_actions
  local diags   = null_ls.builtins.diagnostics
  local format  = null_ls.builtins.formatting

  null_ls.setup({
    border = "rounded",
    save_after_format = false,
    should_attach = function()
      -- haml files in canonical keep throwing a json error
      return not vim.bo.filetype == "haml"
    end,
    sources = {
      actions.gitsigns,
      actions.shellcheck,
      diags.gitlint,
      diags.tidy,
      diags.vale,
      diags.zsh,
      diags.haml_lint,
      format.shfmt,
      format.trim_whitespace,
      format.fixjson,
      format.gofmt,
      format.rubocop,
      format.stylua,
    },
  })

  local servers = {
    "gopls",   -- Golang
    "html",    -- HTML
    "jsonls",  -- JSON
    "bashls",  -- Bash
    "clojure_lsp",
    "ruby_ls", -- ruby
    "vimls",   -- Vimscript
    "lua_ls",  -- Lua
    -- "clangd", - doesnt work with QMK
    -- "solargraph",
  }


  local lsp_flags = {
    debounce_text_changes = 150,
    allow_incremental_sync = true,
  }

  for _, server in ipairs(servers) do
    local settings = nil

    if server == "gopls" then
      settings = {
        gopls = {
          semanticTokens = true,

          experimentalPostfixCompletions = true,
          analyses = {
            unusedparams = true,
            shadow = true,
          },
          staticcheck = true,
        },
      }
      Init_options = {
        usePlaceholders = true,
      }
    end

    if server == "clojure_lsp" then
      settings = {
        trace = {
          server = "verbose",
        },
      }
    end

    if server == "lua_ls" then
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = lua_globals,
          },
          hint = { enable = true },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          -- does this even work?
          format = {
            enable = true,
            defaultConfig = {
              indent_style = "space",
              indent_size = "8",
            },
          },
          telemetry = {
            enable = false,
          },
        },
      }
    end
    lspconfig[server].setup({
      flags = lsp_flags,
      capabilities = vim.lsp.protocol.make_client_capabilities(),
      settings = settings,
      init_options == Init_options or {}
    })

    lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, {
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
    })


    require('toggle_lsp_diagnostics').init()
  end

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      local buffer = ev.buf
      local saga = require("lspsaga")

      -- start ruby LSP hack
      if client.name == "ruby_ls" then
        local diagnostic_handler = function()
          local params = vim.lsp.util.make_text_document_params(buffer)

          client.request(
            'textDocument/diagnostic',
            { textDocument = params },
            function(err, result)
              if err then
                local err_msg = string.format("ruby-lsp - diagnostics error - %s", vim.inspect(err))
                vim.lsp.log.error(err_msg)
              end
              if not result then return end

              vim.lsp.diagnostic.on_publish_diagnostics(
                nil,
                vim.tbl_extend('keep', params, { diagnostics = result.items }),
                { client_id = client.id }
              )
            end
          )
        end

        diagnostic_handler() -- to request diagnostics when attaching the client to the buffer

        local ruby_group = vim.api.nvim_create_augroup('ruby_ls', { clear = false })
        vim.api.nvim_create_autocmd(
          { 'BufEnter', 'BufWritePre', 'InsertLeave', 'TextChanged' },
          {
            buffer = buffer,
            callback = diagnostic_handler,
            group = ruby_group,
          }
        )
      end
      -- end lsp hack

      saga.setup({
        lightbulb = {
          enable = false,
        },
        code_action = {
          keys = {
            quit = "<ESC>",
          },
        },
        finder = {
          keys = {
            expand_or_jump = "<CR>",
          },
        },
        symbol_in_winbar = {
          in_custom = true,
          enable = true,
          separator = "> ",
          show_file = false,
          click_support = false,
        },
      })

      require("lsp_signature").setup({
        bind = true,
        hint_enable = true,
        handler_opts = {
          border = "rounded",
        },
      })

      vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

      s_nmap("<localleader>d", vim.cmd.ToggleDiag, {}, "[LSP] toggle diagnostics")
      s_nmap("<localleader>ca", "<CMD>Lspsaga code_action<CR>", {}, "[LSP] code actions")
      s_vmap("<localleader>ca", "<CMD>Lspsaga code_action<CR>", {}, "[LSP] code actions")
      s_nmap("<localleader>e", "<CMD>Lspsaga show_line_diagnostics<CR>", {}, "[LSP] line diagnostics")
      s_vmap("<localleader>e", "<CMD>Lspsaga show_line_diagnostics<CR>", {}, "[LSP] line diagnostics")

      s_nmap("K", "<CMD>Lspsaga hover_doc<CR>", {})

      s_nmap("gd", "<CMD>Lspsaga goto_definition<CR>", {}, "[LSP] definition")
      s_nmap("gD", vim.lsp.buf.declaration, {}, "[LSP] declaration")
      s_nmap("gT", "<CMD>Lspsaga goto_definition<CR>", {}, "[LSP] type definition")
      s_nmap("gI", vim.lsp.buf.implementation, {}, "[LSP] implementation")
      s_nmap("gh", "<CMD>Lspsaga lsp_finder<CR>", {}, "[LSP] finder (see all)")
      s_nmap("gr", "<CMD>Lspsaga rename<CR>", {}, "[LSP] rename for file")
      s_nmap("gR", "<CMD>Lspsaga rename ++project<CR>", {}, "[LSP] rename for project")

      s_nmap("<space><space>", "<cmd>Lspsaga outline<CR>", {}, "[LSP] outline")
    end,
  })
end

return M
