import { rule, withModifier } from "karabiner.ts";

import { toRunAction } from "../applescripts.ts";

// right_command + h/j/k/l → Moom "Move Left/Down/Up/Right", + s → "Embiggen",
// + f → "Toggle Full Screen".
// Moom needs actions with these exact names.
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
