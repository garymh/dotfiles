local dotfile_commands = {
  Eauto     = "/home/vim/lua/autocommands.lua",
  Ecommands = "/home/vim/lua/commands.lua",
  Ewhich    = "/home/vim/lua/plugins/whichkey.lua",
  Emap      = "/home/vim/lua/mappings.lua",
  Eplugin   = "/home/vim/lua/plugins/misc.lua",
  Efunction = "/home/zsh/commands.sh",
  Eprivate  = "/home/zsh/private/private.zsh",
  Ealiases  = "/home/zsh/commands.sh",
  Etmux     = "/home/tmux.conf",
  Ezshrc    = "/home/zshrc",
  Ezshenv   = "/home/zshenv",
  Egit      = "/home/gitconfig",
  Ewez      = "/home/wezterm.lua",
  Eghost    = "/home/ghostty",
  Bugs      = "/home/vim/vim_bugs.md",
}

for cmd, path in pairs(dotfile_commands) do
  User(cmd, function() vim.cmd.edit(D .. path) end, {})
end

local function filetype_loader(type)
  return function()
    local file = vim.fn.expand("%")
    if file ~= "" then
      local filetype = require("plenary.filetype").detect(file, {})
      vim.cmd.edit(D .. "/home/vim/" .. type .. "/" .. filetype .. ".lua")
    else
      print("You don't have an open file!")
    end
  end
end

User("FileTypeDetect", filetype_loader("ftdetect"), {})
User("FileTypePlugin", filetype_loader("ftplugin"), {})

-- Google search function (used by operators)
function Google(pat, lucky)
  local fn = vim.fn
  local query = '"' .. fn.substitute(pat, '["\n]', " ", "g") .. '"'
  query = fn.substitute(query, "[[:punct:] ]", [[\=printf("%%%02X", char2nr(submatch(0)))]], "g")
  local url = lucky and "duckduckgo.com/?q=%5C+" or "www.google.com/search?q="
  fn.system(fn.printf("open 'https://%s%s'", url, query))
end

-- Bracket motion helper
function BracketMotion(motion, count)
  local bracket, direction, commands
  if motion == "down" then
    bracket, direction, commands = "}", "j", "Wn"
  else
    bracket, direction, commands = "{", "k", "Wnb"
  end

  if vim.fn.foldclosed("search('^$', " .. commands .. ")") then
    vim.fn.execute("keepjumps norm! " .. count .. bracket .. "zz")
  else
    vim.fn.execute("keepjumps norm! " .. count .. bracket .. direction .. bracket .. "zz")
  end
end

local typo_commands = {
  { "Q",   "quit<bang>",                      { bang = true, nargs = 0 } },
  { "QA",  "qa<bang>",                        { bang = true, nargs = 0 } },
  { "Qa",  "qa<bang>",                        { bang = true, nargs = 0 } },
  { "WA",  "wa<bang>",                        { bang = true, nargs = 0 } },
  { "Wa",  "wa<bang>",                        { bang = true, nargs = 0 } },
  { "XA",  "xa<bang>",                        { bang = true, nargs = 0 } },
  { "Xa",  "xa<bang>",                        { bang = true, nargs = 0 } },
  { "W",   "<line1>, <line2>w<bang> <args>",  { complete = "file", nargs = "*", range = "%" } },
  { "WQ",  "<line1>, <line2>wq<bang> <args>", { complete = "file", nargs = "*", range = "%" } },
  { "Wq",  "<line1>, <line2>wq<bang> <args>", { complete = "file", nargs = "*", range = "%" } },
  { "WQA", "wqa <args>",                      { nargs = "*" } },
  { "WQa", "wqa <args>",                      { nargs = "*" } },
  { "Wqa", "wqa <args>",                      { nargs = "*" } },
  { "Vsp", "vsp <args>",                      { nargs = "*" } },
}

for _, cmd in ipairs(typo_commands) do
  User(cmd[1], cmd[2], cmd[3])
end

if Nv12() then
  User("LspInfo", "checkhealth vim.lsp", {
    desc = "Show LSP Info",
  })

  User("LspLog", function(_)
    local state_path = vim.fn.stdpath("state")
    local log_path = vim.fs.joinpath(state_path, "lsp.log")

    vim.cmd(string.format("edit %s", log_path))
  end, {
    desc = "Show LSP log",
  })

  User("LspRestart", "lsp restart", {
    desc = "Restart LSP",
  })
end

function _G.___gdc(motion)
  local srow, erow

  if motion == nil then
    srow = vim.fn.line('.')
    erow = srow
  elseif motion:match('[vV\x16]') then
    srow = vim.fn.line("'<")
    erow = vim.fn.line("'>")
  else
    srow = vim.fn.line("'[")
    erow = vim.fn.line("']")
  end

  local lines = vim.api.nvim_buf_get_lines(0, srow - 1, erow, false)
  vim.api.nvim_buf_set_lines(0, erow, erow, false, lines)

  vim.cmd('undojoin')
  vim.cmd('normal ' .. srow .. 'GV' .. erow .. 'Ggc')

  local new_row = erow + 1
  local line = vim.api.nvim_buf_get_lines(0, new_row - 1, new_row, false)[1]
  local _, len = string.find(line or "", "^%s*")
  vim.api.nvim_win_set_cursor(0, { new_row, len or 0 })
end

s_vmap("gy", "<ESC><CMD>lua ___gdc(vim.fn.visualmode())<CR>", "Comment out original and paste copy")
s_nmap("gy", "<CMD>set operatorfunc=v:lua.___gdc<CR>g@", "Comment out original and paste copy")
s_nmap("gyy", function() ___gdc(nil) end, "Comment out line and paste copy")
