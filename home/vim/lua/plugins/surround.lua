local M = {
  "kylechui/nvim-surround",
  keys = { "ys", "cs", "ds" },
}

-- https://github.com/echasnovski/mini.surround
function M.config()
  require("nvim-surround").setup({
    highlight = {
      duration = 1000,
    },
    surrounds = {
      ["L"] = {
        find = "%[%[.-%]%]",
        add = { "[[", "]]" },
        delete = "(%[%[)().-(%]%])()",
        change = {
          target = "(%[%[)().-(%]%])()",
        },
      },
      ["F"] = {
        add = function() return { { "function() " }, { " end" } } end,
      },
      ["s"] = {
        add = function() return { { "string(" }, { ")" } } end,
      },
      ["l"] = {
        add = function()
          local clipboard = vim.fn.getreg("+"):gsub("\n", "")
          return {
            { "[" },
            { "](" .. clipboard .. ")" },
          }
        end,
        find = "%b[]%b()",
        delete = "^(%[)().-(%]%b())()$",
        change = {
          target = "^()()%b[]%((.-)()%)$",
          replacement = function()
            local clipboard = vim.fn.getreg("+"):gsub("\n", "")
            return {
              { "" },
              { clipboard },
            }
          end,
        },
      },
    },
    aliases = {
      ["a"] = ">",
      ["b"] = { "}", "]", ")", ">" },
      ["B"] = "}",
      ["r"] = "]",
      ["l"] = { "function() ", " end" },
      ["q"] = { '"', "'", "`" },
      ["j"] = { "}", "]", ")", ">", '"', "'", "`" },
    },
  })
end

return M
