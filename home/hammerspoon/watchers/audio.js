let audioDebounceTimer = null;

const DEFAULT_SHORTCUT = "Set Correct Soundsource Preset";
const IEM = "AUTO: IEMs";
const GAIRPODS = "AUTO: Gairpods";
const STEELSERIES = "AUTO: Steelseries";
const MBSPEAKERS = "AUTO: Macbook Speakers";

// Output device name → shortcut; any other device runs DEFAULT_SHORTCUT.
const DEVICE_ACTIONS = {
  "RODECaster Pro II Secondary": STEELSERIES,
  "Gairpods Pro": GAIRPODS,
  "MacBook Pro Speakers": MBSPEAKERS,
};

// dOut = default output changed. The listener gets no device, so read it when the debounce fires.
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
