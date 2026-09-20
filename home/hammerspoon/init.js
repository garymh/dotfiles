hs.ipc.start();

if (hs.ipc.isBinaryInstalled("/opt/homebrew/bin")) {
  console.log("hs2 CLI is available");
}

require("./utils.js");
require("./caffeine.js");
require("./layout.js");
require("./watchers.js");
require("./send-to-omnifocus.js");

setHandler("Safari", "scripts/safari-to-omnifocus.applescript");
setHandler("Mail", "scripts/mail-to-omnifocus.applescript");
