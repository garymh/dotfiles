local noremap = { noremap = true }
local expr    = { expr = true }
local api     = vim.api
local cmd     = vim.cmd

-- Neovim defaults
-- https://docs.google.com/spreadsheets/d/1EJMLr_MPrYiO1TKJ2MjNkR-fA5Wgxa782-f0Wtdpz0w/

s_nmap("dd", function()
  return api.nvim_get_current_line():match("^%s*$") and '"_dd' or "dd"
end, expr, "[smart] delete line")

xmap("/", "<Esc>/\\%V") --search within visual selection

s_xmap('I', function() return vim.fn.mode() == 'V' and '^<C-v>I' or 'I' end, expr, "block insert before")
s_xmap('A', function() return vim.fn.mode() == 'V' and '$<C-v>A' or 'A' end, expr, "block insert after")

s_nmap("zM", "zM:echo &foldlevel<CR>", noremap, "close all folds", "closing all folds")
s_nmap("zR", "zR:echo &foldlevel<CR>", noremap, "open all folds", "opening all folds")
s_nmap("zm", "zm:echo &foldlevel<CR>", noremap, "increase fold level", "increasing fold level")
s_nmap("zr", "zr:echo &foldlevel<CR>", noremap, "reduce fold level", "reducing fold level")

s_imap("<m-w>", "<c-u>")

local function gary_sayonara()
  if vim.bo.filetype == "help" then
    cmd.bd()
  elseif vim.wo.diff then
    cmd("windo diffoff | only")
  elseif api.nvim_win_get_config(0).zindex then
    api.nvim_win_close(0, false)
  else
    cmd.bdelete()
  end
end

s_nmap("J", "mzJ`z:delmarks z<cr>")

s_nmap("Q", gary_sayonara)
s_nmap("<Del>", "ciW")
s_nmap("<C-I>", "<C-I>", noremap)
s_nmap("<s-tab>", "<c-w>w", "next window")
s_nmap("<tab>", "<c-w>W", "previous window")
s_nmap("H", "^")
s_nmap("L", "$")
s_nmap("S", "<CMD>keeppatterns substitute/\\s*\\%#\\s*/\\r/e <bar> normal! ==<CR>")
s_nmap("gp", [['`[' . strpart(getregtype(), 0, 1) . '`]']], expr, "Go to last paste")
s_nmap(
  "gm",
  [[<CMD>silent exec "!$HOME/code/dotfiles/home/zsh/bin/glmr"<CR>]],
  {},
  "go to current GitLab MR",
  "go to current GitLab MR"
)
s_nmap("yp", "<CMD>let @+ = expand('%:p')<CR>", {}, "Filepath", "yanked filepath to clipboard")
s_nmap("{", function() BracketMotion("up", vim.v.count) end)
s_nmap("}", function() BracketMotion("down", vim.v.count) end)

s_vmap("<", "<gv")
s_vmap(">", ">gv")
s_vmap("?!", [["gy:lua Google(api.nvim_eval("@g"), true)<cr>gv]])
s_vmap("??", [["gy:lua Google(api.nvim_eval("@g"), false)<cr>gv]])
-- s_vmap("p", [["_dp]], noremap)
-- s_vmap("P", [["_dP]], noremap)

s_vmap("@", "<CMD>norm@<CR>")
s_vmap("H", "^")
s_vmap("L", "$")

s_imap("<m-p>", [[<C-r><C-o>"]])

-- find a way to switch back from insert mode in terminal

-- s_nmap("<TAB><TAB>", cmd.tabnew, {}, "new tab")
-- s_nmap("<TAB>n", cmd.tabnext, {}, "next tab")
-- s_nmap("<localleader>T", "<c-w>T", {}, "move to new tab")
-- s_nmap("<TAB>p", cmd.tabprevious, {}, "previous tab")

nmap(
  "<localleader>r",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  {},
  "pre-fill find and replace with word"
)
nmap('q:', ':q<cr>', "Quit")

s_nmap("<leader>=", cmd.sp, {}, "split window horizontally")
s_nmap("<leader>P", [["*P]], {}, "paste above from clipboard")
s_nmap("<leader>\\", cmd.vsp, {}, "split window vertically")
s_nmap("<leader>p", [["*p]], {}, "paste from clipboard")
s_nmap("<leader>q", [[<C-W>q]], {}, "close window")
s_nmap("<leader>ss", "<CMD>source %<CR>", {}, "source this file")
s_nmap("<leader>w", cmd.w, {}, "save")
s_nmap(
  "<localleader><space>",
  "<cmd>RemoveDoubleLines<cr>",
  {},
  "remove all double linebreaks",
  "removing double line breaks"
)
s_nmap(
  "<localleader>z",
  [[zMzvzz]],
  {},
  "reasonably fold things around you",
  "reasonably folding things around you"
)

s_vmap("<leader>y", [["*y]], {}, "copy to system clipboard", "copied to system clipboard")
s_vmap("<localleader><space>", [[:g/^$/d<CR>]], {}, "Clear double blank lines", "clearing double blank lines")
s_vmap("<localleader>y", '"*y', {}, "Copy to system clipboard", "copied to system clipboard")

s_nmap("<space>n", [[<CMD>call feedkeys(":e " . expand("%:p:h") . "/")<CR>]], {}, "new file in directory")
s_nmap("<space>ev", function() cmd.e("~/.config/nvim/init.lua") end, {}, "edit init_lua")

cmd([[
  cabbr <expr> %% expand('%:p:h')
  inoreab ture true
  inoreab Fname <c-r>=expand("%:p")<cr>
  inoreab fname <c-r>=expand("%:t")<cr>
  inoreabbrev idate <C-R>=strftime("%b %d %Y %H:%M")<CR>
]])

s_nmap("gb", '"_d', "blackhole delete")
s_nmap("gB", '"_D', "blackhole delete linewise")
s_xmap("gb", '"_d', "blackhole delete")
s_xmap("gB", '"_D', "blackhole delete linewise")

-- doesn't work in fzf
-- s_tmap("<tab><tab>", function()
--   if vim.bo.filetype ~= "fzf" then
--     "<C-\\><C-n>"
--   end
-- end,
-- "normal mode in terminal")

s_cmap("<m-p>", [[<C-r>"]])
-- fix this ^^

local function alias(name, ...)
  local args = { ... }
  vim.keymap.set("ca", name, function()
    if vim.fn.getcmdtype() == ':' and vim.fn.getcmdline():find("^" .. name) then
      return table.concat(args, " ")
    end
    return name
  end, { noremap = true, expr = true, replace_keycodes = true })
end

s_nxmap('j', "v:count == 0 ? 'gj' : 'j'", expr)
s_nxmap('<Down>', "v:count == 0 ? 'gj' : 'j'", expr)
s_nxmap('k', "v:count == 0 ? 'gk' : 'k'", expr)
s_nxmap('<Up>', "v:count == 0 ? 'gk' : 'k'", expr)

alias("grc", "edit", "$MYGVIMRC")
alias("rc", "edit", "$MYVIMRC")
alias("fix", "lua", "vim.lsp.buf.code_action()")

s_nmap("<cr>", ':write!<CR>', "write")
s_nmap("<BS>", "ciw")

--graveyard:
s_nmap("<m-cr>", ':echom "Hello M + R"<CR>')

-- vim.keymap.set("v", "J", ":m '>+1<CR>gv==kgvo<esc>=kgvo", { desc = "move highlighted text down" }) vim.keymap.set("v", "K", ":m '<-2<CR>gv==jgvo<esc>=jgvo", { desc = "move highlighted text up" })
