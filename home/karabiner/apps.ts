import { ifApp } from "karabiner.ts";

export const apps = {
  firefox: ["^org\\.mozilla\\.firefox$"],
  firefoxdev: ["^org\\.mozilla\\.firefoxdeveloperedition$"],
  firefoxnight: ["^org\\.mozilla\\.nightly$"],
  finder: ["^com\\.apple\\.finder"],
  mail: ["^com\\.apple\\.mail"],
  onep: ["^com\\.1password\\.1password"],
  kitty: ["^net\\.kovidgoyal\\.kitty"],
  reeder: ["^com\\.reederapp\\.5\\.macOS"],
  safari: ["^com\\.apple\\.Safari"],
  helium: ["^net\\.imput\\.helium"],
  brave: ["^com\\.brave\\.Browser\\.beta$"],
  markview: ["^com\\.markviewer\\.markviewer$"],
  neovide: ["^com\\.neovide\\.neovide"],
  omnifocus: ["^com\\.omnigroup\\.OmniFocus3$"],
  preview: ["^com\\.apple\\.Preview$"],
  firefoxes: [
    "^org\\.mozilla\\.firefox",
    "^org\\.mozilla\\.firefoxdeveloperedition$",
    "^org\\.mozilla\\.nightly$",
  ],
  terminal: ["^com\\.apple\\.Terminal"],
  ghostty: ["^com\\.mitchellh\\.ghostty"],
  terminals: [
    "^io\\.alacritty",
    "^net\\.kovidgoyal\\.kitty",
    "^com\\.apple\\.Terminal",
    "^com\\.github\\.wez\\.wezterm",
    "^com\\.mitchellh\\.ghostty",
  ],
  calendar: ["^com\\.apple\\.iCal$"],
  omnifocus4: ["^com\\.omnigroup\\.OmniFocus4$"],
  discord: ["^com\\.hnc\\.Discord$"],
  wezterm: ["^com\\.github\\.wez\\.wezterm$"],
  silicio: ["^de\\.janbolz\\.silicio$"],
  // Apps whose F15 action is just "send escape"
  escapeApps: [
    "^com\\.runningwithcrayons\\.Alfred$",
    "^org\\.mozilla\\.firefoxdeveloperedition$",
    "^org\\.mozilla\\.firefox$",
    "^net\\.kovidgoyal\\.kitty$",
    "^md\\.obsidian$",
    "^com\\.github\\.wez\\.wezterm$",
    "^com\\.mitchellh\\.ghostty$",
    "^org\\.alacritty$",
    "^com\\.neovide\\.neovide$",
    "^com\\.qvacua\\.VimR$",
    "^com\\.mowglii\\.Nvmm$",
  ],
} as const;

export function inApp(name: keyof typeof apps) {
  return ifApp([...apps[name]]);
}
