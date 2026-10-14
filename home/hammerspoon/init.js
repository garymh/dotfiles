hs.ipc.start();

if (hs.ipc.isBinaryInstalled("/opt/homebrew/bin")) {
  console.log("hs2 CLI is available");
}

const { setHandler } = require("./send-to-omnifocus.js");

require("./watchers.js");

setHandler("Safari", "scripts/safari-to-omnifocus.applescript");
setHandler("Mail", "scripts/mail-to-omnifocus.applescript");

// Last: it touches AX at load, and a throw there would abort the rest of init.js.
require("./mail-vim.js");
