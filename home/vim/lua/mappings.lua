-- vi: foldmethod=marker
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

local wk = require("which-key")

wk.register({
    -- spacebar {{{
    ["<space>"] = {
        name = "+spacebar",
        ['1'] = {'<cmd>Files all_models<CR>', 'Rails Models'},
        ['2'] = {'<cmd>Files all_specs<CR>', 'Rails Specs'},
        ['3'] = {'<cmd>Files all_lib<CR>', 'Rails Libs'},
        [';'] = {'<cmd>Commands<CR>', 'Buffers'},
        ['<space>'] = {[[<C-^>]], 'Back a file'},
        ['['] = {'<Plug>unimpairedBPrevious', 'Last file'},
        [']'] = {'<Plug>unimpairedBNext', 'Next file'},
        a = {'<cmd>NvimTreeToggle<CR>', 'NVim Tree'},
        c = {'<cmd>Commits<CR>', 'List Commits'},
        e = {
            name = "+edit",
            a = {'<cmd>Eauto<CR>', 'Autocommands'},
            c = {'<cmd>Ecomp<CR>', 'Completions'},
            d = {'<cmd>Edotfiles<CR>', 'Dotfiles'},
            e = {'<cmd>Ezshenv<CR>', '.zshenv'},
            f = {'<cmd>Efunction<CR>', 'ZSH Commands'},
            i = {'<cmd>PlugInstall<CR>', 'Install Plugins'},
            m = {'<cmd>Emap<CR>', 'Mappings'},
            p = {'<cmd>Eplugin<CR>', 'Plugins'},
            sd = {'<cmd>EditFileTypeDetect<CR>', 'Filetype Detector'},
            sp = {'<cmd>EditFileTypePlugin<CR>', 'Filetype Plugin'},
            t = {'<cmd>Etmux<CR>', 'Tmux'},
            u = {'<cmd>PlugUpdate<cr>', 'Update Plugins'},
            v = {'<cmd>e $MYVIMRC<CR>', 'Vimrc'},
            z = {'<cmd>Ezshrc<CR>', '.zshrc'}
        },
        f = {[[<Plug>(esearch)]], 'Search in project'},
        g = {'<cmd>GFiles?<CR>', 'List Git Files'},
        h = {'<cmd>Helptags<CR>', 'List Helptags'},
        l = {'<cmd>Lines<CR>', 'Search lines in file'},
        n = {
            [[<cmd>e <C-R>=expand('%:p:h') . '/'<CR>]], 'New file in directory'
        },
        r = {'<cmd>History<CR>', 'Command history'},
        s = {'<cmd>Snippets<CR>', 'View snippets'},
        t = {[[<cmd>e ~/.vim/temp.rb<CR>]], 'Temporary File'},
        w = {'<cmd>NvimTreeFindFile<CR>', 'Show file in sidebar'},
        z = {
            "<cmd>Files <C-r>=expand(\"%:h\")<CR>/<CR>",
            'Show files in directory'
        }
    },
    -- }}} spacebar

    -- leader {{{

    ["<leader>"] = {
        name = "+leader",
        ["<leader>"] = {
            "<cmd>FloatermToggle!<CR>", "Toggle side floatterm window"
        },
        ["="] = {"<cmd>sp<CR>", "Split window horizontally"},
        ["\\"] = {"<cmd>vsp<CR>", "Split window vertically"},
        T = {"<cmd>TestFile<CR>", "Test entire file"},
        e = {
            "<cmd>FloatermNew --wintype=floating --width=0.5 --height=0.99 --position=right zsh<CR>",
            "Side ZSH window"
        },
        g = {
            "<cmd>FloatermNew --wintype=floating --width=0.99 --height=0.99 lazygit<CR>",
            "LazyGit"
        },
        l = {"<cmd>TestLast<CR>", "Repeat Last Test"},
        p = {"\"*p", "Paste from clipboard"},
        r = {"<cmd>FloatermNew --wintype=floating btm<CR>", "CPU usage"},
        s = "which_key_ignore",
        t = {"<cmd>TestNearest<CR>", "Run nearest test"},
        v = {"<cmd>TestVisit<CR>", "Visit current test"},
        w = {"<cmd>w<cr>", "Save"},
        y = {"\"*y", "Copy to system clipboard"},
        z = {
            "<cmd>FloatermNew --wintype=floating zsh<CR>", "Floating ZSH window"
        }
        -- i  = { "<cmd><c-u>let pc = (v:count1 ? v:count1 : 1)<cr>:read !tail -<c-r>=pc<cr> ~/.irb_history<cr>:.-<c-r>=pc-1<cr>:norm <c-r>=pc<cr>==<cr>", "" },
        -- c  = {[[<cmd>t.<CR>k<Plug>CommentaryLinej]]},
    },
    -- }}} leader

    -- goto {{{
    ["g"] = {
        ['name'] = "+goto",
        ['*'] = 'which_key_ignore',
        ['#'] = 'which_key_ignore',
        ['a'] = 'Easy Align',
        ['b'] = 'Point to line on website',
        ['c'] = 'Comment...',
        ['cc'] = 'Comment line',
        ['g'] = 'Top',
        ['h'] = 'which_key_ignore',
        ['o'] = 'Open URL?',
        ['oF'] = 'Open root folder in terminal',
        ['of'] = 'Open current folder in terminal',
        ['ot'] = 'Open root folder in Finder',
        ['oT'] = 'Open current folder in Finder',
        ['V'] = 'Last selection',
        ['x'] = 'Thing on cursor',
        ['%'] = 'Matchup',
        ['h'] = {
            ['name'] = 'Git',
            ['R'] = 'Reset entire buffer',
            ['r'] = 'Stage - undo hunk',
            ['s'] = 'Stage - stage hunk',
            ['u'] = 'Undo hunk',
            ['p'] = 'Preview hunk',
            ['b'] = 'Git Blame'
        }
    },
    -- }}} goto

    -- localleader {{{
    ["\\"] = {
        ['name']  = "+localleader",
        ["\\"]    = {"<cmd>ArgWrap<CR>",                  "Toggle argument wrap"},
        ["="]     = {"gaip=",                             "Align equal signs in paragraph"},
        ['b']     = {"<plug>(git-messenger)",             "Git blame line in popup"},
        ['f']     = {"<plug>(operator-esearch-prefill)",  "Search word in (object)"},
        ['pc']    = {"<cmd>g/binding.pry/norm gcc<CR>",   "Toggle commenting in all prys" },
        ['pd']    = {"<cmd>g/binding.pry/d<CR>",          "Delete all prys"},
        ['pp']    = {"Obinding.pry<ESC>j0",               "Add a pry"},
        ['s']     = {"<cmd>AnyJump<CR>",                  "Find definition (anyjump)"},
        ['u']     = {"<plug>(GitGutterUndoHunk)",         "Undo git hunk"},
        ['y']     = {"<cmd>let @* = expand('%:p')<CR>",   "Copy path to clipboard"},
        ['<TAB>'] = {"<plug>SidewaysArgumentAppendAfter", "Append argument to function" }
    },
    -- }}} localleader

    -- toggles {{{
    ["yo"] = {
      ['name'] = '+toggles',
      ['+'] = "which_key_ignore",
      ['-'] = "which_key_ignore",
      ['_'] = "which_key_ignore",
      ['a'] = { '<Plug>(ale_toggle_buffer)', 'Toggle ALE messages' },
      ['b'] = 'Background (dark/light)',
      ['c'] = "Cursor Line",
      ['d'] = 'Diffs',
      ['g'] = { '<cmd>GitGutterLineHighlightsToggle<CR>', 'Toggle Git Gutter Highlights' },
      ['h'] = 'Highlight search',
      ['i'] = 'Ignorecase',
      ['l'] = 'List chars',
      ['n'] = 'Absolute Numbers',
      ['p'] = "which_key_ignore",
      ['r'] = 'Relative Numbers',
      ['s'] = 'Spelling',
      ['u'] = 'Cursor Column',
      ['v'] = 'Virtualedit',
      ['w'] = 'Word wrapping',
      ['x'] = 'Cursor Line + Cursor Column',
      ['|'] = "which_key_ignore"
    },
    -- }}} toggles

    -- left bracket {{{
    ["["] = {
        ['name'] = '+leftbrakcet',
        ['<C-L>'] = 'which_key_ignore',
        ['<C-Q>'] = 'which_key_ignore',
        ['<C-T>'] = 'which_key_ignore',
        ['!'] = {'<Plug>(ale_previous_wrap)', 'Previous linter problem (ALE)'},
        ['%'] = 'Prev matchit operator?',
        ["'"] = 'Prev marker?',
        ['-'] = 'Prev marker?',
        ['<TAB>'] = {'<cmd>SidewaysLeft<cr>', 'Sideways left'},
        ['='] = 'Prev marker?',
        ['['] = 'Prev function end',
        ['}'] = {'<Plug>SidewaysArgumentAppendAfter', 'Prepend argument'},
        [']'] = 'Prev function start',
        ['`'] = 'Prev marker?',
        ['A'] = 'which_key_ignore',
        ["o"] = {
            ['name'] = 'Turn on...',
            ['+'] = 'Cusor Line AND Column',
            ['-'] = 'Cursor Line',
            ['_'] = 'Cursor Line',
            ['b'] = 'Light Background',
            ['c'] = 'Cursor Line',
            ['d'] = 'Diff This',
            ['h'] = 'Search',
            ['i'] = 'Ignore Case',
            ['l'] = 'List Characters',
            ['n'] = 'Numbers',
            ['p'] = 'Paste Mode',
            ['r'] = 'Relative Numbers',
            ['s'] = 'Spelling',
            ['u'] = 'Cursor Column',
            ['v'] = 'Virtual Edit',
            ['w'] = 'Wrap',
            ['x'] = 'Cusor Line AND Column',
            ['|'] = 'Cursor Column'
        },
        ['a'] = 'which_key_ignore',
        ['b'] = 'Prev Buffer',
        ['B'] = 'First Buffer',
        ['c'] = {"<Plug>(GitGutterPrevHunk)", 'Git Hunk'},
        ['e'] = {":m-2<cr>gv=gv", 'Exchange Below'},
        ['f'] = 'Prev File',
        ['L'] = 'which_key_ignore',
        ['l'] = 'which_key_ignore',
        ['n'] = 'which_key_ignore',
        ['P'] = 'Put Above?',
        ['p'] = 'Put Below?',
        ['Q'] = 'First quickfix item',
        ['q'] = 'Prev quickfix item',
        ['T'] = 'which_key_ignore',
        ['t'] = 'which_key_ignore',
        ['u'] = 'which_key_ignore',
        ['uu'] = 'which_key_ignore',
        ['v'] = 'which_key_ignore',
        ['x'] = 'which_key_ignore',
        ['xx'] = 'which_key_ignore',
        ['y'] = 'which_key_ignore',
        ['yy'] = 'which_key_ignore'
    },
    -- }}} left bracket

    -- right bracket {{{
    ["]"] = {
        ['name'] = '+rightbracket',
        ['<C-L>'] = 'which_key_ignore',
        ['<C-Q>'] = 'which_key_ignore',
        ['<C-T>'] = 'which_key_ignore',
        ['!'] = {'<Plug>(ale_next_wrap)', 'Next linter problem (ALE)'},
        ['%'] = 'Next matchit operator?',
        ["'"] = 'Next marker?',
        ['-'] = 'Next marker?',
        ['<TAB>'] = {'<cmd>SidewaysRight<cr>', 'Sideways right'},
        ['='] = 'Next marker?',
        ['['] = 'Next function end',
        ['}'] = {'<Plug>SidewaysArgumentAppendAfter', 'Append argument'},
        ['`'] = 'Next marker?',
        ['A'] = 'which_key_ignore',
        ["o"] = {
            ['name'] = 'Turn off...',
            ['+'] = 'Cusor Line AND Column',
            ['-'] = 'Cursor Line',
            ['_'] = 'Cursor Line',
            ['b'] = 'Light Background',
            ['c'] = 'Cursor Line',
            ['d'] = 'Diff This',
            ['h'] = 'Search',
            ['i'] = 'Ignore Case',
            ['l'] = 'List Characters',
            ['n'] = 'Numbers',
            ['p'] = 'Paste Mode',
            ['r'] = 'Relative Numbers',
            ['s'] = 'Spelling',
            ['u'] = 'Cursor Column',
            ['v'] = 'Virtual Edit',
            ['w'] = 'Wrap',
            ['x'] = 'Cusor Line AND Column',
            ['|'] = 'Cursor Column'
        },
        ['a'] = 'which_key_ignore',
        ['b'] = 'Next Buffer',
        ['B'] = 'Last Buffer',
        ['c'] = {'<Plug>(GitGutterNextHunk)', 'Git Hunk'},
        ['e'] = {":m'>+<cr>gv=gv", 'Exchange Below'},
        ['f'] = 'Next File',
        ['L'] = 'which_key_ignore',
        ['l'] = 'which_key_ignore',
        ['n'] = 'which_key_ignore',
        ['P'] = 'Put Above?',
        ['p'] = 'Put Below?',
        ['Q'] = 'Last quickfix item',
        ['q'] = 'Next quickfix item',
        ['T'] = 'which_key_ignore',
        ['t'] = 'which_key_ignore',
        ['u'] = 'which_key_ignore',
        ['uu'] = 'which_key_ignore',
        ['v'] = 'which_key_ignore',
        ['x'] = 'which_key_ignore',
        ['xx'] = 'which_key_ignore',
        ['y'] = 'which_key_ignore',
        ['yy'] = 'which_key_ignore'
    }
    -- }}} right bracket
})

