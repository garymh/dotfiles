-- workspace globals live in .luarc.json (single source of truth): the file configures
-- any client, the settings sent here cover Lua files opened outside the repo too.
local function repo_globals()
  local ok, luarc = pcall(function()
    return vim.json.decode(table.concat(vim.fn.readfile(D .. "/.luarc.json"), "\n"))
  end)
  return ok and luarc["diagnostics.globals"] or nil
end

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
        globals = repo_globals(),
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
