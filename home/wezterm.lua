local wezterm = require("wezterm")
local act     = wezterm.action

local config  = {}

local function spawn_in_new_tab(cmd)
  return wezterm.action_callback(function(window, pane)
    window:spawn_tab({ args = { "/bin/zsh", "-c", cmd } })
  end)
end

if wezterm.config_builder then config = wezterm.config_builder() end

config.font                                       = wezterm.font_with_fallback({
  {
    --  family = "0xProto"
    --  family = "3270 Condensed"
    --  family = "APL385 Unicode"
    --  family = "Adwaita Mono"
    --  family = "Atari Classic"
    --  family = "Berkeley Mono"
    --  family = "CommitMono-gary"
    --  family = "D2CodingLigature Nerd Font Mono"
    --  family = "Departure Mono"
    --  family = "Dispatch Mono"
    --  family = "EnvyCodeR Nerd Font Mono"
    --  family = "FixedsysExcelsiorIIIb Nerd Font"
    --  family = "Hack Nerd Font Propo"
    --  family = "Hermit"
    --  family = "IBM Plex Mono"
    --  family = "Input Mono Condensed"
    --  family = "IntelOne Mono"
    --  family = "Iosevka Comfy"
    --  family = "Iosevka Comfy Wide"
    --  family = "Iosevka SS08"
    --  family = "IosevkaTermSlab Nerd Font Mono"
    --  family = "Iosvmata"
    --  family = "Ioveska Comfy Wide Motion Duo"
    --  family = "Lemonade"
    --  family = "Liberation Mono"
    --  family = "Lotion"
    --  family = "Luculent"
    --  family = "Lyth Mono Term"
    --  family = "Maple Mono NF"
    --  family = "Monaspace Argon Var"
    --  family = "Monaspace Radon"
    --  family = "Necto Mono"
    --  family = "Recursive"
    --  family = "SF Mono"
    --  family = "Sergamon"
    --  family = "scientifica"
    --  family = "SpaceMono Nerd Font Mono"
    --  family = "VictorMono Nerd Font"
    --  family = "Vulf Mono"
    --  family = "cozette"
    --  family = "m PLUS 1 Code"
    --  family = "Martian Mono"
    --  family = "TamzenForPowerline"
    --  family = "Iosevka SS08",

    family = "FixedsysExcelsiorIIIb Nerd Font",
    harfbuzz_features = {
      "cv03", -- upper arm on a
      "cv04", -- @ rounded
      "ss05", -- {{}} tight
      "zero",
      "-calt",
      "-dlig",
      "-liga",
    },
  },
  "Noto Sans Mono",                    -- linux + smallcaps
  "Monaco",                            -- mac + smallcaps
  { family = "Unifont", scale = 1.2 }, -- bitmap fallback with a lot of unicode
  "Noto Color Emoji",
})

config.adjust_window_size_when_changing_font_size = false
config.cell_width                                 = 1.00
config.cursor_blink_ease_in                       = "Linear"
config.cursor_blink_ease_out                      = "EaseIn"
config.cursor_blink_rate                          = 400
config.default_cursor_style                       = "SteadyBlock"
config.font_size                                  = 24.0
config.force_reverse_video_cursor                 = true
config.hide_tab_bar_if_only_one_tab               = true
config.hyperlink_rules                            = wezterm.default_hyperlink_rules()
config.line_height                                = 1.10
config.max_fps                                    = 120
config.use_fancy_tab_bar                          = true
config.window_background_opacity                  = 1.0
config.window_close_confirmation                  = "NeverPrompt"
config.window_decorations                         = "RESIZE"

config.colors                                     = {
  foreground      = "#e0def4",
  background      = "#232136",

  cursor_bg       = "#e0def4",
  cursor_fg       = "#232136",
  cursor_border   = "#e0def4",

  selection_fg    = "#e0def4",
  selection_bg    = "#44415a",

  scrollbar_thumb = "#2a273f",
  split           = "#2a273f",

  ansi            = { "#393552", "#eb6f92", "#3e8fb0", "#f6c177", "#9ccfd8", "#c4a7e7", "#ea9a97", "#e0def4", },
  brights         = { "#6e6a86", "#eb6f92", "#3e8fb0", "#f6c177", "#9ccfd8", "#c4a7e7", "#ea9a97", "#e0def4", },
}

