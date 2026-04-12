Home = os.getenv("HOME")
D    = os.getenv("DOTFILES") or Home .. "/code/dotfiles"
GL   = os.getenv("GITLAB_HOME") or Home .. "/code/work/gdk/gitlab"
T    = function(str) return vim.api.nvim_replace_termcodes(str, true, true, true) end

User = vim.api.nvim_create_user_command

function Nv11() return vim.fn.has("nvim-0.11") == 1 end

function Nv12() return vim.fn.has("nvim-0.12") == 1 end

function InNeovide() return vim.g.neovide == true end

function InVimr() return vim.fn.exists("g:gui_vimr") == 1 end

function InGui() return InVimr() or InNeovide() end

function Notifier(text) vim.notify(text, vim.log.levels.INFO, { title = "Info" }) end

function Augroup(name) return vim.api.nvim_create_augroup("gary_" .. name, { clear = true }) end

function NvimVsource(file) vim.cmd([[source ]] .. D .. [[/home/vim/]] .. file) end

function Feedkeys(keys)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), 'n', true)
end

local vim_modes = { "n", "v", "x", "i", "c", "o", "t", "ox", "nx", "nox" }
local silent_modes = { [true] = "s_", [false] = "" }

local function split_mode(mode)
  -- if #mode == 1 then
  --   return { mode }
  -- elseif #mode == 2 then
  --   return { mode:sub(1, 1), mode:sub(2, 2) }
  -- end
  -- return { nil }

  if #mode == 0 then
    return { nil }
  end

  local result = {}
  for i = 1, #mode do
    table.insert(result, mode:sub(i, i))
  end
  return result
end

for _, mode in ipairs(vim_modes) do
  for silent, prefix in pairs(silent_modes) do
    _G[prefix .. mode .. "map"] = function(name, cmd, options, desc, notifier)
      if type(options) == "string" then
        desc, options = options, {}
      end
      options = options or {}

      local bad_description = "I need a description, please fill me in"

      desc = desc or bad_description
      if desc == bad_description then
        if
            string.find(name, "<leader")
            or string.find(name, "<localleader")
            or string.find(name, "<space")
            or string.find(name, "g")
            or string.find(name, "[", nil, true)
            or string.find(name, "]", nil, true)
        then
          vim.notify("needs description!: " .. mode .. ", name:" .. name)
        end
      end

      if notifier and type(cmd) == "string" then
        cmd = cmd .. '<cmd>lua Notifier("' .. notifier .. '")<cr>'
      end

      vim.keymap.set(
        split_mode(mode), name, cmd,
        vim.tbl_extend("force", options, { desc = desc, silent = silent })
      )
    end
  end
end

s_nmap("<C-]>", "<C-]>", "check definition")


function _G.has(plugin)
  return get_plugin(plugin) ~= nil
end

function _G.get_plugin(name)
  return require("lazy.core.config").spec.plugins[name]
end

local borders = {
  none = { '', '', '', '', '', '', '', '' },
  invs = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
  thin = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
  edge = { '🭽', '▔', '🭾', '▕', '🭿', '▁', '🭼', '▏' },
}

_G.tools = {
  ui = {
    cur_border = borders.edge,
    borders = borders,
    icons = {
      ballot_x   = '🗴',
      branch     = '',
      bullet     = '•',
      check      = '✔',
      d_chev     = '∨',
      diagnostic = "▌",
      diff       = "-",
      ellipses   = '…',
      eob        = "·",
      file       = '╼ ',
      fold       = "·",
      foldclose  = "",
      foldopen   = "",
      foldsep    = " ",
      hamburger  = '≡',
      horiz      = "━",
      horizdown  = "┳",
      horizup    = "┻",
      info_i     = '¡',
      location   = '⌘',
      lock       = '',
      o_bullet   = '○',
      r_chev     = '>',
      space      = '⋅',
      square     = '🗊',
      stlnc      = "·",
      tab        = '  ↦',
      trail      = '⋅',
      up_tri     = '▲',
      vert       = "┃",
      verthoriz  = "╋",
      vertleft   = "┫",
      vertright  = "┣",
    }
  },
}

_G.icons = tools.ui.icons
