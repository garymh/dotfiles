return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc" },
  single_file_support = true,
  settings = {
    Lua = {
      doc = {
        privateName = { "^_" },
      },
      hint = {
        enable     = true,
        setType    = false,
        paramType  = true,
        paramName  = "Disable",
        semicolon  = "Disable",
        arrayIndex = "Disable",
      },
      format = {
        enable = true,
        -- defaultConfig = {
        --   indent_style = "space",
        --   indent_size = "2",
        -- }
      },
      diagnostics = {
        globals = {
          "Augroup",
          "Nv10",
          "Nv9",
          "User",
          "cmap",
          "icons",
          "nmap",
          "nxmap",
          "omap",
          "s_cmap",
          "s_imap",
          "s_map",
          "s_nmap",
          "s_omap",
          "s_oxmap",
          "s_tmap",
          "s_vmap",
          "s_xmap",
          "tools",
          "vim",
          "vmap",
          "xmap",
        },
        disable = { "missing-parameters", "missing-fields" }

      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          '${3rd}/luv/library',
        },
      },
      codeLens = {
        enable = true,
      },
      completion = {
        callSnippet = "Replace",
      },
    },
    runtime = {
      version = "LuaJIT",
    },
  }
}
