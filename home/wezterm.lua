local wezterm = require("wezterm")
local act = wezterm.action
local font = wezterm.font_with_fallback

local config = {}

if wezterm.config_builder then config = wezterm.config_builder() end

config.max_fps = 120

-- config.font = wezterm.font({
-- 	-- family = "CommitMono-gary",
-- 	-- family = "Iosevka Comfy",
-- 	family = "Maple Mono",
-- 	-- family = "VictorMono Nerd Font",
-- 	-- family = "Necto Mono",
-- 	-- family = "IntelOne Mono",
-- 	-- family = 'Liberation Mono',
-- 	-- family = "0xProto",
-- 	-- family = "Recursive",
-- 	-- family = "Input Mono Condensed",
-- 	-- family = "Lemonade",
-- 	-- family = 'Symbols Nerd Font',
-- 	-- family = 'SFMono Nerd Font',
-- 	-- family = 'm PLUS 1 Code',
-- 	-- family = "FixedsysModernV05 Nerd Font Mono",
-- 	-- family = "Departure Mono",
-- 	-- family = "Monaspace Radon",
-- 	-- family = "D2CodingLigature Nerd Font Mono",
-- 	-- family = "Input Mono Compressed",
-- 	-- family = "Iosevka SS08",
-- 	-- family = "Hermit",
-- 	-- family = "Monaspace Argon Var",
-- 	-- family = "EnvyCodeR Nerd Font Mono",
-- 	-- family = "Hack Nerd Font Propo",
-- 	-- family = 'Noto Color Emoji',
-- 	weight = "Regular",
-- })

