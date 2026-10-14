import { map, rule } from "karabiner.ts";

// F10 → mute (bare press only); F11/F12 → volume, also with shift/option. Any other modifier
// doesn't match, so app shortcuts on those combos pass through.
const mediaKeysRule = rule(
  "F10/F11/F12 -> mute/volume (F11/F12 also with shift/option)",
)
  .manipulators([
    map("f10").toConsumerKey("mute"),
    map("f11", { optional: ["shift", "option"] })
      .toConsumerKey("volume_decrement"),
    map("f12", { optional: ["shift", "option"] })
      .toConsumerKey("volume_increment"),
  ]);

export default [mediaKeysRule];
