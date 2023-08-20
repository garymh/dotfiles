local M = {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-go",
    "olimorris/neotest-rspec",
  },
}

function M.config()
  local neotest = require("neotest")
  require("neotest").setup({
    discovery = {
      enabled = false
    },
    quickfix = {
      enabled = true,
      open = false
    },
    adapters = {
      require("neotest-rspec"),
    },
  })

  s_nmap("<leader>ta", function() neotest.run.attach() end, {}, "attach")
  s_nmap("<leader>tt", function() neotest.run.run() end, {}, "Run nearest test")
  s_nmap("<leader>ts", function() neotest.summary.toggle() end, {}, "summary")

  -- -- Keymaps
  -- local m = require("mapx").setup { global = "force", whichkey = true }
  -- m.nname("<leader>r", "Test")
  -- m.nnoremap("<leader>rd", function() neotest.run.run({ strategy = "dap" }) end, { silent = true },
  --   "Debug the nearest test")
  -- m.nnoremap("<leader>rT", function() neotest.run.run(vim.fn.expand("%")) end, { silent = true }, "Run the current file")
  -- m.nnoremap("<leader>rr", neotest.summary.open, { silent = true }, "Open test summary")
  -- m.nnoremap("<leader>rb",
  --   ":Dispatch bin/rspec $(git diff --name-only --diff-filter=AM master | grep 'spec/')<CR>",
  --   { silent = true, ft = "ruby" },
  --   "Run MR tests")
end

return M