-- visual mode {{{
  wk.register({
      ["\\"] = {
          ['s'] = {"<cmd>AnyJumpVisual<cr>", 'Anyjump'},
          -- ['f'] = {"<plug>(operator-esearch-prefill)", 'Search word in (object)'},
          ['x'] = {"<plug>(mkdx-checkbox-next-v)", 'Checkbox in markdown'}
      }
  }, {mode = 'v'})
-- }}} visual

-- brackets {{{ "
  -- map("[x",     "<Plug>(mkdx-checkbox-next-v)",        { silent = true })
  -- map("]x",     "<Plug>(mkdx-checkbox-next-n)",        { silent = true })
  -- s_nmap("[c",     "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'", { expr = true })
  -- s_nmap("]c",     "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'", { expr = true })
  if plugin_loaded("nvim-bufferline.lua") then
      s_nmap("]b", ":BufferLineCycleNext<CR>")
      s_nmap("[b", ":BufferLineCyclePrev<CR>")
  end
-- }}} brackets "

-- "Builtins" {{{
  s_nmap("s", "<nop>")
  s_nmap("//", ":nohlsearch<cr>")
  s_nmap("Z", "za")
  s_nmap("Y", "y$")
  s_nmap("H", "^")
  s_nmap("L", "$")
  s_nmap("gV", "`[v`]")
  s_nmap("{", [[:<c-u>call BracketMotion("up", v:count)<CR>]])
  s_nmap("}", [[:<c-u>call BracketMotion("down", v:count)<CR>]])
  s_nmap("j", "(v:count == 0 ? 'gj' : 'j')", {expr = true})
  s_nmap("k", "(v:count == 0 ? 'gk' : 'k')", {expr = true})
  s_xmap("Y", "y$")
  s_xmap("H", "^")
  s_xmap("L", "$")
  s_xmap("<", "<gv")
  s_xmap(">", ">gv")
  s_xmap("@", ":norm@")
  s_xmap('?!', '"gy<Esc>:call LuckySearch()<CR>')
  s_xmap('??', '"gy<Esc>:call GoogleSearch()<CR>')
  s_xmap('S', 'sa')
  s_nmap('p', 'p`[v`]=')
  s_nmap('P', 'P`[v`]=')
  s_vmap('p', '"_dP`[v`]=')
-- }}} "Builtins"

