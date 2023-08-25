vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*note-body.txt", "*issue-body.txt", "*merge_request_description.txt" },
  callback = function()
    vim.opt_local.filetype = "markdown"
  end,
})
