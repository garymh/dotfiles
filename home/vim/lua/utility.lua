Home = os.getenv("HOME")
D    = os.getenv("DOTFILES") or Home .. "/code/dotfiles"
GL   = os.getenv("GITLAB_HOME") or Home .. "/code/work/gdk/gitlab"

P = function(v)
  print(vim.inspect(v))
  return v
end

-- Apply this to everything?
--     defaults = {
--       borderchars = { "█", " ", "▀", "█", "█", " ", " ", "▀" },
--     }
--

function Notifier(text)
  -- local ok, ntfy = pcall(require, "notify")
  -- if not ok then
  --   vim.notify(text)
  -- else
  -- end
  -- ntfy.setup()
  -- if not old_print then
  --   old_print = _G.print
  -- end
  vim.notify(text)
end

function Dump(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(unpack(objects))
end

VimModes = { "n", "v", "x", "i", "c", "o", "t" }

local bad_description = "I need a description, please fill me in"
for _, mode in pairs(VimModes) do
  _G[mode .. "map"] = function(name, cmd, options, desc, notifier)
    if type(options) == nil then
      options = {}
    elseif type(options) == "string" then
      desc = options
      options = {}
    end
    desc = desc or bad_description

    vim.keymap.set(mode, name, cmd, vim.tbl_extend("force", options or {}, { desc = desc }))
  end
  _G["s_" .. mode .. "map"] = function(name, cmd, options, desc, notifier)
    if type(options) == nil then
      options = {}
    elseif type(options) == "string" then
      desc = options
      options = {}
    end

    desc = desc or bad_description
    if desc == bad_description then
      if string.find(name, "<leader") or string.find(name, "<localleader") or string.find(name, "<space") or string.find(name, "g") or string.find(name, "[", nil, true) or string.find(name, "]", nil, true) then
        vim.notify("needs desc: " .. mode .. ", name:" .. name)
      end
    end

    if notifier and type(cmd) == "string" then
      cmd = cmd .. "<cmd>lua Notifier(\"" .. notifier .. "\")<cr>"
    end

    vim.keymap.set(mode, name, cmd, vim.tbl_extend("force", options or {}, { desc = desc, silent = true }))
  end
end

function NvimVsource(file)
  vim.cmd([[source ]] .. D .. [[/home/vim/]] .. file)
end

local function shell_error()
  return vim.v.shell_error ~= 0
end

local function git_cwd(cmd, cwd)
  if not cwd then
    return cmd
  end
  cwd = vim.fn.expand(cwd)
  local arg_cwd = ("-C %s "):format(vim.fn.shellescape(cwd))
  cmd = cmd:gsub("^git ", "git " .. arg_cwd)
  return cmd
end

local function git_root(cwd, noerr)
  local cmd = git_cwd("git rev-parse --show-toplevel", cwd)
  local output = vim.fn.systemlist(cmd)
  if shell_error() then
    if not noerr then
      Notifier(unpack(output))
    end
    return nil
  end
  return output[1]
end

function SetCwd(pwd)
  if not pwd then
    local parent = vim.fn.expand("%:h")
    pwd = git_root(parent, true) or parent
  else
    pwd = vim.fn.expand(pwd)
  end
  if vim.loop.fs_stat(pwd) then
    vim.cmd("cd " .. pwd)
    Notifier(("pwd set to %s"):format(vim.fn.shellescape(pwd)))
  else
    Notifier(("Unable to set pwd to %s, directory is not accessible"):format(vim.fn.shellescape(pwd)))
  end
end
