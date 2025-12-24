vim.api.nvim_buf_create_user_command(0, "SortGitConfig", function()
  -- Sort sections.
  vim.cmd("silent %s/\\v\\n\\t/@@@/e")
  vim.cmd("%sort")
  vim.cmd("silent %s/\\v\\@\\@\\@/\\r\\t/ge")

  -- TODO: Sort within sections.
  -- TODO: Preserve comments.
  -- TODO: Deal with empty lines between sections.
end, { nargs = 0 })
