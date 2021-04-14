-- vi: foldmethod=marker
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- SPACEBAR {{{ "
s_map("<space>1",       ':Files all_models<CR>')
s_map("<space>2",       ':Files all_specs<CR>')
s_map("<space>3",       ':Files all_lib<CR>')
s_map("<space>;",       ':Commands<CR>')
s_map("<space><space>", [[<C-^>]])
s_map("<space>[",       '<Plug>unimpairedBPrevious')
s_map("<space>]",       '<Plug>unimpairedBNext')
s_map("<space>a",       ':NvimTreeToggle<CR>')
s_map("<space>w",       ':NvimTreeFindFile<CR>')
s_map("<space>c",       ':Commits<CR>')
s_map("<space>ea",      ':Eauto<CR>')
s_map("<space>ec",      ':Ecomp<CR>')
s_map("<space>ed",      ':Edotfiles<CR>')
s_map("<space>ee",      ':Ezshenv<CR>')
s_map("<space>ef",      ':Efunction<CR>')
s_map("<space>ei",      ':PlugInstall<CR>')
s_map("<space>em",      ':Emap<CR>')
s_map("<space>ep",      ':Eplugin<CR>')
s_map("<space>es",      ':Eplugin<CR>')
s_map("<space>esd",     ':EditFileTypeDetect<CR>')
s_map("<space>esp",     ':EditFileTypePlugin<CR>')
s_map("<space>et",      ':Etmux<CR>')
s_map("<space>eu",      ':PlugUpdate<cr>')
s_map("<space>ev",      ':e $MYVIMRC<CR>')
s_map("<space>ez",      ':Ezshrc<CR>')
s_map("<space>f",       '<Plug>(esearch)')
s_map("<space>g",       ':GFiles?<CR>')
s_map("<space>h",       ':Helptags<CR>')
s_map("<space>l",       ':Lines<CR>')
s_map("<space>n",       ":e <C-R>=expand('%:p:h') . '/'<CR>")
s_map("<space>r",       ':History<CR>')
s_map("<space>s",       ':Snippets<CR>')
s_map("<space>t",       [[:e ~/.vim/temp.rb<CR>]])
s_map("<space>z",       ":Files <C-r>=expand(\"%:h\")<CR>/<CR>")
-- }}} SPACEBAR "

-- map("<space>u",       ":call undoquit#RestoreWindow()<CR>", { silent = true })

-- leader {{{ "
-- vim commands or features
s_map("<leader><leader>", ":FloatermToggle!<CR>")
s_map("<leader>=",        ":sp<CR>")
s_map("<leader>T",        [[:TestFile<CR>]])
s_map("<leader>\\",       ":vsp<CR>")
s_map("<leader>c",        [[:t.<CR>k<Plug>CommentaryLinej]])
s_map("<leader>e",        ":FloatermNew --wintype=floating --width=0.5 --height=0.99 --position=right zsh<CR>")
s_map("<leader>g",        ":FloatermNew --wintype=floating --width=0.99 --height=0.99 lazygit<CR>")
s_map("<leader>i",        ":<c-u>let pc = (v:count1 ? v:count1 : 1)<cr>:read !tail -<c-r>=pc<cr> ~/.irb_history<cr>:.-<c-r>=pc-1<cr>:norm <c-r>=pc<cr>==<cr>", {})
s_map("<leader>l",        [[:TestLast<CR>]])
s_map("<leader>p",        "\"*p")
s_map("<leader>r",        ':FloatermNew --wintype=floating btm<CR>')
s_map("<leader>t",        [[:TestNearest<CR>]])
s_map("<leader>v",        [[:TestVisit<CR>]])
s_map("<leader>w",        [[:w<cr>]])
s_map("<leader>y",        "\"*y")
s_map("<leader>z",        ':FloatermNew --wintype=floating zsh<CR>')
-- }}} leader "

