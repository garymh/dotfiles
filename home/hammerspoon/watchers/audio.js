let audioDebounceTimer = null;

const DEFAULT_SHORTCUT = "Set Correct Soundsource Preset";
const IEM = "AUTO: IEMs";
const GAIRPODS = "AUTO: Gairpods";
const STEELSERIES = "AUTO: Steelseries";
const MBSPEAKERS = "AUTO: Macbook Speakers";

// ponytail: edit the right-hand string per device to override the default.
const DEVICE_ACTIONS = {
  "RODECaster Pro II Secondary": STEELSERIES,
  "Gairpods Pro": GAIRPODS,
  "MacBook Pro Speakers": MBSPEAKERS,
};

// ponytail: 0.0.13 replaced addWatcher(cb) with on(event, cb), and the listener no longer receives
// the changed device — resolve the current default output when the debounce fires. "dOut" is the
// default-output-changed event; dev+ in particular fires for devices that never become the output.
hs.audiodevice.on("dOut", () => {
  if (audioDebounceTimer) audioDebounceTimer.stop();
  audioDebounceTimer = hs.timer.doAfter(1.5, () => {
    audioDebounceTimer = null;
    const device = hs.audiodevice.defaultOutputDevice();
    const shortcut =
      (device && DEVICE_ACTIONS[device.name]) || DEFAULT_SHORTCUT;
    hs.shortcuts
      .run(shortcut)
      .catch((e) => console.log("[audio] shortcut failed: " + e));
  });
});
