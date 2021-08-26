local noremap = { noremap = true }

s_nmap("dd", function()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return '"_dd'
  else
    return "dd"
  end
end, { expr = true }, "[smart] delete line")

s_nmap("zM", "zM:echo &foldlevel<CR>", noremap, "close all folds")
s_nmap("zR", "zR:echo &foldlevel<CR>", noremap, "open all folds")
s_nmap("zm", "zm:echo &foldlevel<CR>", noremap, "increase fold level")
s_nmap("zr", "zr:echo &foldlevel<CR>", noremap, "reduce fold level")

s_imap("<m-w>", "<c-u>")

s_nmap("!", "<CMD>lua vim.lsp.buf.format( {async = true} )<CR>", {}, "format buffer", "formatting buffer")
s_nmap("<C-d>", "<C-d>zz")
s_nmap("<C-u>", "<C-u>zz")
s_nmap("<Del>", "ciW")
s_nmap("<F6>", "<C-i>", noremap)
s_nmap("<BS>", ":b#")
s_nmap("<s-tab>", "<c-w>w")
s_nmap("A", "zzA")
s_nmap("C", "zzC")
s_nmap("G", "Gzz")
s_nmap("H", "^")
s_nmap("I", "zzI")
s_nmap("L", "$")
s_nmap("N", "Nzz")
s_nmap("O", "zzO")
s_nmap("S", "zzS")
s_nmap("S", "<CMD>keeppatterns substitute/\\s*\\%#\\s*/\\r/e <bar> normal! ==<CR>")
s_nmap("Z", "za")
s_nmap("a", "zza")
s_nmap("c", "zzc")
-- s_nmap("gV", "`[v`]", {}, "go to last visual selection")
s_nmap("gm", [[<CMD>silent exec "!$HOME/code/dotfiles/home/zsh/bin/glmr"<CR>]], {}, "go to current GitLab MR",
  "go to current GitLab MR")
s_nmap("i", "zzi")
s_nmap("n", "nzz")
s_nmap("o", "zzo")
s_nmap("s", "zzs")
s_nmap("s", "<nop>")
s_nmap("yp", "<CMD>let @+ = expand('%:p')<CR>", {}, "Filepath", "yanked filepath")
s_nmap("{", function() BracketMotion("up", vim.v.count) end)
s_nmap("}", function() BracketMotion("down", vim.v.count) end)

s_nmap("]!", vim.diagnostic.goto_next, {}, "Next diagnostic issue")
s_nmap("[!", vim.diagnostic.goto_prev, {}, "Previous diagnostic issue")

s_nmap("<TAB><TAB>", vim.cmd.tabnew, {}, "new tab")
s_nmap("<TAB>n", vim.cmd.tabnext, {}, "next tab")
s_nmap("<TAB>p", vim.cmd.tabprevious, {}, "previous tab")

