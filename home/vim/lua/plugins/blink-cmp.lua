Snacks = _G.Snacks

return {
  "saghen/blink.cmp",
  version = '1.*',
  opts = {
    keymap = { preset = "super-tab" },

    cmdline = {
      keymap = { ['<Tab>'] = { 'show', 'accept' }, },
      completion = {
        ghost_text = {
          enabled = true,
        },
        menu = {
          auto_show = function(ctx)
            return vim.fn.getcmdtype() == ':'
          end,
        }
      },
    },

    signature = {
      enabled = true,
      window = { show_documentation = false },
    },

    fuzzy = {
      sorts = {
        'exact',
        'score',
        'sort_text',
      },
    },

    completion = {
      list = { selection = { preselect = false, auto_insert = true } },
      ghost_text = {
        enabled = true,
        show_without_selection = true,
      },

      menu = {
        draw = {
          padding = { 2, 2 },
          columns = { { "kind_icon", "label", gap = 2 }, { "source_name" } },
          treesitter = { "lsp" },
          components = {
            label = {
              text = function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require("colorful-menu").blink_components_highlight(ctx)
              end,
            },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      }
    },

    sources = {
      per_filetype = {
        lua = { inherit_defaults = true, "lazydev" },
      },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },
  },

  opts_extend = {
    "sources.completion.enabled_providers",
    "sources.compat",
    "sources.default"
  },

  dependencies = {
    {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    { "xzbdmw/colorful-menu.nvim" },
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
    },
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" }, },
          { path = "LazyVim",            words = { "LazyVim" } },
          "lazy.nvim",
        },
      },
    },
  },
}