-- do something with the current document
-- " <Plug>(ale_fix)

-- map <leader>sI <Plug>SidewaysArgumentInsertFirst
-- map <leader>sA <Plug>SidewaysArgumentAppendLast

-- local leader {{{ "
s_map("<LocalLeader><LocalLeader>", ":ArgWrap<CR>")
s_map("<LocalLeader>=",             "gaip=<CR>")
s_map("<LocalLeader>b",             "<Plug>(git-messenger)")
s_map("<LocalLeader>f",             "<Plug>CtrlSFVwordPath<CR>")
s_map("<LocalLeader>pc",            ":g/binding.pry/norm gcc<CR>")
s_map("<LocalLeader>pd",            ":g/binding.pry/d<CR>")
s_map("<LocalLeader>pp",            "Obinding.pry<ESC>j0")
s_map("<LocalLeader>s",             ":AnyJump<CR>")
-- s_map("<LocalLeader>u",             "<Plug>(GitGutterUndoHunk)")
s_map("<LocalLeader>y",             ":let @* = expand('%:p')<CR>")
s_nmap("<LocalLeader>x",            "<Plug>(mkdx-checkbox-next-n)")
s_vmap("<LocalLeader>s",            ":AnyJumpVisual<CR>")
s_vmap("<LocalLeader>x",            "<Plug>(mkdx-checkbox-next-v)")
-- map("<LocalLeader><tab>",         "<Plug>SidewaysArgumentAppendAfter", { silent = true })
-- map("<LocalLeader>`",             "<Plug>SidewaysArgumentInsertFirst", { silent = true })
-- }}} local leader "

-- toggles {{{ "
-- s_nmap("yog", ":GitGutterLineHighlightsToggle<CR>")
s_nmap("yoa", "<Plug>(ale_toggle_buffer)")
-- }}} toggles "

-- brackets {{{ "
-- left bracket {{{ "
s_nmap("[!",     "<Plug>(ale_previous_wrap)")
s_nmap("[{",     "<Plug>SidewaysArgumentInsertBefore")
s_nmap("[<Tab>", ":SidewaysLeft<cr>")
s_nmap("[c",     "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'", { expr = true })
s_nmap("]c",     "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'", { expr = true })
s_xmap("[e",     ":m-2<cr>gv=gv")
-- map("[x",     "<Plug>(mkdx-checkbox-next-v)",        { silent = true })
-- map("]x",     "<Plug>(mkdx-checkbox-next-n)",        { silent = true })
-- }}} left bracket "

-- right bracket {{{ "
s_nmap("]!",     "<Plug>(ale_next_wrap)")
s_nmap("]<Tab>", ":SidewaysRight<cr>")
s_nmap("]}",     "<Plug>SidewaysArgumentAppendAfter")
-- s_nmap("]c",     "<Plug>(GitGutterNextHunk)")
s_xmap("]e",     ":m'>+<cr>gv=gv")
-- }}} right bracket "

if plugin_loaded("nvim-bufferline.lua") then
  s_nmap("]b", ":BufferLineCycleNext<CR>")
  s_nmap("[b", ":BufferLineCyclePrev<CR>")
end
-- }}} brackets "

-- "Built ins" {{{ "
s_nmap("s",  "<nop>")
s_nmap("//", ":nohlsearch<cr>")
s_nmap("Z",  "za")
s_nmap("Y",  "y$")
s_nmap("H",  "^")
s_nmap("L",  "$")
s_nmap("gV", "`[v`]")
s_nmap("{",  [[:<c-u>call BracketMotion("up", v:count)<CR>]])
s_nmap("}",  [[:<c-u>call BracketMotion("down", v:count)<CR>]])
s_nmap("j",  "(v:count == 0 ? 'gj' : 'j')", {expr = true})
s_nmap("k",  "(v:count == 0 ? 'gk' : 'k')", {expr = true})
s_xmap("Y",  "y$")
s_xmap("H",  "^")
s_xmap("L",  "$")
s_xmap("<",  "<gv")
s_xmap(">",  ">gv")
s_xmap("@",  ":norm@")
s_xmap('?!', '"gy<Esc>:call LuckySearch()<CR>')
s_xmap('??', '"gy<Esc>:call GoogleSearch()<CR>')
s_xmap('S',  'sa')
s_nmap('p',  'p`[v`]=')
s_nmap('P',  'P`[v`]=')
s_vmap('p',  '"_dP`[v`]=')
-- }}} "Built ins" "

