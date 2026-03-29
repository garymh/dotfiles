return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason.nvim",
      { "mason-org/mason-lspconfig.nvim", config = function() end },
    },
    opts = function()
      local diag = vim.diagnostic
      local ret = {
        diagnostics = {
          signs = {
            text = {
              [diag.severity.ERROR] = tools.ui.icons["diagnostic"],
              [diag.severity.WARN]  = tools.ui.icons["diagnostic"],
              [diag.severity.HINT]  = tools.ui.icons["diagnostic"],
              [diag.severity.INFO]  = tools.ui.icons["diagnostic"],
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
          },
        },
        codelens = {
          enabled = false
        },
        folds = {
          enabled = true,
        },
        format = {
          formatting_options = nil,
          timeout_ms = nil,
        },
        servers = {
          ["*"] = {
            capabilities = {
              workspace = {
                fileOperations = {
                  didRename = true,
                  willRename = true,
                },
              },
            },
          },

          stylua = { enabled = false },
          lua_ls = {
            settings = {
              Lua = {
                workspace = {
                  checkThirdParty = false,
                },
                codeLens = {
                  enable = true,
                },
                completion = {
                  callSnippet = "Replace",
                },
                doc = {
                  privateName = { "^_" },
                },
                hint = {
                  enable = true,
                  setType = false,
                  paramType = true,
                  paramName = "Disable",
                  semicolon = "Disable",
                  arrayIndex = "Disable",
                },
              },
            },
          },
        },
        setup = {
          -- example to setup with typescript.nvim
          -- tsserver = function(_, opts)
          --   require("typescript").setup({ server = opts })
          --   return true
          -- end,
          -- Specify * to use this function as a fallback for any server
          -- ["*"] = function(server, opts) end,
        },
      }
      return ret
    end,

    config = vim.schedule_wrap(function(_, opts)
      local diag = vim.diagnostic

      s_nmap("gK", function()
        local new_config = not diag.config().virtual_lines
        diag.config({ virtual_lines = new_config })
      end, "Toggle diagnostic virtual_lines")
      s_nmap("<localleader>e", diag.open_float, "[LSP] line diagnostics")
      s_nmap("]!", function() diag.jump({ float = true, count = 1 }) end, "Next diagnostic issue")
      s_nmap("[!", function() diag.jump({ float = true, count = -1 }) end, "Previous diagnostic issue")

      s_xmap('<A-o>', function()
        vim.lsp.buf.selection_range(1)
      end, "vim.lsp.buf.selection_range('outer')")

      s_xmap('<A-i>', function()
        vim.lsp.buf.selection_range(-1)
      end, "vim.lsp.buf.selection_range('inner')")

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

      if opts.folds.enabled then
        Snacks.util.lsp.on({ method = "textDocument/foldingRange" }, function()
          vim.api.nvim_set_option_value("foldmethod", "expr", { scope = "local" })
          vim.api.nvim_set_option_value("foldexpr", "v:lua.vim.lsp.foldexpr()", { scope = "local" })
        end)
      end

      if opts.codelens.enabled and vim.lsp.codelens then
        Snacks.util.lsp.on({ method = "textDocument/codeLens" }, function(buffer)
          vim.lsp.codelens.refresh()
          vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
            buffer = buffer,
            callback = vim.lsp.codelens.refresh,
          })
        end)
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      if opts.capabilities then
        opts.servers["*"] = vim.tbl_deep_extend("force", opts.servers["*"] or {}, {
          capabilities = opts.capabilities,
        })
      end

      if opts.servers["*"] then
        vim.lsp.config("*", opts.servers["*"])
      end

      local have_mason = has("mason-lspconfig.nvim")
      local mason_all = have_mason
          and vim.tbl_keys(require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package)
          or {} --[[ @as string[] ]]
      local mason_exclude = {} ---@type string[]

      ---@return boolean? exclude automatic setup
      local function configure(server)
        if server == "*" then
          return false
        end
        local sopts = opts.servers[server]
        sopts = sopts == true and {} or (not sopts) and { enabled = false } or sopts

        if sopts.enabled == false then
          mason_exclude[#mason_exclude + 1] = server
          return
        end

        local use_mason = sopts.mason ~= false and vim.tbl_contains(mason_all, server)
        local setup = opts.setup[server] or opts.setup["*"]
        if setup and setup(server, sopts) then
          mason_exclude[#mason_exclude + 1] = server
        else
          vim.lsp.config(server, sopts) -- configure the server
          if not use_mason then
            vim.lsp.enable(server)
          end
        end
        return use_mason
      end

      local install = vim.tbl_filter(configure, vim.tbl_keys(opts.servers))
      if have_mason then
        require("mason-lspconfig").setup({
          -- stuff
          ensure_installed = vim.list_extend(install, {}),
          automatic_enable = { exclude = mason_exclude },
        })
      end
    end),
  },

  {

    "mason-org/mason.nvim",
    cmd = "Mason",
    keys = { { "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },
}