config.window_padding                             = { left = "1cell", right = "1cell", top = "1cell", bottom = "1cell", }
config.inactive_pane_hsb                          = { saturation = 0.5, brightness = 0.5, }

config.leader                                     = {
  key = "Space",
  mods = "CTRL",
  timeout_milliseconds = 1000,
}

config.keys                                       = {
  { key = "Backspace",  mods = "CMD",       action = act.SendKey({ key = "u", mods = "CTRL" }) },
  { key = "d",          mods = "CMD",       action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "d",          mods = "CMD|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "w",          mods = "CMD",       action = act.CloseCurrentPane({ confirm = true }) },
  { key = "[",          mods = "CMD",       action = act.ActivatePaneDirection("Prev") },
  { key = "]",          mods = "CMD",       action = act.ActivatePaneDirection("Next") },
  { key = "LeftArrow",  mods = "OPT",       action = act.SendKey({ key = "b", mods = "ALT" }) },
  { key = "RightArrow", mods = "OPT",       action = act.SendKey({ key = "f", mods = "ALT" }) },
  { key = "LeftArrow",  mods = "CMD",       action = act.SendKey({ key = "a", mods = "CTRL" }) },
  { key = "RightArrow", mods = "CMD",       action = act.SendKey({ key = "e", mods = "CTRL" }) },
  { key = "UpArrow",    mods = "CMD",       action = act.ScrollToPrompt(-1) },
  { key = "DownArrow",  mods = "CMD",       action = act.ScrollToPrompt(1) },
  { key = "f",          mods = "CMD|SHIFT", action = act.SendKey({ key = "f", mods = "ALT" }) },
  { key = "g",          mods = "CMD|SHIFT", action = act.SendKey({ key = "g", mods = "ALT" }) },
  { key = "k",          mods = "CMD",       action = act.SendKey({ key = "k", mods = "ALT" }) },
  { key = "p",          mods = "CMD",       action = act.SendKey({ key = "p", mods = "ALT" }) },
  { key = "o",          mods = "CMD",       action = act.SendKey({ key = "o", mods = "ALT" }) },
  { key = "Tab",        mods = "CTRL",      action = act.SendKey({ key = "Tab", mods = "CTRL" }) },
  { key = "Tab",        mods = "SHIFT",     action = act.SendKey({ key = "Tab", mods = "SHIFT" }) },
  { key = "z",          mods = "LEADER",    action = act.TogglePaneZoomState },
  { key = "q",          mods = "CMD",       action = act.QuitApplication },
  { key = "g",          mods = "LEADER",    action = spawn_in_new_tab("lazygit") },
  { key = "t",          mods = "LEADER",    action = spawn_in_new_tab("btop") },
  { key = "v",          mods = "LEADER",    action = spawn_in_new_tab("nvim") },
  { key = ",",          mods = "CMD",       action = spawn_in_new_tab("nvim ~/.config/wezterm/wezterm.lua") },

  {
    key = "Space",
    mods = "LEADER",
    action = act.QuickSelect,
  },
}

wezterm.on("user-var-changed", function(window, pane, name, value)
  local overrides = window:get_config_overrides() or {}
  if name == "ZEN_MODE" then
    local incremental = value:find("+")
    local number_value = tonumber(value)
    if incremental ~= nil then
      while number_value > 0 do
        window:perform_action(wezterm.action.IncreaseFontSize, pane)
        number_value = number_value - 1
      end
      overrides.enable_tab_bar = false
    elseif number_value < 0 then
      window:perform_action(wezterm.action.ResetFontSize, pane)
      overrides.font_size = nil
      overrides.enable_tab_bar = true
    else
      overrides.font_size = number_value
      overrides.enable_tab_bar = false
    end
  end
  window:set_config_overrides(overrides)
end)

return config
