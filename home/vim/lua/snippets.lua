local ls = require("luasnip")
local types = require("luasnip.util.types")
local s = ls.snippet
local f = ls.function_node
local i = ls.insert_node
local extras = require("luasnip.extras")
local sn = ls.snippet_node
local t = ls.text_node
local c = ls.choice_node
local rep = extras.rep
-- local isn = ls.indent_snippet_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
-- local fmt = require("luasnip.extras.fmt").fmt
-- local m = extras.m
-- local l = extras.l
-- local postfix = require("luasnip.extras.postfix").postfix

-- local genie = require("SnippetGenie")
--
-- genie.setup({
--   -- this must be configured
--   snippets_directory = os.getenv("HOME") .. "/.config/nvim/snippets/",
--
--   -- let's say you're creating a snippet for Lua,
--   -- SnippetGenie will look for the file at `/path/to/my/LuaSnip/snippet/folder/lua/generated.lua`
--   -- and add the new snippet there.
--   file_name = "generated",
-- })
--
-- -- SnippetGenie doesn't map any keys by default.
-- -- Here're the suggested mappings:
-- vim.keymap.set("x", "<M-CR>", function()
--   genie.create_new_snippet_or_add_placeholder()
--   vim.cmd("norm! �") -- exit Visual Mode, go back to Normal Mode
-- end, {})
--
-- vim.keymap.set("n", "<M-CR>", function()
--   genie.finalize_snippet()
-- end, {})
--
-- -- local newline = function(text)
-- --   return t({ "", text })
-- -- end

ls.config.setup({
  -- history = true,
  -- enable_autosnippets = true,
  updateevents = "TextChanged,TextChangedI",
  region_check_events = "InsertEnter",
  delete_check_events = "TextChanged,InsertEnter",
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "●", "GitSignsChange" } },
      },
    },
    [types.insertNode] = {
      active = {
        virt_text = { { "●", "GitSignsAdd" } },
      },
    },
  },
})

require("luasnip.loaders.from_vscode").lazy_load()

ls.add_snippets("all", {
  s({ trig = "date" }, {
    f(function()
      return string.format(string.gsub(vim.bo.commentstring, "%%s", " %%s"), os.date())
    end, {}),
  }),
  s({ trig = "modeline" }, {
    f(function()
      return " " .. string.format(string.gsub(vim.bo.commentstring, "%%s", " %%s"), "vim: ft=")
    end, {}),
    i(1),
  }),
  s({ trig = "todo" }, {
    f(function()
      return " " .. string.format(string.gsub(vim.bo.commentstring, "%%s", " %%s"), "TODO: ")
    end, {}),
    i(1),
  }),
})

-- function systemClipboard()
--   return vim.fn.getreg("+", 1)
-- end
--
-- ls.env_namespace("SYS", { vars = { CLIPBOARD = systemClipboard } })
--
-- local function chopGithubUrl(text)
--   return string.gsub(text, "https://github.com/", "")
-- end
--
-- local function pluginUrl(text, no_config)
--   no_config = no_config or nil
--   local url = 'use({ "'
--   return url .. chopGithubUrl(text) .. (no_config and '" })' or '",')
-- end
--
-- local function makeBasicString(text)
--   return '"' .. chopGithubUrl(text) .. '",'
-- end

-- ls.add_snippets("lua", {
--   s({ trig = "use" }, {
--     c(1, {
--       sn(nil, { f(function(args, snip)
--         return pluginUrl(snip.snippet.env.SYS_CLIPBOARD, true)
--       end), i(1) }),
--       sn(
--         nil,
--         { f(function(args, snip)
--           return pluginUrl(snip.snippet.env.SYS_CLIPBOARD)
--         end), t({ "", "  config = [[require('config." }), i(1, "config_name"), t({
--           "')]],",
--           "})",
--         }) }
--       ),
--       sn(
--         nil,
--         {
--           f(function(args, snip)
--             return pluginUrl(snip.snippet.env.SYS_CLIPBOARD)
--           end),
--           t({ "", "  config = function()", '    require("' }),
--           i(1, "config_name"),
--           t({ '").setup()', "  end,", "})" }),
--         }
--       ),
--     }),
--   }),
--
--   s({ trig = "requse" }, {
--     f(function(args, snip)
--       return makeBasicString(snip.env.SYS_CLIPBOARD)
--     end),
--   }),
--
--   s({ trig = "lazym" }, {
--     t("M = {"),
--     newline(""),
--     t("  "),
--     i(1),
--     newline(""),
--     t("}"),
--     newline(""),
--     newline(""),
--     t("function M.config()"),
--     newline(""),
--     t("  "),
--     i(2),
--     newline(""),
--     t("end"),
--     newline(""),
--     newline(""),
--     t("return M"),
--     -- rep(1),
--   }),
--
--   s({ trig = "vimf" }, {
--     t("-- "),
--     i(1),
--     t(" {{{"),
--     newline(""),
--     t("  "),
--     i(2),
--     newline(""),
--     t("-- }}} "),
--     rep(1),
--   }),
-- })

-- set keybinds for both INSERT and VISUAL.
-- vim.api.nvim_set_keymap("i", "<C-n>", "<Plug>luasnip-next-choice", {})
-- vim.api.nvim_set_keymap("s", "<C-n>", "<Plug>luasnip-next-choice", {})
-- vim.api.nvim_set_keymap("i", "<C-p>", "<Plug>luasnip-prev-choice", {})
-- vim.api.nvim_set_keymap("s", "<C-p>", "<Plug>luasnip-prev-choice", {})
-- imap("<c-u>", require("luasnip.extras.select_choice"))
vim.keymap.set("n", "<leader>sn", "<cmd>source ~/.config/nvim/lua/snippets.lua<CR>", {}, "Edit snippets file")
