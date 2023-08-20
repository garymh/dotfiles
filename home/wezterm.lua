local wezterm = require 'wezterm'
local act     = wezterm.action
local font    = wezterm.font

local config  = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.use_fancy_tab_bar                          = true
config.hide_tab_bar_if_only_one_tab               = true
config.adjust_window_size_when_changing_font_size = false

config.color_scheme                               = 'zenbones_dark'
-- config.font                                       = font('FixedsysModernV05 Nerd Font Mono')
config.font                                       = font('Cartograph CF')
config.font_size                                  = 18.0
config.cell_width                                 = 1.00
config.line_height                                = 1.00

config.leader                                     = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 1000 }

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local pane = tab.active_pane
    local title = basename(pane.foreground_process_name)
      .. ' '
      .. pane.pane_id
    local color = 'navy'
    if tab.is_active then
      color = 'blue'
    end
    return {
      { Background = { Color = color } },
      { Text = ' ' .. title .. ' ' },
    }
  end
)

config.keys                                       = {
  { key = 'd',          mods = 'CMD',       action = act.SplitVertical { domain = 'CurrentPaneDomain' }, },
  { key = 'd',          mods = 'CMD|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
  { key = 'w',          mods = 'CMD',       action = act.CloseCurrentPane { confirm = true }, },
  { key = ']',          mods = 'CMD',       action = act.ActivatePaneDirection 'Prev' },
  { key = '[',          mods = 'CMD',       action = act.ActivatePaneDirection 'Next' },
  { key = 'LeftArrow',  mods = 'OPT',       action = act.SendKey { key = 'b', mods = 'ALT', }, },
  { key = 'RightArrow', mods = 'OPT',       action = act.SendKey { key = 'f', mods = 'ALT' }, },
  { key = 'LeftArrow',  mods = 'CMD',       action = act.SendKey { key = 'a', mods = 'CTRL' }, },
  { key = 'RightArrow', mods = 'CMD',       action = act.SendKey { key = 'e', mods = 'CTRL' }, },
  { key = 'f',          mods = 'CMD|SHIFT', action = act.SendKey { key = 'f', mods = 'ALT' }, },
  { key = 'k',          mods = 'CMD',       action = act.SendKey { key = 'k', mods = 'ALT' }, },
  -- { key = 'p',          mods = 'cmd',       action = act.ShowLauncherArgs { flags = "FUZZY|COMMANDS|TABS" }, },
  { key = 'p',          mods = 'CMD',       action = act.SendKey { key = 'p', mods = 'ALT' }, },
  { key = 'o',          mods = 'CMD',       action = act.SendKey { key = 'o', mods = 'ALT' }, },

  {
    key = 'g',
    mods = 'LEADER',
    action = act.SpawnCommandInNewWindow {
      args = { os.getenv 'SHELL', '-c', 'lazygit', },
    }
  },

  {
    key = 'Space',
    mods = 'LEADER',
    action = act.QuickSelect
  },

  {
    key = 't',
    mods = 'LEADER',
    action = act.SpawnCommandInNewWindow {
      args = { os.getenv 'SHELL', '-c', 'btop', },
    }
  },
}

config.window_padding = {
  left   = "2cell",
  right  = "2cell",
  top    = "1cell",
  bottom = "0",
}

config.inactive_pane_hsb = {
  saturation = 0.5,
  brightness = 0.5,
}

-- Use the defaults as a base
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- make task numbers clickable
-- the first matched regex group is captured in $1.
table.insert(config.hyperlink_rules, {
  regex = [[\b[tt](\d+)\b]],
  format = 'https://example.com/tasks/?t=$1',
})

-- make username/project paths clickable. this implies paths like the following are for github.
-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
-- as long as a full url hyperlink regex exists above this it should not match a full url to
-- github or gitlab / bitbucket (i.e. https://gitlab.com/user/project.git is still a whole clickable url)
table.insert(config.hyperlink_rules, {
  regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
  format = 'https://www.github.com/$1/$3',
})

-- map ctrl+down kitten pass_keys.py neighboring_window bottom ctrl+j
-- map ctrl+left kitten pass_keys.py neighboring_window left   ctrl+h
-- map ctrl+right kitten pass_keys.py neighboring_window right  ctrl+l
-- map ctrl+up kitten pass_keys.py neighboring_window top    ctrl+k

-- map ctrl+space>/      launch --location=hsplit --allow-remote-control kitty +kitten search.py @active-kitty-window-id
-- hints

-- map shift+down move_window down
-- map shift+left move_window left
-- map shift+right move_window right
-- map shift+up move_window up

-- map shift+super+= layout_action rotate
-- map shift+super+f send_text all \x1bf
-- map shift+super+n new_os_window_with_cwd
-- map shift+super+r start_resizing_window
-- map shift+super+w close_os_window

-- map super+backspace send_text all \x1bw
-- map super+d launch --location=hsplit --cwd=last_reported
-- map super+k send_text all \x1bk
-- map super+n new_tab_with_cwd
-- map super+o send_text all \x1bo
-- map super+p send_text all \x1bp
-- map super+r combine : load_config_file : launch --type=overlay --hold --allow-remote-control kitty @ send-text "kitty config reloaded"

-- map super+left send_text all \x01
-- map super+left_bracket kitten pass_keys.py neighboring_window prev ctrl+8
-- map super+right send_text all \x05
-- map super+right_bracket kitten pass_keys.py neighboring_window next ctrl+9

-- map super+z pipe @ansi_alternate_scrollback os_window less +G -R
--

-- and finally, return the configuration to wezterm
return config
