local M = {
  "pechorin/any-jump.vim",
}

function M.config()
  vim.g.any_jump_list_numbers                 = 0
  vim.g.any_jump_references_enabled           = 1
  vim.g.any_jump_grouping_enabled             = 0
  vim.g.any_jump_preview_lines_count          = 5
  vim.g.any_jump_max_search_results           = 7
  vim.g.any_jump_search_prefered_engine       = "rg"
  vim.g.any_jump_results_ui_style             = "filename_first"
  vim.g.any_jump_window_width_ratio           = 0.8
  vim.g.any_jump_window_height_ratio          = 0.8
  vim.g.any_jump_window_top_offset            = 4
  vim.g.any_jump_disable_default_keybindings  = 1
  vim.g.any_jump_remove_comments_from_results = 1
  vim.g.any_jump_keyword_match_cursor_mode    = "word"

  vim.g.any_jump_colors = {
    plain_text         = "Comment",
    preview            = "Comment",
    preview_keyword    = "Operator",
    heading_text       = "Function",
    heading_keyword    = "Identifier",
    group_text         = "Comment",
    group_name         = "Function",
    more_button        = "Operator",
    more_explain       = "Comment",
    result_line_number = "Comment",
    result_text        = "Statement",
    result_path        = "String",
    help               = "String",
  }

  nmap([[<C-\>]], "<CMD>AnyJump<CR>")
end

return M
