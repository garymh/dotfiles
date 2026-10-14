// watchers/swiftbar.js — 09:00 opens SwiftBar / 17:00 quits it, only when Home Assistant's
// workday_sensor is on. HA_TOKEN comes from $PRIVATE_FILE, the URL root from $HASS_SERVER.

// Disabled; set to true to re-enable.
const ENABLED = false;

let envCache = null;
async function loadEnv() {
  if (envCache) return envCache;
  // zsh, not hs.task.shell's /bin/sh: ~/.zprofile is zsh syntax.
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