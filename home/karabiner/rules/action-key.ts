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

// caps_lock and the physical F15 key on qmkless keyboards each get their own copy of the per-app
// dispatch (action-dispatch.ts). Remapping them to a synthetic f15 for f15-actions.ts to catch
// doesn't work: Karabiner never feeds a manipulator's output back into other complex rules.

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
    // No app matched: plain f15 tap plus a notification.
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
