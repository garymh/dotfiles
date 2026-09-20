import { map, rule, toApp } from "karabiner.ts";

import { inApp } from "../apps.ts";
import { toScript } from "../applescripts.ts";
import { hyperMods } from "../hyper.ts";
import { onDevice } from "../devices.ts";

// Ports of the retired Hammerspoon v1 `hyper.lua` bindings that are pure
// keystroke/media remaps — moved to Karabiner so they fire without
// round-tripping through Hammerspoon's event tap. The two that need app/menu-state logic
// (cleanup_key, mute_firefox_tab) are ported as AppleScript below, invoked
// via shell_command the same way the OmniFocus defer-to-tomorrow rule does.

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

// v1 hyper.lua's show_hide_sicilio(): if Silicio is frontmost, send it Hyper+5
// (its own show/hide shortcut); otherwise `open -a` launches it or brings an
// already-running-but-backgrounded instance forward.
const silicioRule = rule("Hyper+Up -> show/hide Silicio")
  .manipulators([
    map("up_arrow", [...hyperMods])
      .to("5", [...hyperMods])
      .condition(inApp("silicio")),
    map("up_arrow", [...hyperMods])
      .to(toApp("Silicio"))
      .condition(inApp("silicio").unless()),
  ]);

// v1 hyper.lua's cleanup_key(): per-app "toggle Toolbar/Sidebar" UI cleanup.
// Three triggers, all dispatching the same AppleScript:
//   - Hyper+F15:  QMK keyboards with a physical F15 key (e.g. topre).
//   - Hyper+Esc:  any keyboard with a physical escape (incl. qmkless).
//   - Hyper+Caps: qmkless keyboards where CapsLock is the cleanup proxy.
//                 Without this line, action-key.ts's caps_lock +
//                 optionalAny catches the caps_lock event and emits
//                 escape (for escapeApps) via toIfAlone — and as
//                 action-key.ts's top-of-file comment explains,
//                 Karabiner's manipulate() doesn't re-run
//                 complex_modifications on its own synthetic output,
//                 so this rule's escape + hyper line never sees it.
//                 Handling caps_lock + hyper here directly bypasses
//                 that. Plain CapsLock, CapsLock+Cmd/Shift/Opt still
//                 fall through to action-key's single-modifier rules.
//
// Positioned before action-key.ts in index.ts so this rule's
// caps_lock + hyper line wins over action-key's caps_lock +
// optionalAny catch-all on qmkless.
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

// v1 hyper.lua's mute_firefox_tab(): activates Firefox, sends ctrl+m, restores
// the previous frontmost app.
const muteFirefoxTabRule = rule("Hyper+N -> mute Firefox tab")
  .manipulators([
    map("n", [...hyperMods]).to(toScript("mute-firefox-tab.applescript")),
  ]);

// Hyper+O → file current item to OmniFocus via HS2 URL dispatch. Karabiner
// produces the quad-modifier combo correctly, and `open hammerspoon2://omnifocus`
// is a known-working dispatch path; this sidesteps a 4-modifier Carbon hotkey
// limitation in hs.hotkey.bind. HS2 picks up the URL via hs.urlevent and runs
// the per-app AppleScript chain (see send-to-omnifocus.js).
const sendToOmnifocusRule = rule("Hyper+O -> send to OmniFocus")
  .manipulators([
    map("o", [...hyperMods]).to$(`open "hammerspoon2://omnifocus"`),
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
