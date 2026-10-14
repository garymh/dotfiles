import { toKey } from "karabiner.ts";

// N presses of one key as a single `.to()` array, e.g.
// map("j", "⌃⇧").to(repeat("down_arrow", 5)).
export const repeat = (key: Parameters<typeof toKey>[0], n: number) =>
  Array.from({ length: n }, () => toKey(key));
