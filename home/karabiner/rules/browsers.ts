import { map, rule } from "karabiner.ts";

import { inApp } from "../apps.ts";

const safariReopenTabCmdShiftNRule = rule(
  "|safari| ⇧⌘n → reopen tab",
  inApp("safari"),
)
  .manipulators([
    map("n", ["left_command", "left_shift"])
      .to("t", ["left_command", "left_shift"]),
  ]);

const safariReopenTabCmdShiftZRule = rule("|safari| ⇧⌘z → reopen tab", inApp("safari"))
  .manipulators([
    map("z", ["left_command", "left_shift"])
      .to("t", ["left_command", "left_shift"]),
  ]);

const safariPrivateWindowRule = rule("|safari| private window", inApp("safari"))
  .manipulators([
    map("p", ["left_command", "left_shift"])
      .to("n", ["left_command", "left_shift"]),
  ]);

const heliumPrivateWindowRule = rule("|helium| private window", inApp("helium"))
  .manipulators([
    map("p", ["left_command", "left_shift"])
      .to("n", ["left_command", "left_shift"]),
  ]);

const bravePrivateWindowRule = rule("|brave| private window", inApp("brave"))
  .manipulators([
    map("p", ["left_command", "left_shift"])
      .to("n", ["left_command", "left_shift"]),
  ]);

export default [
  safariReopenTabCmdShiftNRule,
  safariReopenTabCmdShiftZRule,
  safariPrivateWindowRule,
  heliumPrivateWindowRule,
  bravePrivateWindowRule,
];
