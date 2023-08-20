local M = {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "leoluz/nvim-dap-go",
  },
  enabled = true,
  -- keys = { "<F1>", "<F2>", "<F3>", "<F4>" },
}

function M.config()
  local ok, dap = pcall(require, "dap")
  if not ok then
    return
  end

  local dapgo = require("dap-go")
  dapgo.setup()

  nmap("<F1>", dap.step_into)
  nmap("<F2>", dap.step_over)
  nmap("<F3>", dap.continue)
  nmap("<F4>", dap.step_out)
  nmap("<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
  nmap("<leader>dr", dap.repl.open)
  nmap("<leader>dt", require("dap-go").debug_test)

  -- require("nvim-dap-virtual-text").setup({})
  -- require("dapui").setup({})

  local dapui = require("dapui")
  dapui.setup()
  -- require("nvim-dap-virtual-text").setup()
  -- local dapui = require("dapui")

  vim.fn.sign_define("DapBreakpoint", { text = "✋", texthl = "", linehl = "", numhl = "" })

  local function conditionalBreakpoint()
    if vim.bo.filetype == "ruby" then
      vim.fn.execute("normal! Obinding.pry")
      return vim.fn.execute("normal! j0")
    else
      return dap.toggle_breakpoint()
    end
  end

  local function conditionalSuperBreakpoint()
    if vim.bo.filetype == "ruby" then
      vim.fn.execute("normal! Obinding.pry_shell")
      return vim.fn.execute("normal! j0")
    else
      return dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end
  end

  s_nmap("<m-p>", conditionalBreakpoint, {}, "yo")
  s_nmap("<m-o>", conditionalSuperBreakpoint, {}, "yo")

  -- local dap, dapui = dap, require("dapui")
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
end

return M
