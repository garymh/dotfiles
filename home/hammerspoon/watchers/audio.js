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

hs.audiodevice.addWatcher((event, device) => {
  if (audioDebounceTimer) audioDebounceTimer.stop();
  audioDebounceTimer = hs.timer.doAfter(1.5, () => {
    audioDebounceTimer = null;
    const shortcut =
      (device && DEVICE_ACTIONS[device.name]) || DEFAULT_SHORTCUT;
    hs.shortcuts
      .run(shortcut)
      .catch((e) => console.log("[audio] shortcut failed: " + e));
  });
});
