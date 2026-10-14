import { map, rule } from "karabiner.ts";

import { inApp } from "../apps.ts";
import { toScript } from "../applescripts.ts";
import {
  baseDispatch,
  hideEvent,
  shiftDispatch,
  shiftScriptDispatch,
} from "./action-dispatch.ts";

// Hardware F15 keys on non-qmkless keyboards. On qmkless keyboards action-key.ts, which comes
// earlier in index.ts, consumes F15 first.

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