s_vmap("<", "<gv")
s_vmap(">", ">gv")
s_vmap("?!", [["gy:lua google(vim.api.nvim_eval("@g"), true)<cr>gv]])
s_vmap("??", [["gy:lua google(vim.api.nvim_eval("@g"), false)<cr>gv]])
s_vmap("@", "<CMD>norm@<CR>")
s_vmap("H", "^")
s_vmap("L", "$")
s_vmap("S", "sa")
s_vmap("Y", "y$")

s_imap("<m-p>", [[<C-r><C-o>"]])

s_nmap("~", "<CMD>FloatermToggle!<CR>", noremap)
s_nmap("<M-`>", "<CMD>FloatermToggle!<CR>", noremap)
s_tmap("<M-`>", "<C-\\><C-n><CMD>FloatermToggle!<CR>", noremap)
s_tmap("<S-TAB>", "<C-\\><C-n><CMD>wincmd w<CR>", noremap)

s_nmap("<leader>ss", "<CMD>source %<CR>", {}, "source this file")
s_nmap("<leader>%", SetCwd, noremap, "set working directory root")
s_nmap("<leader>=", vim.cmd.sp, {}, "split window horizontally")
s_nmap("<leader>\\", vim.cmd.vsp, {}, "split window vertically")
s_nmap("<leader><space>", FlashCursorline, {}, "flash cursor for pairing")
s_nmap("<leader>p", [["*p]], {}, "paste from clipboard")
s_nmap("<leader>P", [["*P]], {}, "paste above from clipboard")
s_nmap("<leader>T", vim.cmd.TestFile, {}, "test entire file")
s_nmap("<leader>l", vim.cmd.TestLast, {}, "repeat last test")
s_nmap("<leader>w", vim.cmd.w, {}, "save")
s_vmap("<leader>y", [["*y]], {}, "copy to system clipboard", "copied to system clipboard")
s_nmap("<leader>|", [[<CMD>execute "set colorcolumn=" . (&colorcolumn == "" ? "81" : "")<cr>]], {},
  "toggle colored column at 81")

s_vmap("<localleader><space>", [[:g/^$/d<CR>]], {}, "Clear double blank lines", "clearing double blank lines")
s_vmap("<localleader>x", "<plug>(mkdx-checkbox-next-v)", {}, "Checkbox in markdown")
s_vmap("<localleader>y", '"*y', {}, "Copy to system clipboard", "copied to system clipboard")

s_nmap("<localleader>T", "<c-w>T", {}, "move to new tab")
s_nmap("<localleader>pc", "<CMD>g/binding.pry/norm gcc<CR>", {}, "Toggle commenting in all prys")
s_nmap("<localleader>pd", "<CMD>g/binding.pry/d<CR>", {}, "Delete all prys")
s_nmap("<localleader>pp", "Obinding.pry<ESC>j0", {}, "Add a pry")
s_nmap("<localleader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {},
  "pre-fill find and replace with word")
s_nmap("<localleader><space>", "<cmd>RemoveDoubleLines<cr>", {}, "remove all double linebreaks")
s_nmap("<localleader>z", [[zMzvzz]], {}, "reasonably fold things around you", "reasonably folding things around you")

s_nmap("<space>n", [[<CMD>call feedkeys(":e " . expand("%:p:h") . "/")<CR>]], {}, "new file in directory")
s_nmap("<space>N", vim.cmd.NewConfig, {}, "new file in plugin config directory")
s_nmap("<space>q", vim.cmd.NvimTreeFindFile, {}, "show file in sidebar", "show file in sidebar")
s_nmap("<space>u", [[<CMD>execute 'edit' fnameescape(g:latest_deleted_buffer)<CR>]], {}, "undo close last buffer")
s_nmap("<space>z", vim.cmd.NvimTreeOpen, {}, "show files in directory")
s_nmap("<space>ev", function() vim.cmd.e("~/.config/nvim/init.lua") end, {}, "edit init_lua")

vim.cmd([[inoreab ture true]])

vim.cmd([[cabbr <expr> %% expand('%:p:h')]])

vim.cmd([[inoreab Fname <c-r>=expand("%:p")<cr>]])
vim.cmd([[inoreab fname <c-r>=expand("%:t")<cr>]])
vim.cmd([[inoreabbrev idate <C-R>=strftime("%b %d %Y %H:%M")<CR>]])

s_cmap("<m-p>", [[<C-r>"]])
-- fix this ^^

--graveyard:
-- vmap("X", "Xtract ")
-- AnyJump
-- Edit factories fzf
-- s_nmap("<m-cr>", ':echom "Hello M + R"<CR>')

-- vim.keymap.set("v", "J", ":m '>+1<CR>gv==kgvo<esc>=kgvo", { desc = "move highlighted text down" }) vim.keymap.set("v", "K", ":m '<-2<CR>gv==jgvo<esc>=jgvo", { desc = "move highlighted text up" })

-- vim.cmd([[nnoremap * :keepjumps normal! mi*`i<CR>]])
-- vim.cmd([[vnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>]])