-- Normal maps {{{ "
  nmap("zM", "zM:echo &foldlevel<cr>", {noremap = true})
  nmap("zR", "zR:echo &foldlevel<cr>", {noremap = true})
  nmap("zm", "zm:echo &foldlevel<cr>", {noremap = true})
  nmap("zr", "zr:echo &foldlevel<cr>", {noremap = true})
  s_nmap("!", ":Neoformat<CR>")
  s_nmap("-", ":Switch<CR>")
  s_nmap(";", ":Buffers<CR>")
  s_nmap("<C-P>", ":Files<CR>")
  s_nmap("<Del>", ":A<cr>")
  s_nmap("<Down>", ":call animate#window_delta_height(15)<CR>", {noremap = true})
  s_nmap("<Left>", ":call animate#window_delta_width(-30)<CR>", {noremap = true})
  s_nmap("<Right>", ":call animate#window_delta_width(30)<CR>", {noremap = true})
  s_nmap("<Up>", ":call animate#window_delta_height(-15)<CR>", {noremap = true})
  s_nmap("<s-tab>", "<c-w>w")
  s_nmap("Q", ":Sayonara<cr>")
  s_nmap("S", ":call BreakHere()<CR>")
  s_nmap("dh", ":Deleft<CR>")
  s_nmap("ga", "<Plug>(EasyAlign)")
  s_nmap("gb", "<Plug>(gh-line)")
  s_nmap("ghf", ":GitGutterFold<CR>")
  s_nmap("ghp", ":GitGutterPreviewHunk<CR>")
  s_nmap("ghq", ":GitGutterQuickFix<CR>")
  s_nmap("ghs", ":GitGutterStageHunk<CR>")
  s_nmap("ghu", ":GitGutterUndoHunk<CR>")
  s_nmap("glb", "<Plug>(gh-line-blame)")
  s_nmap("sJ", ":SplitjoinSplit<cr>")
  s_nmap("sK", ":SplitjoinJoin<cr>")
  s_nmap("sj", ":SplitjoinSplit<cr>")
  s_nmap("sk", ":SplitjoinJoin<cr>")

  s_xmap("<cr>", "<Plug>(LiveEasyAlign)")
  s_xmap("ga", "<Plug>(LiveEasyAlign)")
-- }}} Normal maps "

