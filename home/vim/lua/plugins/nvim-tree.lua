local M = {
  "nvim-tree/nvim-tree.lua",
  -- cmd = { "NvimTreeOpen", "NvimTreeToggle", "NvimTreeFindFile" },
  -- keys = { "<space>a" }
}

function M.config()
  require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
      width = 30,
    },
    renderer = {
      group_empty = true,
    },
    -- disable_netrw  = true,
    -- hijack_netrw   = true,
    -- open_on_tab    = false,
    -- select_prompts = true,
    -- hijack_cursor  = true,
    -- update_cwd     = false,
    -- diagnostics = {
    --   enable = false,
    --   icons = {
    --     hint    = "",
    --     info    = "",
    --     warning = "",
    --     error   = "",
    --   },
    -- },
    -- update_focused_file = {
    --   enable      = true,
    --   update_cwd  = true,
    --   ignore_list = {},
    -- },
    -- system_open = {
    --   cmd  = nil,
    --   args = {},
    -- },
    -- filters = {
    --   dotfiles = false,
    --   custom   = {},
    -- },
    -- view = {
    --   adaptive_size    = true,
    --   hide_root_folder = false,
    --   side             = "left",
    --   mappings         = {
    --     custom_only = false,
    --     list        = {},
    --   },
    -- },
  }, {})

  s_nmap("<space>a", vim.cmd.NvimTreeToggle, {}, "nvim Tree")
end

--
return M
