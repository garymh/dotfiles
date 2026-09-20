import { map, rule } from "karabiner.ts";

// ctrl+hjkl -> arrow keys from left control (or capslock)
const vimArrowLeftRule = rule("vim ctrl arrow key left").manipulators([
  map("h", "left_control", "any").to("left_arrow"),
]);

const vimArrowRightRule = rule("vim ctrl arrow key right").manipulators([
  map("l", "left_control", "any").to("right_arrow"),
]);

const vimArrowUpRule = rule("vim ctrl arrow key up").manipulators([
  map("k", "left_control", "any").to("up_arrow"),
]);

const vimArrowDownRule = rule("vim ctrl arrow key down").manipulators([
  map("j", "left_control", "any").to("down_arrow"),
]);

export default [
  vimArrowLeftRule,
  vimArrowRightRule,
  vimArrowUpRule,
  vimArrowDownRule,
];