-- Normal maps {{{ "
nmap("zM",        "zM:echo &foldlevel<cr>", {noremap = true})
nmap("zR",        "zR:echo &foldlevel<cr>", {noremap = true})
nmap("zm",        "zm:echo &foldlevel<cr>", {noremap = true})
nmap("zr",        "zr:echo &foldlevel<cr>", {noremap = true})
s_nmap("!",       ":Neoformat<CR>")
s_nmap("-",       ":Switch<CR>")
s_nmap(";",       ":Buffers<CR>")
s_nmap("<C-P>",   ":Files<CR>")
s_nmap("<Del>",   ":A<cr>")
s_nmap("<Down>",  ":call animate#window_delta_height(15)<CR>", {noremap = true})
s_nmap("<Left>",  ":call animate#window_delta_width(-30)<CR>", {noremap = true})
s_nmap("<Right>", ":call animate#window_delta_width(30)<CR>", {noremap = true})
s_nmap("<Up>",    ":call animate#window_delta_height(-15)<CR>", {noremap = true})
s_nmap("<s-tab>", "<c-w>w")
s_nmap("Q",       ":Sayonara<cr>")
s_nmap("S",       ":call BreakHere()<CR>")
s_nmap("dh",      ":Deleft<CR>")
s_nmap("ga",      "<Plug>(EasyAlign)")
s_nmap("gb",      "<Plug>(gh-line)")
-- s_nmap("ghf",     ":GitGutterFold<CR>")
-- s_nmap("ghp",     ":GitGutterPreviewHunk<CR>")
-- s_nmap("ghq",     ":GitGutterQuickFix<CR>")
-- s_nmap("ghs",     ":GitGutterStageHunk<CR>")
-- s_nmap("ghu",     ":GitGutterUndoHunk<CR>")
s_nmap("glb",     "<Plug>(gh-line-blame)")
s_nmap("sJ",      ":SplitjoinSplit<cr>")
s_nmap("sK",      ":SplitjoinJoin<cr>")
s_nmap("sj",      ":SplitjoinSplit<cr>")
s_nmap("sk",      ":SplitjoinJoin<cr>")
s_xmap("<cr>",    "<Plug>(LiveEasyAlign)")
s_xmap("ga",      "<Plug>(LiveEasyAlign)")
-- }}} Normal maps "

-- command mode {{{ "
vim.api.nvim_set_keymap('c', '<c-r><c-r>', ':call fzf#vim#commands()<CR>', {nowait = true})
vim.cmd([[cabbr <expr> %% expand('%:p:h')]])
-- }}} command mode "

-- imap("<c-x><c-f>", "fzf#vim#complete#path('fd')", { expr = true })
-- nmap <silent> [n :call mappings#cycle_numbering()<CR>
-- nmap <silent> ]n :call mappings#cycle_numbering()<CR>

-- " open previous opened file (after jump)
-- " nnoremap <leader>ab :AnyJumpBack<CR>
-- " open last closed search window again
-- " nnoremap <leader>al :AnyJumpLastResults<CR>

-- " xmap <c-c><c-c>

-- " ctrl-w H - Change horizontal splits to vertical
-- " ctrl-w K - Change vertical splits to horizontal

