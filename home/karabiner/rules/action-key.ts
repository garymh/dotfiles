import {
  map,
  rule,
  toNotificationMessage,
  toRemoveNotificationMessage,
} from "karabiner.ts";

import { inApp } from "../apps.ts";
import { toScript } from "../applescripts.ts";
import { onDevice } from "../devices.ts";
import {
  baseDispatch,
  hideEvent,
  shiftDispatch,
  shiftScriptDispatch,
} from "./action-dispatch.ts";

// caps_lock and the physical F15 key were originally remapped to a
// synthetic f15 tap, which Hammerspoon v1's actions.lua (a separate,
// OS-level CGEventTap listener sitting *downstream* of Karabiner's virtual
// keyboard output) then caught and dispatched per frontmost app.
//
// That relay does NOT work if the dispatch also lives inside Karabiner:
// karabiner_grabber loads every complex_modifications rule, across the
// whole profile, into a single flat manipulator list (confirmed in
// Karabiner-Elements' own source, device_grabber.hpp's
// update_complex_modifications_manipulators()), and its manipulate() loop
// only lets the *first* manipulator whose `from` matches the real incoming
// event fire — later manipulators never see that manipulator's synthetic
// `to` output in the same pass (proven by Karabiner's own test fixture,
// tests/.../manipulator_manager/{rules,expected_event_queue}/multiple.json).
//
// So instead of caps_lock/f15 -> (synthetic) f15 -> per-app dispatch, each
// physical source (caps_lock, the real F15 key) gets its own copy of the
// per-app dispatch (shared with f15-actions.ts, see action-dispatch.ts)
// directly in to_if_alone/to. A genuine hardware F15 key on a
// *non*-qmkless keyboard still isn't intercepted here, so it falls
// through to f15-actions.ts's unconditioned rules as before.
//
// The pre-fold version is kept as modifiers.ts's legacyCapsLockF15RelayRule
// (unwired, for reference/rollback).
//
// Timing parameters aren't set per-manipulator here — they match
// index.ts's global to_if_alone/to_if_held_down defaults already.

function actionKeyManipulators(fromKey: "caps_lock" | "f15") {
  return [
    // opt+key -> hide frontmost app
    map(fromKey, "left_option")
      .to(hideEvent)
      .condition(onDevice("qmkless")),

    // cmd+key -> cmd+f15. currently Moom activator
    map(fromKey, "left_command")
      .to("f15", "left_command")
      .condition(onDevice("qmkless")),

    ...shiftDispatch.map(([app, event]) =>
      map(fromKey, "left_shift").to(event)
        .condition(onDevice("qmkless"), inApp(app))
    ),
    ...shiftScriptDispatch.map(([app, script]) =>
      map(fromKey, "left_shift")
        .to(toScript(script))
        .condition(onDevice("qmkless"), inApp(app))
    ),

    ...baseDispatch.map(([app, event]) =>
      map(fromKey, "optionalAny")
        .to("left_control")
        .toIfAlone(event)
        .condition(onDevice("qmkless"), inApp(app))
    ),
    // Unmatched app: preserve the old plain-f15 passthrough as a last resort
    // (still won't be caught by another complex_modifications rule, but
    // harmless, and matches the key's pre-fold behavior for anything else),
    // plus a heads-up notification.
    map(fromKey, "optionalAny")
      .to("left_control")
      .toIfAlone([
        { key_code: "f15" },
        toNotificationMessage("action-key-unmatched", "No action bound for this app"),
      ])
      .toDelayedAction(
        toRemoveNotificationMessage("action-key-unmatched"),
        toRemoveNotificationMessage("action-key-unmatched"),
      )
      .parameters({ "basic.to_delayed_action_delay_milliseconds": 2000 })
      .condition(onDevice("qmkless")),
  ];
}

const capsLockActionKeyRule = rule("caps_lock action key (per-app dispatch)")
  .manipulators(
    actionKeyManipulators("caps_lock"),
  );

const f15QmkActionKeyRule = rule(
  "physical F15 action key (per-app dispatch, qmkless)",
).manipulators(actionKeyManipulators("f15"));

export default [capsLockActionKeyRule, f15QmkActionKeyRule];
