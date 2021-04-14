function table_merge(t1, t2)
    for k,v in pairs(t2) do
        if type(v) == "table" then
            if type(t1[k] or false) == "table" then
                tableMerge(t1[k] or {}, t2[k] or {})
            else
                t1[k] = v
            end
        else
            t1[k] = v
        end
    end
    return t1
end

P = function(v)
  print(vim.inspect(v))
  return v
end

function nmap(name, cmd, options) vim.api.nvim_set_keymap('n', name, cmd, options or {}) end
function vmap(name, cmd, options) vim.api.nvim_set_keymap('v', name, cmd, options or {}) end
function xmap(name, cmd, options) vim.api.nvim_set_keymap('x', name, cmd, options or {}) end
function imap(name, cmd, options) vim.api.nvim_set_keymap('i', name, cmd, options or {}) end
function cmap(name, cmd, options) vim.api.nvim_set_keymap('c', name, cmd, options or {}) end
function omap(name, cmd, options) vim.api.nvim_set_keymap('o', name, cmd, options or {}) end
function tmap(name, cmd, options) vim.api.nvim_set_keymap('t', name, cmd, options or {}) end
function  map(name, cmd, options) vim.api.nvim_set_keymap("",  name, cmd, options or {}) end

function s_nmap(name, cmd, options) nmap(name, cmd, table_merge(options or {}, { silent = true })) end
function s_vmap(name, cmd, options) vmap(name, cmd, table_merge(options or {}, { silent = true })) end
function s_xmap(name, cmd, options) xmap(name, cmd, table_merge(options or {}, { silent = true })) end
function s_imap(name, cmd, options) imap(name, cmd, table_merge(options or {}, { silent = true })) end
function s_cmap(name, cmd, options) cmap(name, cmd, table_merge(options or {}, { silent = true })) end
function s_omap(name, cmd, options) omap(name, cmd, table_merge(options or {}, { silent = true })) end
function s_tmap(name, cmd, options) tmap(name, cmd, table_merge(options or {}, { silent = true })) end
function  s_map(name, cmd, options)  map(name, cmd, table_merge(options or {}, { silent = true })) end

function _G.plugin_loaded(plugin_name)
  local plugins = _G.packer_plugins
  return plugins and plugins[plugin_name] ~= nil and plugins[plugin_name].loaded
end

vim.o.termguicolors = true

function setplus(option, value)
  old_value = vim.api.nvim_get_option(option)
  new_value = old_value .. value

  vim.api.nvim_set_option(option, new_value)
end

home = os.getenv("HOME")
D    = os.getenv('DOTFILES') or os.getenv('HOME') .. '/code/dotfiles'
