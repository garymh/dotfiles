local M = {
  "hrsh7th/nvim-cmp",
  version = false,
  event = "InsertEnter",
  dependencies = {
    'hrsh7th/cmp-buffer',
    'L3MON4D3/LuaSnip',
    'onsails/lspkind.nvim',
    "rafamadriz/friendly-snippets",
    "saadparwaiz1/cmp_luasnip",

    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    "petertriho/cmp-git",

    "nvim-lua/plenary.nvim",
    -- -- TODO:     use "amarakon/nvim-cmp-fonts"
  },
}

local function select_next(cmp, fallback)
  if cmp.visible() then
    cmp.select_next_item()
  else
    fallback()
  end
end

local function select_prev(cmp, fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  else
    fallback()
  end
end

local function tab(cmp, ls, fallback)
  if ls.expand_or_locally_jumpable() then
    ls.expand_or_jump()
  elseif cmp.visible() then
    -- P("1")
    -- local entry = cmp.get_selected_entry()
    -- if not entry then
    --   cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
    -- if has_words_before() then
    --   P("2")
    --   cmp.confirm({ select = true })
    -- else
    --   P("3")
    cmp.confirm({ select = true })
    -- end
  else
    fallback()
  end
end

local function shift_tab(cmp, ls, fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  elseif ls.jumpable(-1) then
    if ls.expand_or_locally_jumpable() then
      ls.jump(-1)
    else
      fallback()
    end
  else
    fallback()
  end
end

function M.config()
  vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

  local cmp = require 'cmp'
  local ls = require 'luasnip'
  local lspkind = require 'lspkind'

  cmp.setup({
    mapping = {
      ["<c-n>"] = function(fallback)
        select_next(cmp, fallback)
      end,
      ["<down>"] = function(fallback)
        select_next(cmp, fallback)
      end,
      ["<c-p>"] = function(fallback)
        select_prev(cmp, fallback)
      end,
      ["<up>"] = function(fallback)
        select_prev(cmp, fallback)
      end,
      ["<tab>"] = function(fallback)
        tab(cmp, ls, fallback)
      end,
      ["<S-Tab>"] = cmp.mapping(function(fallback)
          shift_tab(cmp, ls, fallback)
        end,
        { "i", "s" }),
    },

    sources = cmp.config.sources({
      { name = "luasnip" },
      { name = "buffer" },
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "path" },
    }),

    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },

    completion = {
      completeopt = "menu,menuone",
    },

    snippet = {
      expand = function(args)
        ls.lsp_expand(args.body)
      end,
    },

    experimental = {
      ghost_text = {
        hl_group = "CmpGhostText",
      },
    },

    formatting = {
      -- format = lspkind.cmp_format({
      --   mode = 'symbol',
      --   menu = ({
      --     buffer = "buf",
      --     nvim_lsp = "lsp",
      --     luasnip = "snip",
      --     nvim_lua = "lua",
      --   }),
      --   maxwidth = 50,
      --   ellipsis_char = '...',
      -- })
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
        local strings = vim.split(kind.kind, "%s", { trimempty = true })
        kind.kind = " " .. (strings[1] or "") .. " "
        kind.menu = "    (" .. (string.lower(strings[2]) or "") .. ")"

        return kind
      end,
    },
  })


  local types = require("luasnip.util.types")

  ls.config.setup({
    -- history = true,
    -- enable_autosnippets = true,
    updateevents = "TextChanged,TextChangedI",
    region_check_events = "InsertEnter",
    delete_check_events = "TextChanged,InsertEnter",
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { "●", "GitSignsChange" } },
        },
      },
      [types.insertNode] = {
        active = {
          virt_text = { { "●", "GitSignsAdd" } },
        },
      },
    },
  })

  cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
      { name = "git" },
      { name = "buffer" },
    })
  })

  cmp.setup.filetype("markdown", {
    sources = cmp.config.sources({
      { name = "luasnip" },
      { name = "emoji" },
      { name = "buffer" },
    })
  })

  cmp.setup.filetype("lua", {
    sources = cmp.config.sources({
      { name = "luasnip" },
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "buffer" },
    })
  })


  require("luasnip.loaders.from_vscode").lazy_load()

  -- local s = ls.snippet
  -- local f = ls.function_node
  -- local i = ls.insert_node
  -- local extras = require("luasnip.extras")
  --
  -- ls.add_snippets("all", {
  --   s({ trig = "date" }, {
  --     f(function()
  --       return string.format(string.gsub(vim.bo.commentstring, "%%s", " %%s"), os.date())
  --     end, {}),
  --   }),
  --   s({ trig = "modeline" }, {
  --     f(function()
  --       return " " .. string.format(string.gsub(vim.bo.commentstring, "%%s", " %%s"), "vim: ft=")
  --     end, {}),
  --     i(1),
  --   }),
  --   s({ trig = "todo" }, {
  --     f(function()
  --       return " " .. string.format(string.gsub(vim.bo.commentstring, "%%s", " %%s"), "TODO: ")
  --     end, {}),
  --     i(1),
  --   }),
  -- })
end

return M
