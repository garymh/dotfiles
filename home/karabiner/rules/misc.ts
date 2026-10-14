import {
  ifVar,
  map,
  mapSimultaneous,
  rule,
  simlayer,
  toApp,
  toSetVar,
} from "karabiner.ts";

import { onDevice } from "../devices.ts";
import { hyperMods } from "../hyper.ts";
import { toRunAction } from "../applescripts.ts";

const clearNotificationsRule = rule("clear notifications").manipulators([
  map("delete_or_backspace", [...hyperMods]).to$(
    'osascript -e \'tell application id "com.runningwithcrayons.Alfred" to run trigger "clearnots" in workflow "com.garys.stuff"\'',
  ),
]);

const mouseTestRule = rule("mousetest?").manipulators([
  map("keypad_1").to("f15").condition(onDevice("mouse")),
]);

const mouseTest2Rule = rule("mousetest?2").manipulators([
  map("keypad_2").to("f15", "left_shift").condition(onDevice("mouse")),
]);

// Hold both shifts, then tap a letter to open an app. duoLayer() rejects modifier keys, so the
// layer variable is set by hand.
const launchAppLayer = rule("double shift → launch apps").manipulators([
  mapSimultaneous(
    ["left_shift", "right_shift"],
    {
      key_down_order: "insensitive",
      key_up_order: "insensitive",
      to_after_key_up: [toSetVar("launch-app", 0)],
    },
    500,
  ).to(toSetVar("launch-app", 1)),

  map("b").to(toApp("Brave Browser"))
    .condition(ifVar("launch-app", 1)),

  map("c").to(toApp("Discord"))
    .condition(ifVar("launch-app", 1)),

  map("d").to(toApp("Firefox Developer Edition"))
    .condition(ifVar("launch-app", 1)),

  map("e").to(toApp("Mail"))
    .condition(ifVar("launch-app", 1)),

  map("f").to(toApp("Firefox"))
    .condition(ifVar("launch-app", 1)),

  map("k").to(toApp("Ghostty"))
    .condition(ifVar("launch-app", 1)),

  map("m").to(toApp("Messages"))
    .condition(ifVar("launch-app", 1)),

  map("o").to(toApp("Omnifocus"))
    .condition(ifVar("launch-app", 1)),

  map("p").to(toApp("Spotify"))
    .condition(ifVar("launch-app", 1)),

  map("r").to(toApp("Reeder"))
    .condition(ifVar("launch-app", 1)),

  map("s").to(toApp("Safari"))
    .condition(ifVar("launch-app", 1)),

  map("v").to(toApp("Neovide"))
    .condition(ifVar("launch-app", 1)),
]);

// Unwired (not exported): hold space + h/j/k/l/s for Moom actions.
const spaceLayer = simlayer("spacebar", "space-mode", 800).manipulators([
  map("h").to(toRunAction("Moom", "Move Left")),
  map("j").to(toRunAction("Moom", "Move Down")),
  map("k").to(toRunAction("Moom", "Move Up")),
  map("l").to(toRunAction("Moom", "Move Right")),
  map("s").to(toRunAction("Moom", "Embiggen")),
]);

const kvmSwitchRule = rule("KVM?").manipulators([
  map("f24", "left_shift").to$(
    "/opt/homebrew/bin/m1ddc display 1 set input 15",
  ),
]);

const functionKeyDiscordRule = rule("F13/F14/F17 -> Discord").manipulators([
  map("f13").to(toApp("Discord")),
  map("f14").to(toApp("Discord")),
  map("f17").to(toApp("Discord")),
]);

const f16HyperFRule = rule("F16").manipulators([
  map("f16").to("f", [...hyperMods]),
]);

export default [
  clearNotificationsRule,
  mouseTestRule,
  mouseTest2Rule,
  launchAppLayer,
  kvmSwitchRule,
  functionKeyDiscordRule,
  f16HyperFRule,
];
