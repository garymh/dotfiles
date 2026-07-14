local M = {
  "andrewferrier/debugprint.nvim",
  keys = {
    "g?p", "g?P", "g?v", "g?V", "g?o", "g?O", "g?c", "g?d",
    { "<C-G>p", mode = "i" },
    { "<C-G>v", mode = "i" },
    { "g?v", mode = "x" },
    { "g?V", mode = "x" },
  },
  cmd = { "ToggleCommentDebugPrints", "DeleteDebugPrints" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
}

function M.config()
  local counter = 0

  local counter_func = function()
    counter = counter + 1

    local table = { "🤞", "👻", "💣", "🐭", "💩", "🫠", "🤡", "👻", "🤮", "💅", "🤪", "🙃" }
    local rand = math.random(1, #table)

    return "[" .. tostring(counter) .. table[rand] .. "]"
  end

  local opts = {
    display_counter = counter_func,
    highlight_lines = true,
    keymaps = {
      normal = {
        plain_below                 = "g?p",
        plain_above                 = "g?P",
        variable_below              = "g?v",
        variable_above              = "g?V",
        variable_below_alwaysprompt = nil,
        variable_above_alwaysprompt = nil,
        textobj_below               = "g?o",
        textobj_above               = "g?O",
        toggle_comment_debug_prints = "g?c",
        delete_debug_prints         = "g?d",
      },
      insert = {
        plain    = "<C-G>p",
        variable = "<C-G>v",
      },
      visual = {
        variable_below = "g?v",
        variable_above = "g?V",
      },
    },
    commands = {
      toggle_comment_debug_prints = "ToggleCommentDebugPrints",
      delete_debug_prints         = "DeleteDebugPrints",
    },
  }

  require("debugprint").setup(opts)

  s_nmap(
    "<localleader>pc",
    "<CMD>g/binding.irb/norm gcc<CR>",
    {},
    "Toggle commenting in all prys",
    "Toggling commenting in all prys"
  )
  s_nmap("<localleader>pd", "<CMD>g/binding.irb/d<CR>", {}, "Delete all prys", "Deleting all prys")
  s_nmap("<localleader>pp", "Obinding.irb<ESC>j0", {}, "Add a irb", "Adding a irb")
end

return M
