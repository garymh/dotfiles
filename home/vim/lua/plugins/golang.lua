return {
  {
    "ray-x/go.nvim",
    dependencies = { "ray-x/guihua.lua" },
    enabled = true,
    ft = "go",
    config = function()
      require("go").setup({
        lsp_gofumpt = false,
        gofmt = "golines",

        usePlaceholders = true,
        -- gofumpt = true,
        -- staticcheck = true,
        -- analyses = {
        --   unusedparams = true,
        -- },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },

        max_line_len = 120,
        lsp_cfg = {
          settings = {
            gopls = {
              completeUnimported = true,
              analyses = {
                appends = true,
                asmdecl = true,
                assign = true,
                atomic = true,
                bools = true,
                buildtag = true,
                cgocall = true,
                composite = true,
                copylock = true,
                defers = true,
                directive = true,
                errorsas = true,
                framepointer = true,
                httpresponse = true,
                ifaceassert = true,
                loopclosure = true,
                lostcancel = true,
                modernize = true,
                nilfunc = true,
                printf = true,
                shift = true,
                sigchanyzer = true,
                slog = true,
                stdmethods = true,
                stdversion = true,
                stringintconv = true,
                structtag = true,
                testinggoroutine = true,
                tests = true,
                timeformat = true,
                ST1005 = false,
                unmarshal = true,
                unreachable = true,
                unsafeptr = true,
                unusedparams = true,
                unusedresult = true,
                unusedvariable = true,
              },
              staticcheck = true,
            },
            handlers = {},
          },
        },
        lsp_keymaps = false,
        lsp_codelens = true,
        lsp_document_formatting = false,
        lsp_inlay_hints = {
          enable = false,
        },
        diagnostic = {
          underline = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = "▌",
              [vim.diagnostic.severity.WARN] = "▌",
              [vim.diagnostic.severity.HINT] = "▌",
              [vim.diagnostic.severity.INFO] = "▌",
            },
            numhl = {
              [vim.diagnostic.severity.ERROR] = "DiagnosticError",
              [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
              [vim.diagnostic.severity.HINT] = "DiagnosticHint",
              [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
            },
            texthl = {
              [vim.diagnostic.severity.ERROR] = "DiagnosticError",
              [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
              [vim.diagnostic.severity.HINT] = "DiagnosticHint",
              [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
            },
            severity = { min = vim.diagnostic.severity.WARN },
          },
          float = {
            border = "rounded",
            severity = { min = vim.diagnostic.severity.WARN },
          },
          severity_sort = true,
          virtual_text = false,
          update_in_insert = false,
        },
      })

      vim.b.disable_go_tests_stderr = false

      s_nmap("<localleader>gi", vim.cmd.GoIfErr, {}, "GO: make an if err")
      s_nmap("<localleader>i", vim.cmd.GoIfErr, "Go IfErr")
      s_nmap("<leader>tt", function()
        -- if vim.b.disable_go_tests_stderr == true then
        -- 	vim.cmd([[GoTestFunc -F]])
        -- else
        vim.cmd([[GoTestFunc -v -F]])
        -- end
      end, "Test nearest")
      s_nmap("<leader>tp", "<CMD>GoTestPkg -v -F --fail-fast --shuffle=on<CR>", "Test package")
      s_nmap("<leader>T", "<CMD>GoTestFile -v -F --fail-fast --shuffle=on<CR>", "Test file")
      s_nmap("<localleader>c", function()
        require("go.comment").gen()
      end, "Function comment")

      s_nmap("<leader>ts", "<CMD>GoTestFunc -s -F -v<CR>", "Test visit")
      s_nmap("grR", "<CMD>GoRename<CR>", "GoRename")
    end,
  },
}

-- vim.cmd("autocmd FileType go nmap <Leader>gc :lua require('go.comment').gen()")
