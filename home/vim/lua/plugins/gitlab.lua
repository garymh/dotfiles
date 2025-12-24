-- local M = {
--   "git@gitlab.com:gitlab-org/editor-extensions/gitlab.vim.git",
--   -- dependencies = {
--   --   "harrisoncramer/gitlab.nvim",
--   --   "rcarriga/nvim-notify",
--   --   "MunifTanjim/nui.nvim",
--   --   "nvim-lua/plenary.nvim",
--   -- },
--   enabled = false,
--   event   = { "BufReadPre", "BufNewFile" },
--   ft      = { "go", "javascript", "python", "ruby" },
--   cond    = function()
--     return vim.env.GITLAB_TOKEN ~= nil and vim.env.GITLAB_TOKEN ~= ""
--   end,
--   opts    = {
--     minimal_message_level = 4,
--     statusline = {
--       enabled = false,
--     },
--   },
-- }
--
-- --     build = function()
-- --       require("gitlab.server").build(true)
-- --     end, -- Builds the Go binary
-- --     config = function()
-- --       require("gitlab").setup({
-- --         reviewer = "delta", -- The reviewer type (only delta is currently supported)
-- --         review_pane = { -- Specific settings for different reviewers
-- --           delta = {
-- --             added_file = "", -- The symbol to show next to added files
-- --             modified_file = "", -- The symbol to show next to modified files
-- --             removed_file = "", -- The symbol to show next to removed files
-- --           },
-- --         },
-- --         keymaps = {
-- --           popup = {                      -- The popup for comment creation, editing, and replying
-- --             exit = "Q",
-- --             perform_action = "<localleader>g", -- Once in normal mode, does action (like saving comment or editing description, etc)
-- --           },
-- --           discussion_tree = {            -- The discussion tree that holds all comments
-- --             jump_to_location = "o",      -- Jump to comment location in file
-- --             edit_comment = "e",          -- Edit coment
-- --             delete_comment = "dd",       -- Delete comment
-- --             reply_to_comment = "r",      -- Reply to comment
-- --             toggle_resolved = "p",       -- Toggles the resolved status of the discussion
-- --             toggle_node = "t",           -- Opens or closes the discussion
-- --             position = "left",           -- "top", "right", "bottom" or "left"
-- --             relative = "editor",         -- Position of tree split relative to "editor" or "window"
-- --             size = "20%",                -- Size of split
-- --           },
-- --           dialogue = {                   -- The confirmation dialogue for deleting comments
-- --             focus_next = { "j", "<Down>", "<Tab>" },
-- --             focus_prev = { "k", "<Up>", "<S-Tab>" },
-- --             close = { "<Esc>", "<C-c>" },
-- --             submit = { "<CR>", "<Space>" },
-- --           },
-- --         },
-- --       })
-- --     end,
-- --   },
-- --
-- -- }
--
-- function M.config() end
--
-- return M

local M = {
  "harrisoncramer/gitlab.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "stevearc/dressing.nvim"
  },
  enabled = true,
  -- disabled until i find a way to ignore warnings from noice
  build = function()
    require("gitlab.server").build(true)
  end, -- Builds the Go binary
  config = function()
    require("gitlab").setup()
  end,
}
-- function M.config() end

return M
