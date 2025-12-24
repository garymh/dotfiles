local M = {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  dependencies = { "neovim/nvim-lspconfig" },
  keys = {
    {
      "!",
      function()
        require("conform").format({
          async = true,
          undojoin = true,
        }, function(err)
          if not err then
            local mode = vim.api.nvim_get_mode().mode
            if vim.startswith(string.lower(mode), "v") then
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
            end
          end
        end)
      end,
      mode = "",
      desc = "Format buffer",
    },
  },

  opts = {},
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}

function M.config()
  local conform = require("conform")

  conform.setup({
    formatters_by_ft = {
      lua = { lsp_format = "prefer" },
      go = { "gofumpt", "goimports", lsp_format = "fallback" },
      json = { "jq" },
      javascript = { "prettier" },
      yaml = { "yamlfmt" },
      sh = { "shfmt" },
      zsh = { "shfmt" },
      ruby = { "rubocop" },
      ["_"] = { "trim_newlines", "trim_whitespace", "squeeze_blanks" },
    },
    default_format_opts = {
      lsp_format = "fallback",
      undojoin = true,
    },
    format_after_save = function(bufnr)
      local ignore_filetypes = {
        "sql",
        "java",
      }
      if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
        return
      end

      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      local bufname = vim.api.nvim_buf_get_name(bufnr)
      if bufname:match("/node_modules/") then
        return
      end
      return {
        timeout_ms = 2500,
        undojoin = true,
        async = true,
        -- lsp_format = "first",
      }
    end,
    formatters = {
      shfmt = { prepend_args = { "-i", "2" } },
    },
  })

  vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
      vim.b.disable_autoformat = true
    else
      vim.g.disable_autoformat = true
    end
  end, {
    desc = "Disable autoformat-on-save",
    bang = true,
  })

  vim.api.nvim_create_user_command("FormatEnable", function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
  end, {
    desc = "Re-enable autoformat-on-save",
  })

  vim.api.nvim_create_user_command("Format", function(args)
    local range = nil
    if args.count ~= -1 then
      local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
      range = {
        start = {
          args.line1,
          0,
        },
        ["end"] = {
          args.line2,
          end_line:len(),
        },
      }
    end
    conform.format({
      async = true,
      undojoin = true,
      lsp_format = "fallback",
      range = range,
    })
  end, {
    range = true,
  })
end

return M
