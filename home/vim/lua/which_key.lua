-- vi: foldmethod=marker

-- SPACEBAR {{{ "
vim.g.which_key_space = {
    ['name'] = 'Spacebar',
    ['<SPACE>'] = "Alternate file",
    ['-'] = 'Horiz. Window',
    ['1'] = 'Rails models',
    ['2'] = 'Rails specs',
    ['3'] = 'Lib directory',
    [';'] = 'Commands',
    ['['] = 'Previous File',
    [']'] = 'Next File',
    [';'] = 'Vim Commands',
    ['a'] = 'File Drawer',
    ['c'] = 'Git Commits',
    ['e'] = {
        ['name'] = 'Editing...',
        ['a'] = 'Auto Commands',
        ['c'] = 'Completions',
        ['d'] = 'Dotfiles',
        ['e'] = '.zshenv',
        ['f'] = 'ZSH funcitons',
        ['i'] = 'Install Plugins',
        ['m'] = 'Edit Mappings',
        ['p'] = 'Edit Plugins',
        ['p'] = 'Edit Plugin Settings',
        ['sd'] = 'File Type Detect',
        ['sp'] = 'File Type Plugins',
        ['t'] = 'Edit Tmux',
        ['u'] = 'Plugin Update',
        ['v'] = 'Edit .vimrc',
        ['z'] = 'Edit .zshrc'
    },
    ['f'] = 'Search in project...',
    ['g'] = 'Git Files',
    ['h'] = 'Help docs',
    ['n'] = 'New File in Directory',
    ['r'] = 'File history',
    ['s'] = 'Snippet files',
    ['t'] = 'Edit Temp File',
    ['w'] = 'Show file in sidebar',
    ['z'] = 'File Drawer'
}
-- }}} SPACEBAR "

-- leader {{{ "
vim.g.which_key_leader = {
    ['name'] = 'Leader',
    [','] = 'Back a file',
    ['='] = 'Vim Split Pane',
    ['T'] = 'Test whole file',
    ['c'] = 'Copy and comment line',
    ['e'] = 'Side ZSH window',
    ['g'] = 'LazyGit',
    ['i'] = 'Add the last line from pry',
    ['l'] = 'Repeat last test',
    ['p'] = 'Paste from clipboard',
    ['r'] = 'System Resources',
    ['t'] = 'Run current test',
    ['v'] = 'Visit current test',
    ['w'] = 'Save',
    ['y'] = 'Copy line to clipboard',
    ['z'] = 'Floating ZSH'
}
-- }}} leader "

-- local leader {{{ "
vim.g.which_key_localleader = {
    ['name'] = 'Local Leader',
    -- ['TAB']  = 'Add Argument After',
    -- ['`']    = 'Add Argument First',
    ['='] = 'Align equals in paragraph',
    ['b'] = 'Git blame line',
    ['f'] = 'Search word in project',
    ['p'] = {
        ['name'] = 'Pry',
        ['c'] = 'Toggle pry commenting',
        ['d'] = 'Delete all prys',
        ['p'] = 'Add a pry'
    },
    ['s'] = 'Find definition (anyjump)',
    ['u'] = 'Undo git hunk',
    ['x'] = 'Mark checkboxes',
    ['y'] = 'Copy path to clipboard',
    ['\\'] = 'Toggle argument wrap'
}
-- }}} local leader "

-- toggles {{{ "
vim.g.which_key_toggles = {
    ['name'] = 'Toggles',
    ['+'] = 'Both Cursor Options',
    ['-'] = 'Cursorline',
    ['_'] = 'Cursorline',
    ['a'] = 'ALE Checks',
    ['b'] = 'Background',
    ['c'] = 'Cursorline',
    ['d'] = 'Diffs',
    ['g'] = 'Git Gutter Line Highlights',
    ['h'] = 'Hlsearch',
    ['i'] = 'Ignore Case',
    ['l'] = 'List',
    ['n'] = 'Numbers',
    ['p'] = 'Paste Mode',
    ['r'] = 'Relative Number',
    ['s'] = 'Spelling',
    ['u'] = 'Cursor Column',
    ['v'] = 'Virtual Edit',
    ['w'] = 'Wrapping',
    ['x'] = 'Both Cursor Options',
    ['|'] = 'Cursor Column'
}
-- }}} toggles "

