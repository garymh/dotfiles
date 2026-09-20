import { rule, withModifier } from "karabiner.ts";

import { toRunAction } from "../applescripts.ts";

// right_command + h/j/k/l → Moom "Move Left/Down/Up/Right".
// Moom must have actions with these exact names (AppleScript `run` takes
// the action's display name as a string). Rename either side to match.
export default [
  rule("right_command + hjkl → Moom move").manipulators([
    withModifier("right_command")({
      h: toRunAction("Moom", "Move Left"),
      j: toRunAction("Moom", "Move Down"),
      k: toRunAction("Moom", "Move Up"),
      l: toRunAction("Moom", "Move Right"),
      s: toRunAction("Moom", "Embiggen"),
      f: toRunAction("Moom", "Toggle Full Screen"),
    }),
  ]),
];
