import { map, rule } from "karabiner.ts";

import { onDevice } from "../devices.ts";
import { withPrivateEnv } from "../private-env.ts";

const onPikatea = onDevice("pikatea");

function homeAssistant(device: string) {
  return withPrivateEnv(`/opt/homebrew/bin/hass-cli -o yaml state toggle ${device}`);
}

function runShortcut(name: string) {
  return `/usr/bin/shortcuts run "${name}"`;
}

const pikateaToggleIemsRule = rule("toggle iems pikatea", onPikatea)
  .manipulators([
    map("f1").to$(runShortcut("Toggle IEMs")),
  ]);

const pikateaPacmanGhostRule = rule("pacman ghost pikatea", onPikatea)
  .manipulators([
    map("f2").to$(homeAssistant("switch.office_pacman_ghost_outlet")),
  ]);

//   map("f3")
//   map("f4")
//   map("f5")

export default [
  pikateaToggleIemsRule,
  pikateaPacmanGhostRule,
];
