local M = {
  "vim-test/vim-test",
  enabled = true,
  ft = "ruby",
}

-- local M = {
--   "nvim-neotest/neotest",
--   dependencies = {
--     "nvim-neotest/nvim-nio",
--     "nvim-lua/plenary.nvim",
--     "akinsho/neotest-go",
--     "nvim-treesitter/nvim-treesitter"
--     -- "antoinemadec/FixCursorHold.nvim",
--   }
-- }

function M.config()
  -- local neotest_ns = vim.api.nvim_create_namespace("neotest")
  --
  -- vim.diagnostic.config({
  --   virtual_text = {
  --     format = function(diagnostic)
  --       local message =
  --           diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
  --       return message
  --     end,
  --   },
  -- }, neotest_ns)
  --
  -- require("neotest").setup({
  --   -- your neotest config here
  --   adapters = {
  --     require("neotest-go")({
  --       experimental = {
  --         test_table = true,
  --       },
  --       recursive_run = true,
  --       args = { "-count=1", "-timeout=60s" }
  --     })
  --   },
  -- })


  -- s_nmap("<leader>t", "<CMD>TestNearest -fullpath -failfast -shuffle on -v<CR>", "Test nearest")
  -- s_nmap("<leader>l", "<CMD>TestLast -fullpath -failfast -shuffle on<CR>",    "Test last")
  -- s_nmap("<leader>v", "<CMD>TestVisit -fullpath -failfast -shuffle on<CR>",   "Test visit")
  -- s_nmap("<leader>T", "<CMD>TestFile -fullpath -failfast -shuffle on<CR>",    "Test file")
  s_nmap("<leader>t", "<CMD>TestNearest --fail-fast<CR>", "Test nearest")
  s_nmap("<leader>l", "<CMD>TestLast --fail-fast<CR>", "Test last")
  s_nmap("<leader>v", "<CMD>TestVisit --fail-fast<CR>", "Test visit")
  s_nmap("<leader>T", "<CMD>TestFile --fail-fast<CR>", "Test file")

  -- vim.api.nvim_set_var("test#strategy", "neovim_sticky")
  -- vim.api.nvim_set_var("test#strategy", "neovim")

  -- local neotest = require("neotest")
  -- require("neotest").setup({
  --   discovery = {
  --     enabled = false
  --   },
  --   quickfix = {
  --     enabled = true,
  --     open = false
  --   },
  --   adapters = {
  --     require("neotest-rspec"),
  --   },
  -- })
  -- s_nmap( "<leader>T", function() require("neotest").run.run(vim.fn.expand("%")) end, {}, "Run File" )
  -- s_nmap( "<leader>sa", function() require("neotest").run.run(vim.loop.cwd()) end,     {}, "Run All Test Files" )
  -- s_nmap( "<leader>t", function() require("neotest").run.run() end,                   {}, "Run Nearest" )
  -- s_nmap( "<leader>st", function() require("neotest").summary.toggle() end,            {}, "Toggle Summary" )
  -- s_nmap( "<leader>so", function() require("neotest").output_panel.toggle() end,       {}, "Toggle Output Panel" )
  -- s_nmap( "<leader>sS", function() require("neotest").run.stop() end,                  {}, "Stop" )
  --
  -- s_nmap( "<leader>so", function() require("neotest").output.open({ enter = true, auto_close = true }) end, {}, "Show Output" )
  --
  -- s_nmap("<leader>ta", function() neotest.run.attach({ interactive = true }) end, {}, "attach")
  -- s_nmap("<leader>tt", function() neotest.run.run() end, {}, "Run nearest test")
  -- s_nmap("<leader>tl", function() neotest.run.run_last() end, {}, "run last test")
  -- s_nmap("<leader>T",
  --   function()
  --     neotest.run.run()
  --     neotest.run.attach({ interactive = true })
  --   end, {}, "Run and attach nearest test")
  -- s_nmap("<leader>ts", function() neotest.summary.toggle() end, {}, "summary")
  --
  -- -- nnoremap <silent>[n <cmd>lua require("neotest").jump.prev({ status = "failed" })<CR>
  -- -- nnoremap <silent>]n <cmd>lua require("neotest").jump.next({ status = "failed" })<CR>
  -- -- -- Keymaps
  -- -- local m = require("mapx").setup { global = "force", whichkey = true }
  -- -- m.nname("<leader>r", "Test")
  -- -- m.nnoremap("<leader>rd", function() neotest.run.run({ strategy = "dap" }) end, { silent = true },
  -- --   "Debug the nearest test")
  -- -- m.nnoremap("<leader>rT", function() neotest.run.run(vim.fn.expand("%")) end, { silent = true }, "Run the current file")
  -- -- m.nnoremap("<leader>rr", neotest.summary.open, { silent = true }, "Open test summary")
  -- -- m.nnoremap("<leader>rb",
  -- --   ":Dispatch bin/rspec $(git diff --name-only --diff-filter=AM master | grep 'spec/')<CR>",
  -- --   { silent = true, ft = "ruby" },
  -- --   "Run MR tests")
end

return M
