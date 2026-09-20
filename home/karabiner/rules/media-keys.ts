import { map, rule } from "karabiner.ts";

// F10/F11/F12 -> mute/volume, but only for a bare press or shift+press.
// These used to live in index.ts's `simple_modifications`, which cannot
// express from.modifiers: every combination (⌘+F10, ⌥+F11, …) got swallowed
// into the media key, so app shortcuts on those combos never fired. As a
// complex rule, `optional: "shift"` means shift may be held or not; any other
// modifier (command/option/control/fn) fails to match and passes through.
const mediaKeysRule = rule(
  "F10/F11/F12 -> mute/volume (no modifiers or shift only)",
)
  .manipulators([
    map("f10").toConsumerKey("mute"),
    map("f11", { optional: ["shift", "option"] })
      .toConsumerKey("volume_decrement"),
    map("f12", { optional: ["shift", "option"] })
      .toConsumerKey("volume_increment"),
  ]);

export default [mediaKeysRule];