-- brackets {{{ "
-- left bracket {{{ "
vim.g.which_key_leftbracket = {
    ['name'] = 'Left Bracket',
    ['<C-L>'] = 'which_key_ignore',
    ['<C-Q>'] = 'which_key_ignore',
    ['<C-T>'] = 'which_key_ignore',
    ['!'] = 'Prev linter problem (ALE)',
    ['%'] = 'Prev matchit operator?',
    ["'"] = 'Prev marker?',
    ['-'] = 'Prev marker?',
    ['<TAB>'] = 'Sideways left',
    ['='] = 'Prev marker?',
    ['{']  = 'Prepend argument',
    ['['] = 'Prev function end',
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
    ['c'] = 'Git Hunk',
    ['e'] = 'Exchange Below',
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
}
-- }}} left bracket "

  -- right bracket {{{ "
    vim.g.which_key_rightbracket = {
        ['name']  = 'Right Bracket',
        ['<C-L>'] = 'which_key_ignore',
        ['<C-Q>'] = 'which_key_ignore',
        ['<C-T>'] = 'which_key_ignore',
        ['!']     = 'Next linter problem (ALE)',
        ['%']     = 'Next matchit operator?',
        ["'"]     = 'Next marker?',
        ['-']     = 'Next marker?',
        ['<TAB>'] = 'Sideways right',
        ['=']     = 'Next marker?',
        ['[']     = 'Next function end',
        ['}']     = 'Append argument',
        ['`']     = 'Next marker?',
        ['A']     = 'which_key_ignore',
        ["o"] = {
          ['name'] = 'Turn off...',
          ['+']    = 'Cusor Line AND Column',
          ['-']    = 'Cursor Line',
          ['_']    = 'Cursor Line',
          ['b']    = 'Light Background',
          ['c']    = 'Cursor Line',
          ['d']    = 'Diff This',
          ['h']    = 'Search',
          ['i']    = 'Ignore Case',
          ['l']    = 'List Characters',
          ['n']    = 'Numbers',
          ['p']    = 'Paste Mode',
          ['r']    = 'Relative Numbers',
          ['s']    = 'Spelling',
          ['u']    = 'Cursor Column',
          ['v']    = 'Virtual Edit',
          ['w']    = 'Wrap',
          ['x']    = 'Cusor Line AND Column',
          ['|']    = 'Cursor Column',
        },
        ['a']     = 'which_key_ignore',
        ['b']     = 'Next Buffer',
        ['B']     = 'Last Buffer',
        ['c']     = 'Git Hunk',
        ['e']     = 'Exchange Below',
        ['f']     = 'Next File',
        ['L']     = 'which_key_ignore',
        ['l']     = 'which_key_ignore',
        ['n']     = 'which_key_ignore',
        ['P']     = 'Put Above?',
        ['p']     = 'Put Below?',
        ['Q']     = 'Last quickfix item',
        ['q']     = 'Next quickfix item',
        ['T']     = 'which_key_ignore',
        ['t']     = 'which_key_ignore',
        ['u']     = 'which_key_ignore',
        ['uu']    = 'which_key_ignore',
        ['v']     = 'which_key_ignore',
        ['x']     = 'which_key_ignore',
        ['xx']    = 'which_key_ignore',
        ['y']     = 'which_key_ignore',
        ['yy']    = 'which_key_ignore'
    }

-- }}} right bracket"
-- }}} brackets "
-- right bracket {{{ "

vim.g.which_key_go = {
  ['name']  = 'Go to...',
  ['*']     = 'which_key_ignore',
  ['#']     = 'which_key_ignore',
  ['a']     = 'Easy Align',
  ['b']     = 'Point to line on website',
  ['c']     = 'Comment...',
  ['cc']     = 'Comment line',
  ['g']     = 'Top',
  ['h']     = 'which_key_ignore',
  ['o']     = 'Open URL?',
  ['oF']     = 'Open root folder in terminal',
  ['of']     = 'Open current folder in terminal',
  ['ot']     = 'Open root folder in Finder',
  ['oT']     = 'Open current folder in Finder',
  ['V']     = 'Last selection',
  ['x']     = 'Thing on cursor',
  ['%']     = 'Matchup',
  ['h'] = {
    ['name'] = 'Git',
    ['R']    = 'Reset entire buffer',
    ['r']    = 'Stage - undo hunk',
    ['s']    = 'Stage - stage hunk',
    ['u']    = 'Undo hunk',
    ['p']    = 'Preview hunk',
    ['b']    = 'Git Blame',
}
}
-- -- visual in  {{{
--   vim.g.which_key_visual_in = {
--     ['name']  = 'Visual in...'
--   }
-- -- }}} visual in

  -- vim.g.which_key_a_maps = {
  --   ['name']  = 'Visual in...',
  --   ['e']     = 'How about sutff'
  -- }

vim.call('which_key#register', '<Space>', "g:which_key_space")
vim.call('which_key#register', ',', "g:which_key_leader")
vim.call('which_key#register', '\\', "g:which_key_localleader")
vim.call('which_key#register', '[', "g:which_key_leftbracket")
vim.call('which_key#register', ']', "g:which_key_rightbracket")
vim.call('which_key#register', 'yo', "g:which_key_toggles")
vim.call('which_key#register', 'g', "g:which_key_go")
-- vim.call('which_key#register', 'a', "g:which_key_a_maps")
-- vim.call('which_key#register', 'i', "g:which_key_visual_in")

vim.api.nvim_set_keymap("n", "[", [[:<c-u>WhichKey '['<CR>]], {silent = true})
vim.api.nvim_set_keymap("n", "]", [[:<c-u>WhichKey ']'<CR>]], {silent = true})
vim.api.nvim_set_keymap("n", "<leader>", [[:<c-u>WhichKey '<leader>'<CR>]], {silent = true})
vim.api.nvim_set_keymap("n", "<space>", [[:<c-u>WhichKey '<space>'<CR>]], {silent = true})
vim.api.nvim_set_keymap("n", "<localleader>", [[:<c-u>WhichKey "\\"<CR>]], {silent = true})
vim.api.nvim_set_keymap("n", "yo", [[:<c-u>WhichKey 'yo'<CR>]], {silent = true})
-- vim.api.nvim_set_keymap("n", "g", [[:<c-u>WhichKey 'g'<CR>]], {silent = true})
-- s_nmap("gg",  "gg", {noremap = true})
-- s_nmap("gf",  "gf", {noremap = true})

-- vim.api.nvim_set_keymap("o", "a", [[:<c-u>WhichKeyVisual 'a'<CR>]], {silent = false})
-- vim.api.nvim_set_keymap("o", "i", [[:<c-u>WhichKey 'i'<CR>]], {silent = true})

vim.g.which_key_use_floating_win = 1
-- vim.g.which_key_fallback_to_native_key=1
vim.g.which_key_sep              = ':'
vim.g.which_key_vertical         = 0
