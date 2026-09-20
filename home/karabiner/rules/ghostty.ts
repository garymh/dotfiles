import { map, rule } from "karabiner.ts";

import { inApp } from "../apps.ts";

const ghosttyAltFRule = rule("|ghostty| alt+f", inApp("ghostty"))
  .manipulators([
    map("f", ["left_command", "left_shift"])
      .to("f", "left_option"),
  ]);

const ghosttyAltGRule = rule("|ghostty| alt+g", inApp("ghostty"))
  .manipulators([
    map("g", ["left_command", "left_shift"])
      .to("g", "left_option"),
  ]);

const ghosttyOptKRule = rule("|ghostty| opt+k", inApp("ghostty"))
  .manipulators([
    map("k", "left_command")
      .to("k", "left_option"),
  ]);

const ghosttyOptPRule = rule("|ghostty| opt+p", inApp("ghostty"))
  .manipulators([
    map("p", "left_command")
      .to("p", "left_option"),
  ]);

export default [
  ghosttyAltFRule,
  ghosttyAltGRule,
  ghosttyOptKRule,
  ghosttyOptPRule,
];
