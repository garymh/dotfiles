import { to$ } from "karabiner.ts";

export const scriptsDir = "$HOME/iCloud/Internal/custom/applescripts";

// Run an AppleScript from scriptsDir (e.g. "defer-to-tomorrow.scpt").
export function toScript(file: string) {
  return to$(`osascript "${scriptsDir}/${file}"`);
}

export function toHideApp(name: string) {
  return to$(
    `osascript -e 'tell application "System Events" to set visible of process "${name}" to false'`,
  );
}

// Run a saved action by display name on an AppleScriptable app
// (e.g. Moom, Keyboard Maestro). Wrap the action name in quotes yourself
// if it contains spaces or shell metacharacters.
export function toRunAction(app: string, actionName: string) {
  return to$(`osascript -e 'tell application "${app}" to run "${actionName}"'`);
}

// Play a system sound at a shortcut trigger. Combine with other to-events:
//   map('c').to([playSound(sounds.tink), toApp('Calendar')])
export function playSound(soundPath: string) {
  return to$(`afplay ${soundPath}`);
}

// Common macOS system sounds. Add more paths as needed.
export const sounds = {
  tink: "/System/Library/Sounds/Tink.aiff ",
  pop: "/System/Library/Sounds/Pop.aiff  ",
  glass: "/System/Library/Sounds/Glass.aiff",
  frog: "/System/Library/Sounds/Frog.aiff ",
} as const;
