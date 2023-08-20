local M = {
  "hrsh7th/nvim-cmp",
  version = false,
  -- event = "InsertEnter, CmdlineEnter",
  -- TODO: cmp needs to load in the command line but isn't
  dependencies = {
    'L3MON4D3/LuaSnip',
    'onsails/lspkind.nvim',
    'rafamadriz/friendly-snippets',
    'saadparwaiz1/cmp_luasnip',
    'petertriho/cmp-git',

    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-emoji',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',

    'nvim-lua/plenary.nvim',
  },
}

local function only_one_entry(cmp)
  local entries = cmp.get_entries()

  local count = 0
  for _ in pairs(entries) do
    count = count + 1
  end

  return count == 1
end

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
    cmp.confirm({ select = true })
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

    --  menu	    Use a popup menu to show the possible completions.  The
    --    menu is only shown when there is more than one match and
    --    sufficient colors are available.  |ins-completion-menu|
    --
    --  menuone  Use the popup menu also when there is only one match.
    --    Useful when there is additional information about the
    --    match, e.g., what file it comes from.
    --
    --  longest  Only insert the longest common text of the matches.  If
    --    the menu is displayed you can use CTRL-L to add more
    --    characters.  Whether case is ignored depends on the kind
    --    of completion.  For buffer text the 'ignorecase' option is
    --    used.
    --
    --  preview  Show extra information about the currently selected
    --    completion in the preview window.  Only works in
    --    combination with "menu" or "menuone".
    --
    -- noinsert  Do not insert any text for a match until the user selects
    --    a match from the menu. Only works in combination with
    --    "menu" or "menuone". No effect if "longest" is present.
    --
    -- noselect  Do not select a match in the menu, force the user to
    --    select one from the menu. Only works in combination with
    --    "menu" or "menuone".
    --

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
    history             = true,
    enable_autosnippets = true,
    updateevents        = "TextChanged,TextChangedI",
    region_check_events = "InsertEnter",
    delete_check_events = "TextChanged,InsertEnter",
    ext_opts            = {
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
      { name = "luasnip" },
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

  cmp.setup.cmdline({ '/', '?' }, {
    completion = {
      completeopt = "menu,menuone,noselect",
    },
    mapping = {
      ["<tab>"] = {
        c = function()
          if cmp.visible() then
            if only_one_entry(cmp) then
              cmp.select_next_item()
              cmp.confirm()
            else
              cmp.select_next_item()
            end
          end
        end
      },
    },
    sources = {
      { name = 'buffer' }
    }
  })

  cmp.setup.cmdline(':', {
    completion = {
      completeopt = "menu,menuone,noselect",
    },
    mapping = {
      ["<tab>"] = {
        c = function()
          if cmp.visible() then
            if only_one_entry(cmp) then
              cmp.select_next_item()
              cmp.confirm()
            else
              cmp.select_next_item()
            end
          end
        end
      }
    },
    sources = cmp.config.sources({
      { name = 'cmdline' },
      { name = 'path' }
    })
  })

  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/snippets/"})

end

return M
