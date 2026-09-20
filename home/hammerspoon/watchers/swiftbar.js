// watchers/swiftbar.js — port of watchers/swiftbar.lua
// 09:00 opens SwiftBar / 17:00 kills it, only if HA workday_sensor is on
// (token from $PRIVATE_FILE in ~/.zprofile; $HASS_SERVER provides the URL root).
// ponytail: hs.http.asyncGet → hs.http.get(url, headers) Promise; always resolves, check status.
// ponytail: hs.application.open(name) gone — launchOrFocus() takes a bundleID (com.ameba.SwiftBar).
// ponytail: hs.timer.doAt takes seconds-since-midnight, not a "09:00" string.

// Toggle for the 09:00/17:00 SwiftBar automation; flip to true to re-enable.
const ENABLED = false;

let envCache = null;
async function loadEnv() {
  if (envCache) return envCache;
  // ponytail: hs.task.shell uses /bin/sh; explicit /bin/zsh to source ~/.zprofile.
  const r = await hs.task.runAsync("/bin/zsh", ["-c",
    'source "$HOME/.zprofile" && printf "%s\\n%s" "${(e)PRIVATE_FILE}" "${(e)HASS_SERVER}"',
  ]);
  if (r.exitCode !== 0) {
    throw new Error("source ~/.zprofile failed: " + (r.stderr || "exit " + r.exitCode));
  }
  const [privateFile, hassServer] = r.stdout.trim().split("\n");
  if (!privateFile || !hassServer) {
    throw new Error("$PRIVATE_FILE or $HASS_SERVER missing from ~/.zprofile");
  }
  envCache = { privateFile, hassServer };
  return envCache;
}

async function readToken() {
  const { privateFile } = await loadEnv();
  const content = hs.fs.read(privateFile, 0, 65536);
  if (!content) return null;
  const m = content.match(/^(?:export\s+)?HA_TOKEN=["']?([^"'\r\n]+)/m);
  return m ? m[1] : null;
}

async function openSwiftBar() {
  const token = await readToken();
  if (!token) {
    console.log("[swiftbar] could not read HA_TOKEN from $PRIVATE_FILE in ~/.zprofile");
    return;
  }

  const { hassServer } = await loadEnv();
  const haUrl = hassServer + "/api/states/binary_sensor.workday_sensor";

  try {
    const res = await hs.http.get(haUrl, {
      Authorization: "Bearer " + token,
      "Content-Type": "application/json",
    });
    if (res.status !== 200) {
      console.log("[swiftbar] API returned status " + res.status);
      return;
    }

    const data = JSON.parse(res.body);
    if (data.state === "on") {
      console.log("[swiftbar] workday sensor is on, opening SwiftBar");
      const app = hs.application.matchingName("SwiftBar");
      if (app) app.activate();
      // ponytail: HS2 launchOrFocus returns a Promise; await to surface failures.
      else await hs.application.launchOrFocus("com.ameba.SwiftBar");
    } else {
      console.log("[swiftbar] workday sensor is off, skipping");
    }
  } catch (e) {
    console.log("[swiftbar] error: " + e);
  }
}

function closeSwiftBar() {
  const app = hs.application.matchingName("SwiftBar");
  if (app) {
    console.log("[swiftbar] closing SwiftBar");
    app.kill();
  }
}

if (ENABLED) {
  hs.timer.doAt(9 * 3600, 24 * 3600, openSwiftBar, true);
  hs.timer.doAt(17 * 3600, 24 * 3600, closeSwiftBar, true);
}