import { map, rule } from "karabiner.ts";

import { inApp } from "../apps.ts";

const terminalOptDeleteRule = rule("|terminal| ⌥ delete", inApp("terminals"))
  .manipulators([
    map("delete_or_backspace", "left_option")
      .to("w", "left_control"),
  ]);

const terminalsCmdDeleteRule = rule("|terminal| ⌘ delete", inApp("terminals"))
  .manipulators([
    map("delete_or_backspace", "left_command")
      .to("u", "left_control"),
  ]);

const terminalsCmdReturnRule = rule("|terminal| ⌘ return", inApp("terminals"))
  .manipulators([
    map("return_or_enter", "left_command")
      .to("return_or_enter", "left_option"),
  ]);

const terminalCmdLeftRule = rule(
  "|terminal| ⌘ <- to ctrl-a",
  inApp("terminals"),
)
  .manipulators([
    map("left_arrow", "left_command").to("a", "left_control"),
    map("h", ["left_command", "left_control"]).to("a", "left_control"),
  ]);

const terminalCmdRightRule = rule(
  "|terminal| ⌘ -> to ctrl-e",
  inApp("terminals"),
).manipulators([
  map("right_arrow", "left_command").to("e", "left_control"),
  map("l", ["left_command", "left_control"]).to("e", "left_control"),
]);

export default [
  terminalOptDeleteRule,
  terminalsCmdDeleteRule,
  terminalsCmdReturnRule,
  terminalCmdLeftRule,
  terminalCmdRightRule,
];
