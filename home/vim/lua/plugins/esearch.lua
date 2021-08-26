local M = {
  "eugen0329/vim-esearch",
  enabled = true,

}

function M.config()
  -- vim.cmd('let g:esearch.default_mappings = 0')

vim.g.esearch = {
    default_mappings = 1,
    before = 1,
    after = 1,
    backend = "nvim",
    win_map = {
        {"n", "o", "<plug>(esearch-win-open)", {nowait = 1}},
        {"n", "R", "<plug>(esearch-win-reload)"},
        {"n", "t", "<plug>(esearch-win-tabopen)"},
        {"n", "T", "<plug>(esearch-win-tabopen:stay)"},
        -- { 'n', 'o', '<plug>(esearch-win-split)',}, -- removed default
        -- { 'n', 'O', '<plug>(esearch-win-split:reuse:stay)', }, -- removed default
        {"n", "s", "<plug>(esearch-win-vsplit)"},
        {"n", "S", "<plug>(esearch-win-vsplit:reuse:stay)"},
        {"n", "<cr>", "<plug>(esearch-win-open)"},
        {"n", "p", "<plug>(esearch-win-preview)"},
        {"n", "P", "100<plug>(esearch-win-preview:enter)"},
        {"n", "<esc>", "<plug>(esearch-win-preview:close)"},
        {" ", "J", "<plug>(esearch-win-jump:entry:down)"},
        {" ", "K", "<plug>(esearch-win-jump:entry:up)"},
        {" ", "}", "<plug>(esearch-win-jump:filename:down)"},
        {" ", "{", "<plug>(esearch-win-jump:filename:up)"},
        {" ", ")", "<plug>(esearch-win-jump:dirname:down)"},
        {" ", "(", "<plug>(esearch-win-jump:dirname:up)"},
        {"ov", "im", "<plug>(textobj-esearch-match-i)"},
        {"ov", "am", "<plug>(textobj-esearch-match-a)"},
        {"ic", "<cr>", "<plug>(esearch-cr)", {nowait = 1}},
        {"n", "I", "<plug>(esearch-I)"}, {"x", "x", "<plug>(esearch-d)"},
        {"nx", "d", "<plug>(esearch-d)"}, {"n", "dd", "<plug>(esearch-dd)"},
        {"nx", "c", "<plug>(esearch-c)"}, {"n", "cc", "<plug>(esearch-cc)"},
        {"nx", "C", "<plug>(esearch-C)"}, {"nx", "D", "<plug>(esearch-D)"},
        {"x", "s", "<plug>(esearch-c)"}, {"n", ".", "<plug>(esearch-.)"},
        {"n", "@:", "<plug>(esearch-@:)"}, {"n", "za", "<plug>(esearch-za)"},
        {"n", "zc", "<plug>(esearch-zc)"}, {"n", "zM", "<plug>(esearch-zM)"}
    }
}


  local esearch = vim.api.nvim_create_augroup("esearch", { clear = true })

  vim.api.nvim_create_autocmd('Filetype', {
    group = esearch,
    pattern = { 'esearch' },
    command = 'setlocal cmdheight=2'
  })

-- vim.api.nvim_exec(
-- [[
-- let g:esearch.win_new = {esearch ->
-- \ esearch#buf#goto_or_open(esearch.name, {name ->
-- \   nvim_open_win(bufadd(name), v:true, {
--   \     'relative': 'editor',
--   \     'row': &lines / 10,
--   \     'col': &columns / 10,
--   \     'width': &columns * 8 / 10,
--   \     'height': &lines * 8 / 10
--   \   })
--   \ })
--   \}
--   " Close the floating window when opening an entry.
--   autocmd User esearch_win_config autocmd BufLeave <buffer> quit
--   ]],
--   true)

s_nmap("<F55>", "<Plug>(esearch)")
s_nmap("<m-f>", "<Plug>(esearch)")
s_nmap("<leader>f", "<Plug>(operator-esearch-prefill)", {}, "project search (object)" )

-- s_nmap("<space>ff", "<Plug>(esearch)")
-- s_nmap("<space>f", "<plug>(operator-esearch-prefill)")