-- command mode {{{ "
  vim.api.nvim_set_keymap('c', '<c-r><c-r>', ':call fzf#vim#commands()<CR>',
                          {nowait = true})
  vim.cmd([[cabbr <expr> %% expand('%:p:h')]])
-- }}} command mode "

-- Text objects {{{ "
  s_omap('ig', '<Plug>(GitGutterTextObjectInnerPending)')
  s_omap('ag', '<Plug>(GitGutterTextObjectOuterPending)')
  s_xmap('ig', '<Plug>(GitGutterTextObjectInnerVisual)')
  s_xmap('ag', '<Plug>(GitGutterTextObjectOuterVisual)')
  s_omap('aa', '<Plug>SidewaysArgumentTextobjA')
  s_omap('ia', '<Plug>sidewaysargumenttextobji')
  s_xmap('aa', '<Plug>sidewaysargumenttextobja')
  s_xmap('ia', '<Plug>SidewaysArgumentTextobjI')

  -- Doesn't work with ruby :(
  -- s_omap('if', 'TSTextobjectSelect @function.inner<CR>')
  -- s_omap('af', 'TSTextobjectSelect @function.outer<CR>')
  -- s_xmap('if', 'TSTextobjectSelect @function.inner<CR>')
  -- s_xmap('af', 'TSTextobjectSelect @function.outer<CR>')
-- " }}} Text objects "

-- * and / commands {{{ "
  if plugin_loaded("nvim-hlslens") then
      s_nmap("n",
            "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>",
            {noremap = true})
      s_nmap("N",
            "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>",
            {noremap = true})

      s_nmap("*", "*``<Cmd>lua require('hlslens').start()<CR>", {noremap = true})
      s_nmap("#", "#``<Cmd>lua require('hlslens').start()<CR>", {noremap = true})
      s_nmap("g*", "g*<Cmd>lua require('hlslens').start()<CR>", {noremap = true})
      s_nmap("g#", "g#<Cmd>lua require('hlslens').start()<CR>", {noremap = true})

      -- s_xmap("*", ":<C-u>call VSetSearch('/')<CR>/<C-R>=@/<CR><CR>``<Cmd>lua require('hlslens').start()<CR>", {noremap = true})
      -- s_xmap("#", ":<C-u>call VSetSearch('?')<CR>?<C-R>=@/<CR><CR>``<Cmd>lua require('hlslens').start()<CR>", {noremap = true})
  end
-- }}} * and / commands "

-- terminal {{{
  tmap("<s-tab>", "<c-w>w", {silent = true, noremap = true})
  tmap("<leader><leader>", "<C-\\><C-n>:FloatermToggle!<CR>", {silent = true, noremap = true})
-- }}} terminal

-- commands {{{
  vim_command [[Eauto     execute "e $DOTFILES/home/vim/vimscript/autocommands.vim"]]
  vim_command [[Emap      execute "e $DOTFILES/home/vim/lua/mappings.lua"]]
  vim_command [[Eplugin   execute "e $DOTFILES/home/vim/lua/plugins.lua"]]
  vim_command [[Epack     execute "e $DOTFILES/home/vim/vimscript/plugins.vim"]]
  vim_command [[Ecomp     execute "e $DOTFILES/home/vim/lua/completions.lua"]]
  vim_command [[Efunction execute "e $DOTFILES/home/zsh/commands.sh"]]
  vim_command [[Eprivate  execute "e $DOTFILES/home/zsh/private/private.zsh"]]
  vim_command [[Ealiases  execute "e $DOTFILES/home/zsh/commands.sh"]]
  vim_command [[Etmux     execute "e $DOTFILES/home/tmux.conf"]]
  vim_command [[Ezshrc    execute "e $DOTFILES/home/zshrc"]]
  vim_command [[Egit      execute "e $DOTFILES/home/gitconfig"]]
  vim_command [[Edotfiles execute "Dotfiles"]]
  vim_command [[Ezsh      execute "Files $DOTFILES/home/zsh"]]
  vim_command [[Esnip     execute "Files $HOME/.vsnip/"]]
-- }}} commands
