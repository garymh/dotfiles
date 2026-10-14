// karabiner.ts fires unawaited fs.writeFile calls (writeToGlobal + writeToProfile), and the
// Karabiner daemon rewrites karabiner.json too. Serialize same-path writes and make each atomic
// (temp file + rename) so they can't clobber each other mid-flush.
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
import mailVim from "./rules/mail-vim.ts";
import mediaKeys from "./rules/media-keys.ts";
import misc from "./rules/misc.ts";
import moom from "./rules/moom.ts";
import modifiers from "./rules/modifiers.ts";
import omnifocus from "./rules/omnifocus.ts";
import pikatea from "./rules/pikatea.ts";
import terminal from "./rules/terminal.ts";
import vimArrows from "./rules/vim-arrows.ts";

// writeToGlobal ignores --dry-run, so skip it there.
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
    ...mailVim,
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
  // Keep simple_modifications empty; the media keys are in rules/media-keys.ts.
  {
    simple_modifications: [],
  },
);
