local M = {
  'nvim-mini/mini.nvim',
  version = false,
  event = "VeryLazy",
  dependencies = {
    "folke/which-key.nvim",
  },
}

function M.config()
  -- mini.files
  s_nmap('<leader>e', function()
    local bufname = vim.api.nvim_buf_get_name(0)
    local path = vim.fn.fnamemodify(bufname, ':p')

    if path and vim.uv.fs_stat(path) then
      require('mini.files').open(bufname, false)
    end
  end, 'File explorer')

  local minifiles = require 'mini.files'

  minifiles.setup({
    mappings = {
      show_help = '?',
      go_in_plus = '<cr>',
      go_out_plus = '<tab>',
    },
    content = {
      filter = function(entry)
        return entry.fs_type ~= 'file' or entry.name ~= '.DS_Store'
      end,
      sort = function(entries)
        local function compare_alphanumerically(e1, e2)
          if e1.is_dir and not e2.is_dir then
            return true
          end
          if not e1.is_dir and e2.is_dir then
            return false
          end
          if e1.pre_digits == e2.pre_digits and e1.digits ~= nil and e2.digits ~= nil then
            return e1.digits < e2.digits
          end
          return e1.lower_name < e2.lower_name
        end

        local sorted = vim.tbl_map(function(entry)
          local pre_digits, digits = entry.name:match '^(%D*)(%d+)'
          if digits ~= nil then
            digits = tonumber(digits)
          end

          return {
            fs_type = entry.fs_type,
            name = entry.name,
            path = entry.path,
            lower_name = entry.name:lower(),
            is_dir = entry.fs_type == 'directory',
            pre_digits = pre_digits,
            digits = digits,
          }
        end, entries)
        table.sort(sorted, compare_alphanumerically)
        return vim.tbl_map(function(x)
          return { name = x.name, fs_type = x.fs_type, path = x.path }
        end, sorted)
      end,
    },
    windows = { width_nofocus = 25 },
    options = { permanent_delete = false },
  })

  vim.api.nvim_create_autocmd('User', {
    desc = 'Notify LSPs that a file was renamed',
    pattern = 'MiniFilesActionRename',
    callback = function(args)
      local changes = {
        files = {
          {
            oldUri = vim.uri_from_fname(args.data.from),
            newUri = vim.uri_from_fname(args.data.to),
          },
        },
      }
      local will_rename_method, did_rename_method =
          vim.lsp.protocol.Methods.workspace_willRenameFiles,
          vim.lsp.protocol.Methods.workspace_didRenameFiles
      local clients = vim.lsp.get_clients()
      for _, client in ipairs(clients) do
        if client:supports_method(will_rename_method) then
          local res = client:request_sync(will_rename_method, changes, 1000, 0)
          if res and res.result then
            vim.lsp.util.apply_workspace_edit(res.result, client.offset_encoding)
          end
        end
      end

      for _, client in ipairs(clients) do
        if client:supports_method(did_rename_method) then
          client:notify(did_rename_method, changes)
        end
      end
    end,
  })

  -- mini.keymap
  local action = function() vim.cmd('nohlsearch') end
  require('mini.keymap').map_combo({ 'n', 'i', 'x', 'c' }, '<Esc><Esc>', action)

  -- mini.hipatterns
  local hipatterns = require('mini.hipatterns')
  hipatterns.setup({
    highlighters = {
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })

  -- mini.operators
  require("mini.operators").setup({
    multiply = { prefix = "yd" },
    evaluate = { prefix = "g=" },
    exchange = { prefix = "gX", reindent_linewise = true },
    replace  = { prefix = "" },
    sort     = { prefix = "" },
  })

  -- mini.ai + mini.extra
  local ai              = require("mini.ai")
  local spec_treesitter = ai.gen_spec.treesitter
  local gen_ai_spec     = require("mini.extra").gen_ai_spec

  ai.setup({
    custom_textobjects = {

      F = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),

      D = { "()%d%d%d%d%-%d%d%-%d%d()" },

      S = { { '%u[%l%d]+%f[^%l%d]', '%f[%S][%l%d]+%f[^%l%d]', '%f[%P][%l%d]+%f[^%l%d]', '^[%l%d]+%f[^%l%d]', }, '^().*()$' },

      U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }),

      c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),

      e = gen_ai_spec.buffer(),

      j = { { "%b()", "%b[]", "%b{}", "%b<>" }, "^.().*().$" },

      k = spec_treesitter({
        i = { "@assignment.lhs", "@key.inner" },
        a = { "@assignment.outer", "@key.inner" },
      }),

      h = spec_treesitter({ i = "@call.inner", a = "@call.outer" }),

      o = spec_treesitter({
        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
      }),

      r = spec_treesitter({ i = "@return.inner", a = "@return.outer" }),

      u = ai.gen_spec.function_call(),

      w = spec_treesitter({
        i = { "@assignment.rhs", "@key.inner" },
        a = { "@assignment.outer", "@key.inner" },
      }),

      x = spec_treesitter({ i = { "@assignment.lhs" }, a = { "@assignment.lhs" } }),

      y = spec_treesitter({ i = { "@assignment.rhs" }, a = { "@assignment.rhs" } }),

      z = spec_treesitter({ i = { "@statement.outer" }, a = { "@statement.outer" } }),

      ["-"] = gen_ai_spec.line(),

      ["!"] = gen_ai_spec.diagnostic(),

      ["/"] = spec_treesitter({ i = { "@regex.inner" }, a = { "@regex.outer" } }),

      ["#"] = gen_ai_spec.number(),
    },
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown" },
    callback = function()
      vim.b.miniai_config = {
        custom_textobjects = {
          F = false,
          c = false,
          h = false,
          k = false,
          o = false,
          r = false,
          w = false,
          x = false,
          y = false,
          z = false,
          ["/"] = false,
        },
      }
    end,
  })

  s_oxmap("L", "$", "endofline")
  vim.keymap.set({ "x", "o" }, "K", "g]j", { remap = true, desc = "end of brace" })
  vim.keymap.set({ "x", "o" }, "Q", "g]q", { remap = true, desc = "end of quote" })

  -- which-key descriptions for text objects
  local objects = {
    { " ", desc = "whitespace" },
    { "'", desc = "' string" },
    { "(", desc = "() block" },
    { ")", desc = "() block with ws" },
    { "-", desc = "line" },
    { "<", desc = "<> block" },
    { ">", desc = "<> block with ws" },
    { "?", desc = "user prompt" },
    { "D", desc = "date" },
    { "F", desc = "other? function" },
    { "L", desc = "to end of line" },
    { "S", desc = "subword" },
    { "U", desc = "function call" },
    { "[", desc = "[] block" },
    { "]", desc = "[] block with ws" },
    { "_", desc = "underscore" },
    { "`", desc = "` string" },
    { "a", desc = "argument" },
    { "b", desc = ")]} block" },
    { "c", desc = "class" },
    { "e", desc = "entire buffer" },
    { "f", desc = "function" },
    { "i", desc = "indent" },
    { "j", desc = "any bracket" },
    { "k", desc = "key" },
    { "#", desc = "number(s)" },
    { "o", desc = "block, conditional, loop" },
    { "q", desc = "quote `\"'" },
    { "r", desc = "return" },
    { "t", desc = "tag" },
    { "u", desc = "use/call" },
    { "w", desc = "value" },
    { "{", desc = "{} block" },
    { "}", desc = "{} with ws" },
    { '"', desc = '" string' },
    { "o", desc = "loop" },
    { "x", desc = "lhs" },
    { "y", desc = "rhs" },
    { "!", desc = "diagnostic" },
    { "/", desc = "regex" },
  }

  local ret = { mode = { "o", "x" } }
  local mappings = {
    around      = "a",
    inside      = "i",
    around_next = "an",
    inside_next = "in",
    around_last = "al",
    inside_last = "il",
    goto_left   = 'g[',
    goto_right  = 'g]',
  }
  for name, prefix in pairs(mappings) do
    name = name:gsub("^around_", ""):gsub("^inside_", "")
    ret[#ret + 1] = { prefix, group = name }
    for _, obj in ipairs(objects) do
      local desc = obj.desc
      if prefix:sub(1, 1) == "i" then desc = desc:gsub(" with ws", "") end
      ret[#ret + 1] = { prefix .. obj[1], desc = obj.desc }
    end
  end
  require("which-key").add(ret, { notify = false })
end

return M