-- " Search for debugger statements instantly (without starting the prompt).
-- nnoremap <leader>fd :call esearch#init({'pattern': '\b(ipdb\|debugger)\b', 'regex': 1})<cr>
--
-- " Search in front-end files using explicitly set paths.
-- " NOTE It requires `set shell=bash\ -O\ globstar\ -O\ extglob` and GNU bash available
-- " (type `$ brew install bash` if OSX is used).
-- nnoremap <leader>fe :call esearch#init({'paths': '**/*.{js,css,html}'})<cr>
-- " or if one of ag, rg or ack is available
-- nnoremap <leader>fe :call esearch#init({'filetypes': 'js css html'})<cr>
--
-- " Use a callable prefiller to search python functions.
-- " Rough equivalent of 'def ${VISUAL}$0(' expansion in snippets.
-- vnoremap <expr><leader>fp esearch#prefill({'prefill': [{VISUAL-> "def ".VISUAL()."(\<left>"}]})
-- nnoremap <leader>fp :call esearch#init({'prefill': [{VISUAL-> "def ".VISUAL()."(\<left>"}]})<cr>
--
-- " esearch#prefill() can be used as an operator. Use '<leader>fl' in visual mode or with
-- " a text-object like '<leader>fli(' to search for the selected text in lib directories.
-- noremap  <expr><leader>fl  esearch#prefill({'paths': $GOPATH.' node_modules/'})
-- nnoremap <leader>fll :call esearch#init({'paths': $GOPATH.' node_modules/'})<cr>

-- "   Keymap |     What it does
-- " ---------+---------------------------------------------------------------------------------------------
-- "    yf    | Yank a hovered file absolute path.
-- "    t     | Use a custom command to open the file in a tab.
-- "    +     | Render [count] more lines after a line with matches. Ex: + adds 1 line, 10+ adds 10.
-- "    -     | Render [count] less lines after a line with matches. Ex: - hides 1 line, 10- hides 10.
-- "    gq    | Populate QuickFix list using results of the current pattern search.
-- "    gsp   | Sort the results by path. NOTE that it's search util-specific.
-- "    gsd   | Sort the results by modification date. NOTE that it's search util-specific.
--
-- " Each definition contains nvim_set_keymap() args: [{modes}, {lhs}, {rhs}].
-- let g:esearch.win_map = [
--  \ ['n', 'yf',  ':call setreg(esearch#util#clipboard_reg(), b:esearch.filename())<cr>'],
--  \ ['n', 't',   ':call b:esearch.open("NewTabdrop")<cr>'                              ],
--  \ ['n', '+',   ':call esearch#init(extend(b:esearch, AddAfter(+v:count1)))<cr>'      ],
--  \ ['n', '-',   ':call esearch#init(extend(b:esearch, AddAfter(-v:count1)))<cr>'      ],
--  \ ['n', 'gq',  ':call esearch#init(extend(copy(b:esearch), {"out": "qflist"}))<cr>'  ],
--  \ ['n', 'gsp', ':call esearch#init(extend(b:esearch, sort_by_path))<cr>'             ],
--  \ ['n', 'gsd', ':call esearch#init(extend(b:esearch, sort_by_date))<cr>'             ],
--  \]

-- " Helpers to use in keymaps.
-- let g:sort_by_path = {'adapters': {'rg': {'options': '--sort path'}}}
-- let g:sort_by_date = {'adapters': {'rg': {'options': '--sort modified'}}}
-- " {'backend': 'system'} means synchronous reload using system() call to stay within the
-- " same context
-- let g:AddAfter = {n -> {'after': b:esearch.after + n, 'backend': 'system'}}


-- <leader>ff	Open the search pattern input prompt [global]
-- <leader>f{textobj}	Start a new search for a text-object [global]
-- <c-r><c-r> /
-- <c-s><c-s> /
-- <c-t><c-t>	Cycle through regex/case/text-object modes [prompt]
-- <c-o>	Open the menu [prompt]
-- <cr> / o / s / t	Open a search result entry in the current window/vertical split/horizontal split/new tab [window]
-- O / S / T	Same as above, but stay in the window [window]
-- K / J	Jump to the previous/next search entry [window]
-- { / }	Jump to the previous/next filename [window]
-- ( / )	Jump to the previous/next filename from another directory [window]
-- cim / dim / vim	Jump to the next match and change/delete/select it [window]
-- cam / dam / vam	Same as above, but capture trailing whitespaces as well [window]
-- :write<cr>	Write changes into files [window]
-- p / P	Zoom/enter the preview window [window]
end

return M
