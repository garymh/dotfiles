local M = {
  "chrisgrieser/nvim-various-textobjs",
  dependencies = {
    "coderifous/textobj-word-column.vim",
    "echasnovski/mini.ai",
  },

  init = function()
    vim.g.skip_default_textobj_word_column_mappings = true
  end,
}

-- https://github.com/smjonas/duplicate.nvim

function M.config()
  require('mini.ai').setup({
    around_next = '',
    inside_next = '',
    around_last = '',
    inside_last = '',
    custom_textobjects = {
      j = { { '%b()', '%b[]', '%b{}' }, '^.().*().$' },
    }

  })

  s_omap("io", [[:call TextObjWordBasedColumn("aw")<CR>]], {}, "inner word in column")
  s_omap("ao", [[:call TextObjWordBasedColumn("iw")<CR>]], {}, "around word in column")
  s_vmap("io", [[:<C-U>call TextObjWordBasedColumn("aw")<CR>]], {}, "inner word in column")
  s_vmap("ao", [[:<C-U>call TextObjWordBasedColumn("iw")<CR>]], {}, "around word in column")
  s_omap("iO", [[:call TextObjWordBasedColumn("aW")<CR>]], {}, "inner WORD in column")
  s_omap("aO", [[:call TextObjWordBasedColumn("iW")<CR>]], {}, "around WORD in column")
  s_vmap("iO", [[:<C-U>call TextObjWordBasedColumn("aW")<CR>]], {}, "inner WORD in column")

  -- s_vmap("il", [[g_o^]], {}, "inner line (no indent)")
  -- s_omap("il", [[:normal vil<CR>]], {}, "inner line (no indent)")
  -- s_vmap("il", [[$o^]], {}, "outer line (with indent)")
  -- s_omap("il", [[:normal val<CR>]], {}, "outer line (with indent)")

  local textobjs = require("various-textobjs")
  textobjs.setup({ useDefaultKeymaps = false })

  s_omap("ii", function() textobjs.indentation(true, true) end, {}, "within indent")
  s_omap("ai", function() textobjs.indentation(false, true) end, {}, "around indent")
  s_vmap("ii", function() textobjs.indentation(true, true) end, {}, "within indent")
  s_vmap("ai", function() textobjs.indentation(false, true) end, {}, "around indent")

  s_omap("iI", function() textobjs.indentation(true, false) end, {}, "inner indentation level")
  s_omap("aI", function() textobjs.indentation(false, false) end, {}, "an indentation level and line above")
  s_vmap("iI", function() textobjs.indentation(true, false) end, {}, "inner indentation level")
  s_vmap("aI", function() textobjs.indentation(false, false) end, {}, "an indentation level and line above and below")

  s_omap("il", function() textobjs.lineCharacterwise(true) end, {}, "inner line")
  s_vmap("il", function() textobjs.lineCharacterwise(true) end, {}, "outer line")
  s_omap("al", function() textobjs.lineCharacterwise(false) end, {}, "inner line")
  s_vmap("al", function() textobjs.lineCharacterwise(false) end, {}, "outer line")

  s_omap("im", function() textobjs.chainMember(true) end, {}, "inner method chain")
  s_vmap("im", function() textobjs.chainMember(true) end, {}, "outer method chain")
  s_omap("am", function() textobjs.chainMember(false) end, {}, "inner method chain")
  s_vmap("am", function() textobjs.chainMember(false) end, {}, "outer method chain")

  s_omap("iD", function() textobjs.restOfIndentation(true, false) end, {}, "rest of indentation")
  s_omap("aD", function() textobjs.restOfIndentation(false, false) end, {}, "inner indentation level")
  s_vmap("iD", function() textobjs.restOfIndentation(true, false) end, {}, "rest of indentation")
  s_vmap("aD", function() textobjs.restOfIndentation(false, false) end, {}, "rest of indentation")

  s_omap("i|", function() textobjs.column(true) end, {}, "column")
  s_vmap("i|", function() textobjs.column(true) end, {}, "column")

  s_omap("ae", function() textobjs.entireBuffer(true) end, {}, "entire buffer")
  s_vmap("ae", function() textobjs.entireBuffer(true) end, {}, "entire buffer")

  s_omap("iC", function() textobjs.mdFencedCodeBlock(true) end, {}, "inner markdown codeblock")
  s_omap("aC", function() textobjs.mdFencedCodeBlock(false) end, {}, "around markdown codeblock")
  s_vmap("iC", function() textobjs.mdFencedCodeBlock(true) end, {}, "inner markdown codeblock")
  s_vmap("aC", function() textobjs.mdFencedCodeBlock(false) end, {}, "around markdown codeblock")

  s_omap("ik", function() textobjs.key(true) end, {}, "inner key-value key")
  s_omap("ak", function() textobjs.key(false) end, {}, "around key-value key")
  s_vmap("ik", function() textobjs.key(true) end, {}, "inner key-value key")
  s_vmap("ak", function() textobjs.key(false) end, {}, "around key-value key")

  s_omap("iv", function() textobjs.value(true) end, {}, "inner key-value value")
  s_omap("av", function() textobjs.value(false) end, {}, "around key-value value")
  s_vmap("iv", function() textobjs.value(true) end, {}, "inner key-value value")
  s_vmap("av", function() textobjs.value(false) end, {}, "around key-value value")

  s_omap("iz", function() textobjs.closedFold(true) end, {}, "inner closed fold")
  s_omap("az", function() textobjs.closedFold(false) end, {}, "around closed fold")
  s_vmap("iz", function() textobjs.closedFold(true) end, {}, "inner closed fold")
  s_vmap("az", function() textobjs.closedFold(false) end, {}, "around closed fold")

  s_omap("iS", function() textobjs.subword(true) end, {}, "inner subword")
  s_omap("aS", function() textobjs.subword(false) end, {}, "around subword")
  s_vmap("iS", function() textobjs.subword(true) end, {}, "inner subword")
  s_vmap("aS", function() textobjs.subword(false) end, {}, "around subword")

  s_omap("iu", function() textobjs.url(true) end, {}, "inner url")
  s_omap("au", function() textobjs.url(false) end, {}, "around url")
  s_vmap("iu", function() textobjs.url(true) end, {}, "inner url")
  s_vmap("au", function() textobjs.url(false) end, {}, "around url")

  s_omap("ih", function() textobjs.entireLine() end, {}, "inner url")
  s_omap("ah", function() textobjs.entireLine() end, {}, "around url")
  s_vmap("ih", function() textobjs.entireLine() end, {}, "inner url")
  s_vmap("ah", function() textobjs.entireLine() end, {}, "around url")

  s_omap("iP", function() textobjs.shellPipe() end, {}, "inner UNIX pipe")
  s_omap("aP", function() textobjs.shellPipe() end, {}, "around UNIX pipe")
  s_vmap("iP", function() textobjs.shellPipe() end, {}, "inner UNIX pipe")
  s_vmap("aP", function() textobjs.shellPipe() end, {}, "around UNIX pipe")

  vim.keymap.set("n", "dsi", function()
    -- select inner indentation
    textobjs.indentation(true, true)

    -- plugin only switches to visual mode when textobj found
    local notOnIndentedLine = vim.fn.mode():find("V") == nil
    if notOnIndentedLine then return end

    -- dedent indentation
    vim.cmd.normal { ">", bang = true }

    -- delete surrounding lines
    local endBorderLn = vim.api.nvim_buf_get_mark(0, ">")[1] + 1
    local startBorderLn = vim.api.nvim_buf_get_mark(0, "<")[1] - 1
    vim.cmd(tostring(endBorderLn) .. " delete") -- delete end first so line index is not shifted
    vim.cmd(tostring(startBorderLn) .. " delete")
  end, { desc = "Delete surrounding indentation" })
end

return M
