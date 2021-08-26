local M = {
  "ruifm/gitlinker.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}

function M.config()
  local job = require("plenary.job")
  local path = require("plenary.path")

  local function gitMain()
    local output
    job
        :new({
          enable_recording = true,
          command = D .. "/home/zsh/bin/git-origin-head",
          cwd = tostring(path:new(vim.api.nvim_buf_get_name(0)):parent()),
          on_exit = function(j)
            output = j:result()
          end,
        })
        :sync()
    return output or {}
  end

  local function gitRev()
    local output
    job
        :new({
          enable_recording = true,
          command = "/opt/homebrew/bin/git",
          args = { "rev-parse", "@{u}" },
          cwd = tostring(path:new(vim.api.nvim_buf_get_name(0)):parent()),
          on_exit = function(j)
            output = j:result()
          end,
        })
        :sync()
    return output or {}
  end

  require("gitlinker").setup({
    opts = {
      remote = nil, -- force the use of a specific remote
      -- adds current line nr in the url for normal mode
      add_current_line_on_normal_mode = true,
      -- callback for what to do with the url
      action_callback = function(url)
        url = string.gsub(url, gitRev()[1], gitMain()[1])
        job:new({ command = "open", args = { url } }):start()
      end,
      -- print the url after performing the action
      print_url = true,
    },
    mappings = "glW",
  })

  s_vmap(
    "glw",
    '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
    {},
    "point to line on GitLab (current)"
  )
  s_nmap(
    "glw",
    '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
    { silent = true },
    "point to line on GitLab (main)"
  )
  s_vmap(
    "glW",
    '<cmd>lua require"gitlinker".get_buf_range_url("v", {})<cr>',
    {},
    "point to line on GitLab (current)"
  )
  s_nmap(
    "glW",
    '<cmd>lua require"gitlinker".get_buf_range_url("n", {})<cr>',
    { silent = true },
    "point to line on GitLab (main)"
  )
  -- https://gitlab.com/gitlab-org/gitlab/-/blob/master/PHILOSOPHY.md
end

return M
