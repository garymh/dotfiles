// karabiner.ts writes karabiner.json with a plain, unawaited fs.writeFile.
// writeToGlobal() and writeToProfile() below both fire one of these writes
// without waiting for it, so two writes to the same file can race each
// other, and Karabiner-Elements' own daemon rewrites the same file in the
// background (device list changes etc.) on top of that. Either race can
// interleave/clobber the file mid-flush. Serialize same-path writes through
// a queue and make each one atomic via temp-file + rename.
const fsPromises = require("node:fs/promises");
const originalWriteFile = fsPromises.writeFile;
let writeQueue = Promise.resolve();
fsPromises.writeFile = (path: string, data: string, ...rest: unknown[]) => {
  if (typeof path !== "string" || !path.endsWith("karabiner.json")) {
    return originalWriteFile(path, data, ...rest);
  }
  writeQueue = writeQueue.then(async () => {
    const tmpPath = `${path}.tmp-${process.pid}-${Date.now()}-${
      Math.random().toString(36).slice(2)
    }`;
    await originalWriteFile(tmpPath, data, ...rest);
    await fsPromises.rename(tmpPath, path);
  });
  return writeQueue;
};

import { writeToGlobal, writeToProfile } from "karabiner.ts";

import actionKey from "./rules/action-key.ts";
import browsers from "./rules/browsers.ts";
import f15Actions from "./rules/f15-actions.ts";
import ghostty from "./rules/ghostty.ts";
import hammerspoonPorts from "./rules/hammerspoon-ports.ts";
import mail from "./rules/mail.ts";
import mediaKeys from "./rules/media-keys.ts";
import misc from "./rules/misc.ts";
import moom from "./rules/moom.ts";
import modifiers from "./rules/modifiers.ts";
import omnifocus from "./rules/omnifocus.ts";
import pikatea from "./rules/pikatea.ts";
import terminal from "./rules/terminal.ts";
import vimArrows from "./rules/vim-arrows.ts";

// Only writeToProfile honors --dry-run (it prints instead of writing); the
// global write below is unconditional, so it would clobber the live config
// during a dry run. Guard it.
const dryRun = process.argv.includes("--dry-run");
const profile = dryRun ? "--dry-run" : "New Goku";

if (!dryRun) {
  writeToGlobal({
    show_in_menu_bar: false,
    show_profile_name_in_menu_bar: false,
  });
}

writeToProfile(
  profile,
  [
    ...modifiers,
    ...mail,
    ...browsers,
    ...ghostty,
    ...terminal,
    ...omnifocus,
    ...vimArrows,
    ...misc,
    ...moom,
    ...pikatea,
    ...hammerspoonPorts,
    ...actionKey,
    ...f15Actions,
    ...mediaKeys,
  ],
  {
    "basic.simultaneous_threshold_milliseconds": 500,
    "basic.to_if_alone_timeout_milliseconds": 500,
    "basic.to_if_held_down_threshold_milliseconds": 100,
  },
  // writeToProfile only touches profile.simple_modifications when extras are
  // passed, so the old unconditional f10/f11/f12 entries would otherwise
  // linger in karabiner.json. They now live in rules/media-keys.ts as
  // modifier-conditioned manipulators; this empties the leftover array.
  {
    simple_modifications: [],
  },
);
