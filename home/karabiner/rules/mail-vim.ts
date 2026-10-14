import { ifVar, map, rule, toSetVar } from "karabiner.ts";

import { inApp } from "../apps.ts";

import { repeat } from "../keys.ts";

// Bare letters as message-list navigation. inApp("mail") is also true in compose windows and the
// search field, so every manipulator also requires `mail_viewer`, which hammerspoon/mail-vim.js
// sets from AX focus (1 = message list).
const inMessageList = [
  inApp("mail"),
  ifVar("mail_viewer", 1),
];

// gg: the first g arms mail_vim_g and a delayed action disarms it (500ms default). The armed
// manipulator must come first; the first match wins.
const mailVimGgRule = rule(
  "|mail| gg to top of message list",
  ...inMessageList,
).manipulators([
  map("g").condition(ifVar("mail_vim_g", 1)).to("home").toVar("mail_vim_g", 0),
  map("g")
    .toVar("mail_vim_g", 1)
    .toDelayedAction(toSetVar("mail_vim_g", 0), toSetVar("mail_vim_g", 0)),
]);

const mailVimRule = rule(
  "|mail| vim keys in the message list",
  ...inMessageList,
).manipulators([
  map("j").to("down_arrow"),
  map("k").to("up_arrow"),
  map("h").to("left_arrow"),
  map("l").to("right_arrow"),
  map("d").to("a", ["left_command", "left_control"]),
  map("x").to("j", ["left_command", "left_control"]),
  map("g", "shift").to("end"),
  map("]", "shift").to(repeat("down_arrow", 10)),
  map("[", "shift").to(repeat("up_arrow", 10)),
  map("slash").to("f", ["left_command", "left_option"]),
]);

// Escape also sends F20, which hammerspoon/mail-vim.js uses to refocus the message list — Mail has
// no key that leaves its search field.
const mailVimModeRule = rule(
  "|mail| escape returns focus to the message list",
  inApp("mail"),
).manipulators([
  map("escape").to("escape").to("f20"),
]);

export default [mailVimGgRule, mailVimRule, mailVimModeRule];