config.font = wezterm.font_with_fallback({
  {
    family = "Departure Mono",
    -- family = "Maple Mono NF",
    harfbuzz_features = {
      -- "tnum=1",
      -- "ss01",
      -- "ss02",
      -- "cv01", -- no detached
      "cv03", -- upper arm on a
      "cv04", -- @ rounded
      "ss05", -- {{}} tight
      -- "ss06", -- {{}} tight
      "zero",
    },

    -- ->
  },

  -- charset fallbacks ᴀʙᴄᴅᴇꜰɢʜɪᴊᴋʟᴍɴᴏᴘǫʀsᴛᴜᴠᴡxʏᴢ (ﾉಥ益ಥ）ﾉ︵┻━┻
  "Noto Sans Mono",                    -- linux + smallcaps
  "Monaco",                            -- mac + smallcaps
  { family = "Unifont", scale = 1.2 }, -- bitmap fallback with a lot of unicode

  "Noto Color Emoji",
})
-- config.font = wezterm.font({
-- 	family = "Recursive",
-- 	stretch = "Expanded",
-- 	weight = "Regular",
-- 	harfbuzz_features = { "dlig=1", "ss05", "ss08", "MONO=1" },
-- })

-- config.harfbuzz_features = {
-- 	-- "tnum=1",
-- 	-- "ss01",
-- 	-- "ss02",
-- 	-- "cv01", -- no detached
-- 	"cv03", -- upper arm on a
-- 	"cv04", -- @ rounded
-- 	"ss05", -- {{}} tight
-- 	-- "ss06", -- {{}} tight
-- 	"zero",
-- }
-- config.harfbuzz_features = { "dlig=1", "ss05", "ss08", "MONO=1" }

config.cursor_blink_ease_in = "Linear"
config.cursor_blink_ease_out = "EaseIn"
config.cursor_blink_rate = 400
config.default_cursor_style = "SteadyBlock"

config.force_reverse_video_cursor = true
config.colors = {
  foreground = "#dcd7ba",
  background = "#1f1f28",

  cursor_bg = "#c8c093",
  cursor_fg = "#c8c093",
  cursor_border = "#c8c093",

  selection_fg = "#c8c093",
  selection_bg = "#2d4f67",

  scrollbar_thumb = "#16161d",
  split = "#16161d",

  ansi = {
    "#090618",
    "#c34043",
    "#76946a",
    "#c0a36e",
    "#7e9cd8",
    "#957fb8",
    "#6a9589",
    "#c8c093",
  },
  brights = {
    "#727169",
    "#e82424",
    "#98bb6c",
    "#e6c384",
    "#7fb4ca",
    "#938aa9",
    "#7aa89f",
    "#dcd7ba",
  },
  indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
}

config.font_size = 20.0
config.cell_width = 1.00
config.line_height = 1.00

config.leader = {
  key = "Space",
  mods = "CTRL",
  timeout_milliseconds = 1000,
}

config.window_close_confirmation = "NeverPrompt"

config.keys = {
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
  { key = "z",          mods = "LEADER",    action = wezterm.action.TogglePaneZoomState },
  { key = "q",          mods = "CMD",       action = wezterm.action.QuitApplication },

  {
    key = "g",
    mods = "LEADER",
    action = act.SpawnCommandInNewWindow({
      args = { os.getenv("SHELL"), "-c", "lazygit" },
    }),
  },

  {
    key = "Space",
    mods = "LEADER",
    action = act.QuickSelect,
  },

  {
    key = "t",
    mods = "LEADER",
    action = act.SpawnCommandInNewWindow({
      args = { os.getenv("SHELL"), "-c", "btop" },
    }),
  },

  {
    key = "v",
    mods = "LEADER",
    action = act.SpawnCommandInNewWindow({
      args = { os.getenv("SHELL"), "-c", "nvim" },
    }),
  },

  {
    key = ",",
    mods = "CMD",
    action = wezterm.action({
      SpawnCommandInNewWindow = {
        args = { os.getenv("SHELL"), "-c", "nvim ~/.config/wezterm/wezterm.lua" },
      },
    }),
  },
}

config.window_padding = {
  left = "2cell",
  right = "2cell",
  top = "20px",
  bottom = "0",
}

config.inactive_pane_hsb = {
  saturation = 0.5,
  brightness = 0.5,
}

config.hyperlink_rules = wezterm.default_hyperlink_rules()
config.window_background_opacity = 1.0
config.window_decorations = "RESIZE"
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.adjust_window_size_when_changing_font_size = false

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

-- make task numbers clickable
-- the first matched regex group is captured in $1.
-- table.insert(config.hyperlink_rules, {
--   regex = [[\b[tt](\d+)\b]],
--   format = 'https://example.com/tasks/?t=$1',
-- })

-- make username/project paths clickable. this implies paths like the following are for github.
-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
-- as long as a full url hyperlink regex exists above this it should not match a full url to
-- github or gitlab / bitbucket (i.e. https://gitlab.com/user/project.git is still a whole clickable url)
-- table.insert(config.hyperlink_rules, {
--   regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
--   format = 'https://www.github.com/$1/$3',
-- })

-- config.font_rules = {
--   {
--     intensity = 'Bold',
--     italic = true,
--     font = wezterm.font {
--       family = 'Iosevka SS08',
--       weight = 'Bold',
--       style = 'Italic',
--     },
--   },
--   {
--     italic = true,
--     intensity = 'Half',
--     font = wezterm.font {
--       family = 'Iosevka SS08',
--       weight = 'DemiBold',
--       style = 'Italic',
--     },
--   },
--   {
--     italic = true,
--     intensity = 'Normal',
--     font = wezterm.font {
--       family = 'Iosevka SS08',
--       style = 'Italic',
--     },
--   },
-- }

-- { key = 'p',          mods = 'cmd',       action = act.ShowLauncherArgs { flags = "FUZZY|COMMANDS|TABS" }, },

-- 'CommitMono-gary',
-- "VictorMono Nerd Font",
-- 'Necto Mono',
-- 'IntelOne Mono',
-- 'Liberation Mono',
-- '0xProto',
-- 'Input Mono Condensed',
-- 'Symbols Nerd Font',
-- 'SFMono Nerd Font',
-- 'm PLUS 1 Code',
