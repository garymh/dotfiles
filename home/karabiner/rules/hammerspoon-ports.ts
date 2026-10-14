import { map, rule, toApp } from "karabiner.ts";

import { inApp } from "../apps.ts";
import { toScript } from "../applescripts.ts";
import { hyperMods } from "../hyper.ts";
import { onDevice } from "../devices.ts";

// Hyper-key remaps: keystrokes, media keys and AppleScript actions.

const fullscreenRule = rule("Hyper+F -> toggle full screen")
  .manipulators([
    map("f", [...hyperMods])
      .to("f", ["fn"]),
  ]);

const mediaKeysRule = rule("Hyper -> media keys")
  .manipulators([
    map("right_arrow", [...hyperMods])
      .toConsumerKey("scan_next_track"),
    map("left_arrow", [...hyperMods])
      .toConsumerKey("scan_previous_track"),
    map("down_arrow", [...hyperMods])
      .toConsumerKey("play_or_pause"),
  ]);

const brightnessRule = rule("Hyper+F1/F2 -> brightness")
  .manipulators([
    map("f1", [...hyperMods])
      .toConsumerKey("display_brightness_decrement"),
    map("f2", [...hyperMods])
      .toConsumerKey("display_brightness_increment"),
  ]);

// Silicio frontmost → its own show/hide shortcut (Hyper+5); otherwise launch or raise it.
const silicioRule = rule("Hyper+Up -> show/hide Silicio")
  .manipulators([
    map("up_arrow", [...hyperMods])
      .to("5", [...hyperMods])
      .condition(inApp("silicio")),
    map("up_arrow", [...hyperMods])
      .to(toApp("Silicio"))
      .condition(inApp("silicio").unless()),
  ]);

// Per-app "toggle toolbar/sidebar" cleanup: Hyper+F15, or Hyper+Esc / Hyper+Caps on qmkless.
// The caps_lock line relies on this rule coming before action-key.ts in index.ts, whose caps_lock
// catch-all would otherwise take the event.
const cleanupUiScript = toScript("hyper-f15-cleanup.applescript");

const cleanupKeyRule = rule("Hyper+F15/Esc/Caps -> cleanup UI (per-app)")
  .manipulators([
    map("f15", [...hyperMods])
      .to(cleanupUiScript),
    map("escape", [...hyperMods])
      .to(cleanupUiScript)
      .condition(onDevice("qmkless")),
    map("caps_lock", [...hyperMods])
      .to(cleanupUiScript)
      .condition(onDevice("qmkless")),
  ]);

// Activate Firefox, send ⌃M, restore the previous app.
const muteFirefoxTabRule = rule("Hyper+N -> mute Firefox tab")
  .manipulators([
    map("n", [...hyperMods]).to(toScript("mute-firefox-tab.applescript")),
  ]);

// Hyper+O → send() over hs.ipc. Unlike `open hammerspoon2://…`, IPC doesn't activate HS2, so
// frontmost() is still the source app. Needs HS2 running with hs.ipc.start().
const sendToOmnifocusRule = rule("Hyper+O -> send to OmniFocus")
  .manipulators([
    map("o", [...hyperMods]).to$(
      `/opt/homebrew/bin/hs2 --no-prompt <<< 'require("./send-to-omnifocus.js").send()'`,
    ),
  ]);

export default [
  fullscreenRule,
  mediaKeysRule,
  brightnessRule,
  silicioRule,
  cleanupKeyRule,
  muteFirefoxTabRule,
  sendToOmnifocusRule,
];