-- Text objects {{{ "
-- s_omap('ig', '<Plug>(GitGutterTextObjectInnerPending)')
-- s_omap('ag', '<Plug>(GitGutterTextObjectOuterPending)')
-- s_xmap('ig', '<Plug>(GitGutterTextObjectInnerVisual)')
-- s_xmap('ag', '<Plug>(GitGutterTextObjectOuterVisual)')
s_omap('aa', '<Plug>SidewaysArgumentTextobjA')
s_omap('ia', '<Plug>sidewaysargumenttextobji')
s_xmap('aa', '<Plug>sidewaysargumenttextobja')
s_xmap('ia', '<Plug>SidewaysArgumentTextobjI')
s_omap('if', 'TSTextobjectSelect @function.inner<CR>')
s_omap('af', 'TSTextobjectSelect @function.outer<CR>')
s_xmap('if', 'TSTextobjectSelect @function.inner<CR>')
s_xmap('af', 'TSTextobjectSelect @function.outer<CR>')

-- " }}} Text objects "

-- * and / commands {{{ "
s_nmap("n", "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>", {noremap = true})
s_nmap("N", "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>", {noremap = true})

if plugin_loaded("nvim-hlslens") then
  s_nmap("*", "*``<Cmd>lua require('hlslens').start()<CR>", {noremap = true})
  s_nmap("#", "#``<Cmd>lua require('hlslens').start()<CR>", {noremap = true})
  s_nmap("g*", "g*<Cmd>lua require('hlslens').start()<CR>", {noremap = true})
  s_nmap("g#", "g#<Cmd>lua require('hlslens').start()<CR>", {noremap = true})
end

s_xmap("*", ":<C-u>call VSetSearch('/')<CR>/<C-R>=@/<CR><CR>``<Cmd>lua require('hlslens').start()<CR>", {noremap = true})
s_xmap("#", ":<C-u>call VSetSearch('?')<CR>?<C-R>=@/<CR><CR>``<Cmd>lua require('hlslens').start()<CR>", {noremap = true})
-- }}} * and / commands "

tmap("<s-tab>", "<c-w>w", {silent = true, noremap = true})
tmap("<leader><leader>", "<C-\\><C-n>:FloatermToggle!<CR>", {silent = true, noremap = true})

vim.api.nvim_exec( [[command! Eauto     execute "e $DOTFILES/home/vim/vimscript/autocommands.vim"]], false)
vim.api.nvim_exec( [[command! Emap      execute "e $DOTFILES/home/vim/lua/mappings.lua"]],           false)
vim.api.nvim_exec( [[command! Eplugin   execute "e $DOTFILES/home/vim/lua/plugins.lua"]],            false)
vim.api.nvim_exec( [[command! Epack     execute "e $DOTFILES/home/vim/vimscript/plugins.vim"]],      false)
vim.api.nvim_exec( [[command! Ecomp     execute "e $DOTFILES/home/vim/lua/completions.lua"]],        false)
vim.api.nvim_exec( [[command! Efunction execute "e $DOTFILES/home/zsh/functions.zsh"]],              false)
vim.api.nvim_exec( [[command! Eprivate  execute "e $DOTFILES/home/zsh/private/private.zsh"]],        false)
vim.api.nvim_exec( [[command! Ealiases  execute "e $DOTFILES/home/zsh/aliases.zsh"]],                false)
vim.api.nvim_exec( [[command! Etmux     execute "e $DOTFILES/home/tmux.conf"]],                      false)
vim.api.nvim_exec( [[command! Ezshrc    execute "e $DOTFILES/home/zshrc"]],                          false)

-- TODO: fix these
vim.api.nvim_exec([[command! Edotfiles execute "Dotfiles"]], false)
vim.api.nvim_exec([[command! Ezsh      execute "Files $DOTFILES/home/zsh"]], false)
vim.api.nvim_exec([[command! Esnip     execute "Files $HOME/.vsnip/"]], false)

if plugin_loaded("vim-which-key") then require 'which_key' end
