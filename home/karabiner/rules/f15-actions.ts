import { map, rule } from "karabiner.ts";

import { inApp } from "../apps.ts";
import { toScript } from "../applescripts.ts";
import {
  baseDispatch,
  hideEvent,
  shiftDispatch,
  shiftScriptDispatch,
} from "./action-dispatch.ts";

// These rules match a bare physical F15 key_down directly, so they only
// fire for a *real* hardware F15 (e.g. a keyboard with a literal F15 key,
// not on a qmkless device). On qmkless keyboards, action-key.ts's
// f15QmkActionKeyRule/capsLockActionKeyRule run the same dispatch off
// caps_lock/f15's to_if_alone instead, and — being earlier in index.ts's
// rule list — consume the event first, so these rules never see it there.
// (See action-key.ts's comment for why the two can't just relay into
// each other.)

const f15ActionRule = rule("F15 action key (per-app)")
  .manipulators(
    baseDispatch.map(([app, event]) =>
      map("f15").to(event)
        .condition(inApp(app))
    ),
  );

const f15ShiftActionRule = rule("shift+F15 action key (per-app)")
  .manipulators([
    ...shiftDispatch.map(([app, event]) =>
      map("f15", "left_shift")
        .to(event)
        .condition(inApp(app))
    ),
    ...shiftScriptDispatch.map(([app, script]) =>
      map("f15", "left_shift")
        .to(toScript(script))
        .condition(inApp(app))
    ),
  ]);

const f15HideAppRule = rule("opt+F15 hide frontmost app")
  .manipulators([
    map("f15", "left_option")
      .to(hideEvent),
  ]);

export default [
  f15ActionRule,
  f15ShiftActionRule,
  f15HideAppRule,
];
