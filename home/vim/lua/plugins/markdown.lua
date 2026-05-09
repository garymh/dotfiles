return {
  {
    "OXY2DEV/markview.nvim",
    lazy = false, -- Recommended

    -- dependencies = { "nvim-treesitter/nvim-treesitter" },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
    config = function()
      local presets = require("markview.presets").headings;

      require("markview").setup({
        preview = {
          enable = false,
          callbacks = {
            on_disable = function (_, _) end,
          },
        },
        markdown = {
          headings = presets.simple,
          horizontal_rules = presets.thick,
          tables = presets.rounded,

        },
        experimental = {
          check_rtp_message = false,
        },


      });
      require("markview.extras.headings").setup();
      require("markview.extras.editor").setup();
      require("markview.extras.checkboxes").setup({})
    end
  },

  -- idk if i need any of this
  {
    "tadmccorkle/markdown.nvim",
    enabled = false,
    ft = "markdown",
    event = "VeryLazy",
    opts = {
      mappings = {
        inline_surround_toggle = "gs",       -- (string|boolean) toggle inline style
        inline_surround_toggle_line = "gss", -- (string|boolean) line-wise toggle inline style
        inline_surround_delete = false,      -- (string|boolean) delete emphasis surrounding cursor
        inline_surround_change = false,      -- (string|boolean) change emphasis surrounding cursor
        link_add = "ysl",                    -- (string|boolean) add link
        link_follow = false,                 -- (string|boolean) follow link
        go_curr_heading = "]c",              -- (string|boolean) set cursor to current section heading
        go_parent_heading = "]p",            -- (string|boolean) set cursor to parent section heading
        go_next_heading = "]]",              -- (string|boolean) set cursor to next section heading
        go_prev_heading = "[[",              -- (string|boolean) set cursor to previous section heading
      },
    },
  },
}
