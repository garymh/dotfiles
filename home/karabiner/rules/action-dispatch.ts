import { toKey } from "karabiner.ts";

import { apps } from "../apps.ts";

export const hideEvent = toKey("h", "left_command");

export const baseDispatch: Array<
  [keyof typeof apps, ReturnType<typeof toKey>]
> = [
  ["calendar", toKey("c", ["left_shift", "left_option", "left_command"])],
  ["mail", toKey("u", ["left_shift", "left_command"])],
  ["omnifocus4", toKey("i", ["left_option", "left_command"])],
  ["finder", toKey("2", "left_command")],
  ["markview", toKey("l", ["left_shift", "left_command"])],
  ["reeder", toKey("l", ["left_control", "left_command"])],
  ["discord", toKey("k", "left_command")],
  ["preview", toKey("1", ["left_command", "left_option"])],
  ["safari", toKey("b", ["left_shift", "left_command"])],
  ["onep", toKey("r", "left_command")],
  ["escapeApps", toKey("escape")],
];

export const shiftDispatch: Array<
  [keyof typeof apps, ReturnType<typeof toKey>]
> = [
  ["safari", toKey("e", "left_control")],
  ["firefox", toKey("t", "left_option")],
  ["firefoxdev", toKey("i", ["left_option", "left_command"])],
  ["kitty", toKey("5", "left_shift")],
  ["markview", toKey("l", ["left_shift", "left_command"])],
  ["mail", toKey("l", ["left_shift", "left_command"])],
  ["wezterm", toKey("5", "left_shift")],
  ["neovide", toKey("5", "left_shift")],
];

export const shiftScriptDispatch: Array<[keyof typeof apps, string]> = [
  ["reeder", "sync-reeder.applescript"],
];
