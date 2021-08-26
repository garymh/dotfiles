local M = {
  "machakann/vim-sandwich",
  init = function()
    vim.g.sandwich_no_default_key_mappings = 1
    vim.g.textobj_sandwich_no_default_key_mappings = 1
  end,
  enabled = false,
}

function M.config()
  vim.g.sandwich_quotes = {
    {
      buns = { '"', '"' },
      quoteescape = 1,
      expand_range = 0,
      nesting = 0,
      linewise = 0,
    },
    {
      buns = { "'", "'" },
      quoteescape = 1,
      expand_range = 0,
      nesting = 0,
      linewise = 0,
    },
    {
      buns = { "`", "`" },
      quoteescape = 1,
      expand_range = 0,
      nesting = 0,
      linewise = 0,
    },
  }

  vim.g.sandwich_braces = {
    { buns = { "(", ")" }, nesting = 1 },
    { buns = { "[", "]" }, nesting = 1 },
    { buns = { "{ ", " }" }, nesting = 1 },
    { buns = { "{", "}" }, nesting = 1 },
    { buns = { "<", ">" }, nesting = 1 },
  }

  vim.g.sandwich = {
    recipes = {
      external = {
        "ii",
        "ai",
        "iq",
        "aq",
        "ij",
        "aj",
        "ib",
        "ab",
        "il",
        "al",
      },
    },
  }

  s_omap("ij", "textobj#sandwich#auto('o', 'i', {}, g:sandwich_braces)", { expr = true }, "Inside braces")
  s_vmap("ij", "textobj#sandwich#auto('o', 'i', {}, g:sandwich_braces)", { expr = true }, "Inside braces")
  s_omap("aj", "textobj#sandwich#auto('o', 'a', {}, g:sandwich_braces)", { expr = true }, "Outside braces")
  s_vmap("aj", "textobj#sandwich#auto('o', 'a', {}, g:sandwich_braces)", { expr = true }, "Outside braces")
  s_omap("iq", "textobj#sandwich#auto('o', 'i', {}, g:sandwich_quotes)", { expr = true }, "Inside quotes")
  s_vmap("iq", "textobj#sandwich#auto('o', 'i', {}, g:sandwich_quotes)", { expr = true }, "Inside quotes")
  s_omap("aq", "textobj#sandwich#auto('o', 'a', {}, g:sandwich_quotes)", { expr = true }, "Outside quotes")
  s_vmap("aq", "textobj#sandwich#auto('o', 'a', {}, g:sandwich_quotes)", { expr = true }, "Outside quotes")

  vim.g.lua_braces = {
    { buns = { "[[", "]]" }, nesting = 1 },
  }
  s_omap("iL", "textobj#sandwich#auto('o', 'i', {}, g:lua_braces)", { expr = true }, "in Lua [[strings]]")
  s_vmap("iL", "textobj#sandwich#auto('o', 'i', {}, g:lua_braces)", { expr = true }, "in Lua [[strings]]")
  s_omap("aL", "textobj#sandwich#auto('o', 'i', {}, g:lua_braces)", { expr = true }, "in Lua [[strings]]")
  s_vmap("aL", "textobj#sandwich#auto('o', 'i', {}, g:lua_braces)", { expr = true }, "in Lua [[strings]]")

  s_nmap("sa", "<Plug>(sandwich-add)", {}, "sandwich add")
  s_vmap("sa", "<Plug>(sandwich-add)", {}, "sandwich add")
  s_omap("sa", "<Plug>(sandwich-add)", {}, "sandwich add")

  s_nmap("sd", "<Plug>(sandwich-delete)", {}, "sandwich delete")
  s_vmap("sd", "<Plug>(sandwich-delete)", {}, "sandwich delete")
  s_nmap("sdb", "<Plug>(sandwich-delete-auto)", {}, "sandwich delete (auto)")

  s_nmap("sr", "<Plug>(sandwich-replace)", {}, "sandwich replace")
  s_vmap("sr", "<Plug>(sandwich-replace)", {}, "sandwich replace")
  s_nmap("srb", "<Plug>(sandwich-replace-auto)", {}, "sandwich replace (auto)")

  s_omap("ib", "<Plug>(textobj-sandwich-auto-i)", {}, "sandwich auto text object?")
  s_vmap("ib", "<Plug>(textobj-sandwich-auto-i)", {}, "sandwich auto text object?")
  s_omap("ab", "<Plug>(textobj-sandwich-auto-a)", {}, "sandwich auto text object?")
  s_vmap("ab", "<Plug>(textobj-sandwich-auto-a)", {}, "sandwich auto text object?")

  -- s_omap("is", "<Plug>(textobj-sandwich-query-i)", {}, "")
  -- s_vmap("is", "<Plug>(textobj-sandwich-query-i)", {}, "")
  -- s_omap("as", "<Plug>(textobj-sandwich-query-a)", {}, "")
  -- s_vmap("as", "<Plug>(textobj-sandwich-query-a)", {}, "")
end

return M
