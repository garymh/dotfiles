local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
local uv = vim.uv or vim.loop

-- Auto-install lazy.nvim if not present
if not uv.fs_stat(lazypath) then
  print('Installing lazy.nvim....')
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
  print('Done.')
end


vim.o.completeopt = 'menuone,popup,noinsert'

local methods = vim.lsp.protocol.Methods

vim.opt.rtp:prepend(lazypath)

function configure_server(server, settings)
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  require('lspconfig')[server].setup(
    vim.tbl_deep_extend('error', { capabilities = capabilities, silent = true }, settings or {})
  )
end

require('lazy').setup({
	---
	-- List of plugins...
	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
   {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            require('lspconfig.ui.windows').default_options.border = 'rounded'

            configure_server('lua_ls', {
                on_init = function(client)
                    local path = client.workspace_folders
                        and client.workspace_folders[1]
                        and client.workspace_folders[1].name
                    if
                        not path
                        or not (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
                    then
                        client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                            Lua = {
                                runtime = {
                                    version = 'LuaJIT',
                                },
                                workspace = {
                                    checkThirdParty = false,
                                    library = {
                                        vim.env.VIMRUNTIME,
                                        '${3rd}/luv/library',
                                    },
                                },
                            },
                        })
                        client:notify(
                            vim.lsp.protocol.Methods.workspace_didChangeConfiguration,
                            { settings = client.config.settings }
                        )
                    end

                    return true
                end,
                settings = {
                    Lua = {
                        -- Using stylua for formatting.
                        format = { enable = false },
                        hint = {
                            enable = true,
                            arrayIndex = 'Disable',
                        },
                        completion = { callSnippet = 'Replace' },
                    },
                },
            })
        end,
      },
})


local function keymap(lhs, rhs, opts, mode)
  opts = type(opts) == 'string' and { desc = opts }
  or vim.tbl_extend('error', opts --[[@as table]], { buffer = bufnr })
  mode = mode or 'n'
  vim.keymap.set(mode, lhs, rhs, opts)
end

---For replacing certain <C-x>... keymaps.
---@param keys string
local function feedkeys(keys)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), 'n', true)
end

---Is the completion menu open?
local function pumvisible()
  return tonumber(vim.fn.pumvisible()) ~= 0
end

local function on_attach(client, bufnr)
  vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
  -- Enable completion and configure keybindings.
  if client.supports_method(methods.textDocument_completion) then
    -- Use enter to accept completions.
    keymap('<cr>', function()
      return pumvisible() and '<C-y>' or '<cr>'
    end, { expr = true }, 'i')

    vim.diagnostic.config { virtual_line = true }

    -- Use slash to dismiss the completion menu.
    keymap('/', function()
      return pumvisible() and '<C-e>' or '/'
    end, { expr = true }, 'i')

    -- Use <C-n> to navigate to the next completion or:
    -- - Trigger LSP completion.
    -- - If there's no one, fallback to vanilla omnifunc.
    keymap('<C-n>', function()
      if pumvisible() then
        feedkeys '<C-n>'
      else
        if next(vim.lsp.get_clients { bufnr = 0 }) then
          vim.lsp.completion.trigger()
        else
          if vim.bo.omnifunc == '' then
            feedkeys '<C-x><C-n>'
          else
            feedkeys '<C-x><C-o>'
          end
        end
      end
    end, 'Trigger/select next completion', 'i')

    -- Buffer completions.
    keymap('<C-u>', '<C-x><C-n>', { desc = 'Buffer completions' }, 'i')

    -- Use <Tab> to accept a Copilot suggestion, navigate between snippet tabstops,
    -- or select the next completion.
    -- Do something similar with <S-Tab>.
    keymap('<Tab>', function()
      if pumvisible() then
        feedkeys '<C-n>'
      elseif vim.snippet.active { direction = 1 } then
        vim.snippet.jump(1)
      else
        feedkeys '<Tab>'
      end
    end, {}, { 'i', 's' })
    keymap('<S-Tab>', function()
      if pumvisible() then
        feedkeys '<C-p>'
      elseif vim.snippet.active { direction = -1 } then
        vim.snippet.jump(-1)
      else
        feedkeys '<S-Tab>'
      end
    end, {}, { 'i', 's' })

    -- Inside a snippet, use backspace to remove the placeholder.
    keymap('<BS>', '<C-o>s', {}, 's')
  end
end


vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'Configure LSP keymaps',
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- I don't think this can happen but it's a wild world out there.
    if not client then
      return
    end

    on_attach(client, args.buf)
  end,
})
