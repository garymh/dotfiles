local M = {
  "rgroli/other.nvim",
  event = "VeryLazy",
}

  -- {
  --   "tpope/vim-projectionist",
  --   config = function()
  --     s_nmap("<leader>e", function()
  --       if string.match(vim.fn.expand('%'), "ee/") then
  --         vim.cmd.Ece()
  --       else
  --         vim.cmd.Eee()
  --       end
  --     end, {}, "toggle between CE and EE")
  --   end,
  -- },

function M.config()
  require("other-nvim").setup({
    rememberBuffers = false,
    mappings = {
      "rails",
      "golang",
      {
        pattern = "/path/to/file/src/app/(.*)/.*.ext$",
        target = "/path/to/file/src/view/%1/",
        transformer = "lowercase"
      },

      {
        pattern = "config/initializers/(.*).rb",
        target = "spec/initializers/%1_spec.rb",
        context = "test"
      },

      {
        pattern = "spec/initializers/(.*)_spec.rb",
        target = "config/initializers/%1.rb",
        context = "test"
      },
      {
        pattern = "app/channels/(.*).rb",
        target = "ee/app/channels/ee/%1.rb",
        context = "EE"
      },
      {
        pattern = "app/components/(.*).rb",
        target = "ee/app/components/ee/%1.rb",
        context = "EE"
      },
      {
        pattern = "app/controllers/(.*).rb",
        target = "ee/app/controllers/ee/%1.rb",
        context = "EE"
      },
      {
        pattern = "app/enums/(.*).rb",
        target = "ee/app/enums/ee/%1.rb",
        context = "EE"
      },
      {
        pattern = "app/events/(.*).rb",
        target = "ee/app/events/ee/%1.rb",
        context = "EE"
      },
      {
        pattern = "app/experiments/(.*).rb",
        target = "ee/app/experiments/ee/%1.rb",
        context = "EE"
      },
      {
        pattern = "app/finders/(.*).rb",
        target = "ee/app/finders/ee/%1.rb",
        context = "EE"
      },
      {
        pattern = "app/graphql/(.*).rb",
        target = "ee/app/graphql/ee/%1.rb",
        context = "EE"
      },
      {
        pattern = "app/helpers/(.*).rb",
        target = "ee/app/helpers/ee/%1.rb",
        context = "EE"
      },
      {
        pattern = "app/mailers/(.*).rb",
        target = "ee/app/mailers/ee/%1.rb",
        context = "EE"
      },
      {
        pattern = "app/models/(.*).rb",
        target = "ee/app/models/ee/%1.rb",
        context = "EE"
      },
      {
        pattern = "app/policies/(.*).rb",
        target = "ee/app/policies/ee/%1.rb",
        context = "EE"
      },
      {
        pattern = "app/presenters/(.*).rb",
        target = "spec/app/presenters/%1_spec.rb",
        context = "test"
      },
      {
        pattern = "app/presenters/(.*).rb",
        target = "ee/app/presenters/ee/%1.rb",
        context = "EE"
      },

      {
        pattern = "app/serializers/(.*).rb",
        target = "spec/app/serializers/%1_spec.rb",
        context = "test"
      },
      {
        pattern = "app/serializers/(.*).rb",
        target = "ee/app/serializers/ee/%1.rb",
        context = "EE"
      },

      {
        pattern = "app/services/(.*).rb",
        target = "spec/app/services/%1_spec.rb",
        context = "source"
      },
      {
        pattern = "app/services/(.*).rb",
        target = "ee/app/services/ee/%1.rb",
        context = "source"
      },

      {
        pattern = "app/uploaders/(.*).rb",
        target = "ee/app/uploaders/ee/%1.rb",
        context = "EE"
      },
      {
        pattern = "app/uploaders/(.*).rb",
        target = "spec/app/uploaders/%1_spec.rb",
        context = "test"
      },
      {
        pattern = "app/validators/(.*).rb",
        target = "ee/app/validators/ee/%1.rb",
        context = "EE"
      },
      {
        pattern = "app/validators/(.*).rb",
        target = "spec/app/validators/%1_spec.rb",
        context = "test"
      },
      {
        pattern = "app/views/(.*).rb",
        target = "ee/app/views/ee/%1.rb",
        context = "EE"
      },
      {
        pattern = "app/views/(.*).rb",
        target = "spec/app/views/%1_spec.rb",
        context = "EE"
      },
      {
        pattern = "app/workers/(.*).rb",
        target = "ee/app/workers/ee/%1.rb",
        context = "EE"
      },
      {
        pattern = "app/workers/(.*).rb",
        target = "spec/app/workers/%1_spec.rb",
        context = "test"
      },
      {
        pattern = "spec/(.*)_spec.rb",
        target = "app/%1.rb",
        context = "source"
      },
      {
        pattern = "lib/(.*).rb",
        target = "spec/lib/%1_spec.rb",
        context = "test"
      },
      {
        pattern = "spec/lib/(.*)_spec.rb",
        target = "lib/%1.rb",
        context = "source"
      },
      {
        pattern = "lib/api/(.*).rb",
        target = "spec/requests/api/%1_spec.rb",
        context = "test"
      },
      {
        pattern = "spec/requests/api/(.*)_spec.rb",
        target = "lib/api/%1.rb",
        context = "source"
      },
      {
        pattern = "rubocop/cop/(.*).rb",
        target = "spec/rubocop/cop/%1_spec.rb",
        context = "test"
      },
      {
        pattern = "spec/rubocop/cop/(.*)_spec.rb",
        target = "rubocop/cop/%1.rb",
        context = "source"
      },
      {
        pattern = "ee/lib/api/(.*).rb",
        target = "ee/spec/requests/api/%1_spec.rb",
        context = "test"
      },
      {
        pattern = "ee/spec/requests/api/(.*)_spec.rb",
        target = "ee/lib/api/%1.rb",
        context = "source"
      },
      {
        pattern = "ee/app/controllers/ee/(.*).rb",
        target = "app/controllers/%1.rb",
        context = "CE"
      },
      {
        pattern = "ee/app/controllers/ee/(.*).rb",
        target = "ee/spec/%1_spec.rb",
        context = "test"
      },

      {
        pattern = "ee/app/finders/ee/(.*).rb",
        target = "app/finders/%1.rb",
        context = "CE"
      },
      {
        pattern = "ee/app/finders/ee/(.*).rb",
        target = "ee/spec/%1_spec.rb",
        context = "test"
      },
      {
        pattern = "ee/app/graphql/ee/(.*).rb",
        target = "app/graphql/%1.rb",
        context = "CE"
      },
      {
        pattern = "ee/app/graphql/ee/(.*).rb",
        target = "ee/spec/%1_spec.rb",
        context = "test"
      },
      {
        pattern = "ee/app/helpers/ee/(.*).rb",
        target = "app/helpers/%1.rb",
        context = "CE"
      },
      {
        pattern = "ee/app/helpers/ee/(.*).rb",
        target = "ee/spec/%1_spec.rb",
        context = "test"
      },
      {
        pattern = "ee/app/mailers/ee/(.*).rb",
        target = "app/mailers/%1.rb",
        context = "CE"
      },
      {
        pattern = "ee/app/mailers/ee/(.*).rb",
        target = "ee/spec/%1_spec.rb",
        context = "test"
      },
      {
        pattern = "ee/app/models/ee/(.*).rb",
        target = "app/models/%1.rb",
        context = "CE"
      },
      {
        pattern = "ee/app/models/ee/(.*).rb",
        target = "ee/spec/%1_spec.rb",
        context = "test"
      },
      {
        pattern = "ee/app/policies/ee/(.*).rb",
        target = "app/policies/%1.rb",
        context = "CE"
      },
      {
        pattern = "ee/app/policies/ee/(.*).rb",
        target = "ee/spec/%1_spec.rb",
        context = "test"
      },
      {
        pattern = "ee/app/presenters/ee/(.*).rb",
        target = "app/presenters/%1.rb",
        context = "CE"
      },
      {
        pattern = "ee/app/presenters/ee/(.*).rb",
        target = "ee/spec/%1_spec.rb",
        context = "test"
      },
      {
        pattern = "ee/app/serializers/ee/(.*).rb",
        target = "app/serializers/%1.rb",
        context = "CE"
      },
      -- {
      --   pattern = "ee/app/serializers/ee/(.*).rb",
      --   target = "spec/app/serializers/%1_spec.rb",
      --   context = "source"
      -- },
      -- {
      --   pattern = "ee/app/services/ee/(.*).rb",
      --   target = "app/services/%1.rb",
      --   context = "CE"
      -- },
      -- {
      --   pattern = "ee/app/services/ee/(.*).rb",
      --   target = "spec/app/services/%1_spec.rb",
      --   context = "source"
      -- },
      {
        pattern = "ee/app/uploaders/ee/(.*).rb",
        target = "app/uploaders/%1.rb",
        context = "CE"
      },
      -- {
      --   pattern = "ee/app/uploaders/ee/(.*).rb",
      --   target = "spec/app/uploaders/%1_spec.rb",
      --   context = "source"
      -- },
      {
        pattern = "ee/app/validators/ee/(.*).rb",
        target = "app/validators/%1.rb",
        context = "CE"
      },
      -- {
      --   pattern = "ee/app/validators/ee/(.*).rb",
      --   target = "spec/app/validators/%1_spec.rb",
      --   context = "source"
      -- },
      {
        pattern = "ee/app/views/ee/(.*).rb",
        target = "app/views/%1.rb",
        context = "CE"
      },
      -- {
      --   pattern = "ee/app/views/ee/(.*).rb",
      --   target = "spec/app/views/%1_spec.rb",
      --   context = "source"
      -- },
      {
        pattern = "ee/app/workers/ee/(.*).rb",
        target = "app/workers/%1.rb",
        context = "CE"
      },
      -- {
      --   pattern = "ee/app/workers/ee/(.*).rb",
      --   target = "spec/app/workers/%1_spec.rb",
      --   context = "source"
      -- },
      {
        pattern = "ee/app/(.*).rb",
        target = "app/%1.rb",
        context = "CE"
      },
      {
        pattern = "ee/app/(.*).rb",
        target = "ee/spec/%1_spec.rb",
        context = "test"
      },
      {
        pattern = "ee/spec/(.*)_spec.rb",
        target = "ee/app/%1.rb",
        context = "source"
      },
      {
        pattern = "ee/lib/(.*).rb",
        target = "ee/spec/lib/%1_spec.rb",
        context = "test"
      },
      {
        pattern = "ee/lib/ee/(.*).rb",
        target = "lib/%1.rb",
        context = "CE"
      },
      {
        pattern = "ee/lib/ee/(.*).rb",
        target = "ee/spec/lib/%1_spec.rb",
        context = "test"
      },
      {
        pattern = "ee/spec/lib/(.*)_spec.rb",
        target = "ee/lib/%1.rb",
        context = "source"
      },

      {
        pattern = "zshrc",
        target = "zshenv",
        context = "alternate"
      },
      {
        pattern = "zshenv",
        target = "zshrc",
        context = "alternate"
      },
    },

    style = {
      newFileIndicator = "*",
      border = "single",
      width = 1.0,
    },
  })

  s_nmap("<leader><leader>", vim.cmd.Other, {}, "alternate files")
end

return M
