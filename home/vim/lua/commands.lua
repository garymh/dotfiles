local function load_dotfile(path)
  return function()
    vim.cmd("e " .. D .. path)
  end
end

local function newPluginFile()
  vim.ui.input({ prompt = "Plugin name? " }, function(input)
    vim.cmd("e " .. D .. "/home/vim/lua/config/" .. input .. ".lua")
  end)
end

function toggleEol()
  if vim.opt.listchars:get()["eol"] then
    vim.opt.listchars:remove("eol")
  else
    vim.opt.listchars:append({ eol = "¬" })
  end
end

s_nmap("yoe", function() toggleEol() end, {}, "Toggle line endings")
-- eol      = "¬",

vim.api.nvim_create_user_command("NewConfig", newPluginFile, {})

vim.api.nvim_create_user_command("Eauto", load_dotfile("/home/vim/lua/autocommands.lua"), {})
vim.api.nvim_create_user_command("Ecommands", load_dotfile("/home/vim/lua/commands.lua"), {})
vim.api.nvim_create_user_command("Esnippets", load_dotfile("/home/vim/lua/config/snippets.lua"), {})
vim.api.nvim_create_user_command("Ewhich", load_dotfile("/home/vim/lua/plugins/whichkey.lua"), {})
vim.api.nvim_create_user_command("Elsp", load_dotfile("/home/vim/lua/config/lspconfig.lua"), {})
vim.api.nvim_create_user_command("Emap", load_dotfile("/home/vim/lua/mappings.lua"), {})
vim.api.nvim_create_user_command("Eplugin", load_dotfile("/home/vim/lua/plugins/misc.lua"), {})
vim.api.nvim_create_user_command("Ecomp", load_dotfile("/home/vim/lua/config/cmp.lua"), {})
vim.api.nvim_create_user_command("Ecmp", load_dotfile("/home/vim/lua/config/cmp.lua"), {})
vim.api.nvim_create_user_command("Efunction", load_dotfile("/home/zsh/commands.sh"), {})
vim.api.nvim_create_user_command("Eprivate", load_dotfile("/home/zsh/private/private.zsh"), {})
vim.api.nvim_create_user_command("Ealiases", load_dotfile("/home/zsh/commands.sh"), {})
vim.api.nvim_create_user_command("Etmux", load_dotfile("/home/tmux.conf"), {})
vim.api.nvim_create_user_command("Ezshrc", load_dotfile("/home/zshrc"), {})
vim.api.nvim_create_user_command("Ezshenv", load_dotfile("/home/zshenv"), {})
vim.api.nvim_create_user_command("Egit", load_dotfile("/home/gitconfig"), {})
vim.api.nvim_create_user_command("Ekitty", load_dotfile("/home/kitty/kitty.conf"), {})

vim.api.nvim_create_user_command("Bugs", load_dotfile("/home/vim/vim_bugs.md"), {})

local function removeDoubleLines()
  vim.api.nvim_command([[%s/\s\+$//e]])
  vim.api.nvim_command([[%s/\n\{3,}/\r\r/e]])
end

vim.api.nvim_create_user_command("RemoveDoubleLines", removeDoubleLines, {})

local function filetypeLoader(type)
  return function()
    local file = vim.fn.expand("%")
    if file ~= "" then
      local filetype = require("plenary.filetype").detect(file, {})
      vim.cmd("e " .. D .. "/home/vim/" .. type .. "/" .. filetype .. ".vim")
    else
      print("You don't have an open file!")
    end
  end
end

vim.api.nvim_create_user_command("FileTypeDetect", filetypeLoader("ftdetect"), {})
vim.api.nvim_create_user_command("FileTypePlugin", filetypeLoader("ftplugin"), {})

NvimVsource([[lua/kitty_navigator.vim]])

s_nmap("<C-left>",  "<CMD>KittyNavigateLeft<CR>",  {}, "Kitty navigate")
s_nmap("<C-right>", "<CMD>KittyNavigateRight<CR>", {}, "Kitty navigate")
s_nmap("<C-up>",    "<CMD>KittyNavigateUp<CR>",    {}, "Kitty navigate")
s_nmap("<C-down>",  "<CMD>KittyNavigateDown<CR>",  {}, "Kitty navigate")
s_nmap("<C-8>",     "<CMD>KittyNavigatePrev<CR>",  {}, "Kitty navigate")
s_nmap("<C-9>",     "<CMD>KittyNavigateNext<CR>",  {}, "Kitty navigate")

function Google(pat, lucky)
  local fn = vim.fn
  local query = '"' .. fn.substitute(pat, '["\n]', " ", "g") .. '"'
  query = fn.substitute(query, "[[:punct:] ]", [[\=printf("%%%02X", char2nr(submatch(0)))]], "g")
  fn.system(fn.printf("open" .. ' "https://%s%s"', lucky and "duckduckgo.com/?q=%5C+" or "www.google.com/search?q=",
    query))
end

-- https://vi.stackexchange.com/questions/31206
function FlashCursorline()
  local cursorline_state = lua
  print(vim.opt.cursorline:get())
  vim.opt.cursorline = true
  vim.cmd([[hi CursorLine guifg=#FFFFFF guibg=#FF9509]])
  vim.fn.timer_start(200, function()
    vim.cmd([[hi CursorLine guifg=NONE guibg=NONE]])
    if cursorline_state == false then
      vim.opt.cursorline = false
    end
  end)
end

function BracketMotion(motion, count)
  local bracket = ""
  local direction = ""
  local commands = ""

  if motion == "down" then
    bracket   = "}"
    direction = "j"
    commands  = "Wn"
  else
    bracket   = "{"
    direction = "k"
    commands  = "Wnb"
  end

  if vim.fn.foldclosed("search('^$', " .. commands .. ")") then
    vim.fn.execute("keepjumps norm! " .. count .. bracket .. "zz")
  else
    vim.fn.execute("keepjumps norm! " .. count .. bracket .. direction .. bracket .. "zz")
  end
end

vim.api.nvim_create_user_command("Q",  "quit<bang>", { bang = true, nargs = 0 })
vim.api.nvim_create_user_command("QA", "qa<bang>",   { bang = true, nargs = 0 })
vim.api.nvim_create_user_command("Qa", "qa<bang>",   { bang = true, nargs = 0 })
vim.api.nvim_create_user_command("WA", "wa<bang>",   { bang = true, nargs = 0 })
vim.api.nvim_create_user_command("Wa", "wa<bang>",   { bang = true, nargs = 0 })
vim.api.nvim_create_user_command("XA", "xa<bang>",   { bang = true, nargs = 0 })
vim.api.nvim_create_user_command("Xa", "xa<bang>",   { bang = true, nargs = 0 })
vim.api.nvim_create_user_command("W",  "<line1>, <line2>w<bang> <args>",  { complete = "file", nargs = "*", range="%" })
vim.api.nvim_create_user_command("WQ", "<line1>, <line2>wq<bang> <args>", { complete = "file", nargs = "*", range="%" })
vim.api.nvim_create_user_command("Wq", "<line1>, <line2>wq<bang> <args>", { complete = "file", nargs = "*", range="%" })
vim.api.nvim_create_user_command("WQA", "wqa <args>", { nargs = "*" })
vim.api.nvim_create_user_command("WQa", "wqa <args>", { nargs = "*" })
vim.api.nvim_create_user_command("Wqa", "wqa <args>", { nargs = "*" })
vim.api.nvim_create_user_command("Vsp", "vsp <args>", { nargs = "*" })
