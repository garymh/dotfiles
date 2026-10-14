// watchers/camera.js — Continuity Camera ("Cam Phone Camera") in use → Meeting focus (+ optional
// wallpaper swap); restored on release. Attaching to a hot-plugged camera can fail, so it retries
// once after ATTACH_RETRY_DELAY.

hs.permissions.requestCamera().catch(() => {});

const ATTACH_RETRY_DELAY = 0.5;

const cameraState = {
  cameraName: "Cam Phone Camera",
  cameraUID: null,
  cameraConnected: false,
  activeByUs: false,
  perCameraWatcher: null,
  hasWatcher: false,
  retryTimer: null,
  retryAttempted: false,
  meetingWallpaper: "/Users/gary/Documents/Wallpapers/Citrus Peel.jpg",
  previousWallpaper: null,
};

function log(msg) {
  console.log("[camera] " + msg);
}

// Off by default; flip at runtime: require("./watchers/camera.js").wallpaper.enabled = true
const wallpaper = { enabled: false };

function setWallpaper(path) {
  if (!wallpaper.enabled) return;
  hs.screen.all().forEach((s) => {
    s.desktopImage = path;
  });
}

function handleCameraState(inUse) {
  if (inUse && !cameraState.activeByUs) {
    log("Camera in use — enabling Meeting focus" + (wallpaper.enabled ? " + wallpaper" : ""));
    hs.shortcuts
      .run("AUTO: Turn on Meeting focus")
      .catch((e) => log("focus shortcut failed: " + e));
    if (wallpaper.enabled) {
      cameraState.previousWallpaper =
        hs.screen.main() && hs.screen.main().desktopImage;
      setWallpaper(cameraState.meetingWallpaper);
    }
    cameraState.activeByUs = true;
  } else if (!inUse && cameraState.activeByUs) {
    log("Camera no longer in use — disabling Meeting focus" + (wallpaper.enabled ? " + wallpaper" : ""));
    hs.shortcuts
      .run("AUTO: Turn off Meeting focus")
      .catch((e) => log("focus shortcut failed: " + e));
    if (wallpaper.enabled && cameraState.previousWallpaper)
      setWallpaper(cameraState.previousWallpaper);
    cameraState.activeByUs = false;
  }
}

function stopRetry() {
  if (cameraState.retryTimer) cameraState.retryTimer.stop();
  cameraState.retryTimer = null;
}

function findCamera(lightCam) {
  if (lightCam && lightCam.uid && typeof hs.camera.findByUID === "function") {
    const byUID = hs.camera.findByUID(lightCam.uid);
    if (byUID && byUID.name === cameraState.cameraName) return byUID;
  }
  return hs.camera.findByName(cameraState.cameraName);
}

function scheduleAttachRetry() {
  if (
    cameraState.retryAttempted ||
    cameraState.retryTimer ||
    cameraState.hasWatcher
  )
    return;

  cameraState.retryAttempted = true;
  log(
    "Camera not ready for in-use watcher; retrying in " +
      ATTACH_RETRY_DELAY +
      "s",
  );
  cameraState.retryTimer = hs.timer.doAfter(ATTACH_RETRY_DELAY, () => {
    cameraState.retryTimer = null;
    if (!cameraState.cameraConnected || cameraState.hasWatcher) return;

    const retryCam = hs.camera.findByName(cameraState.cameraName);
    if (retryCam) attachToCamera(retryCam);
    else
      log(
        "Camera retry failed: " +
          cameraState.cameraName +
          " is no longer connected",
      );
  });
}

function attachToCamera(cam) {
  if (cameraState.hasWatcher) return true;

  const on = cam && cam.on;
  if (typeof on !== "function") {
    scheduleAttachRetry();
    return false;
  }

  try {
    cameraState.perCameraWatcher = handleCameraState;
    on.call(cam, cameraState.perCameraWatcher);
  } catch (e) {
    cameraState.perCameraWatcher = null;
    log("Could not attach in-use watcher: " + e);
    scheduleAttachRetry();
    return false;
  }

  cameraState.hasWatcher = true;
  stopRetry();
  if (cam.isInUse) handleCameraState(true);
  log("In-use watcher attached to: " + cam.name);
  return true;
}

function connectToCamera(lightCam) {
  if (
    cameraState.cameraConnected &&
    cameraState.cameraUID &&
    lightCam.uid &&
    cameraState.cameraUID !== lightCam.uid
  ) {
    disconnectFromCamera();
  }

  cameraState.cameraConnected = true;
  cameraState.cameraUID = lightCam.uid || null;
  cameraState.retryAttempted = false;

  attachToCamera(findCamera(lightCam));
}

function disconnectFromCamera() {
  stopRetry();
  cameraState.cameraConnected = false;
  cameraState.cameraUID = null;
  cameraState.hasWatcher = false;
  cameraState.perCameraWatcher = null;
  cameraState.retryAttempted = false;
  if (cameraState.activeByUs) handleCameraState(false);
}

function onCameraEvent(event, lightCam) {
  if (!lightCam) {
    log(event + ": camera descriptor missing");
    return;
  }

  log(
    event +
      ": " +
      lightCam.name +
      " | activeByUs=" +
      cameraState.activeByUs +
      " hasWatcher=" +
      cameraState.hasWatcher,
  );

  if (lightCam.name !== cameraState.cameraName) return;
  if (event === "connected") {
    connectToCamera(lightCam);
  } else if (event === "disconnected") {
    if (
      cameraState.cameraUID &&
      lightCam.uid &&
      cameraState.cameraUID !== lightCam.uid
    )
      return;
    disconnectFromCamera();
  }
}

hs.camera.on("connected", (cam) => onCameraEvent("connected", cam));
hs.camera.on("disconnected", (cam) => onCameraEvent("disconnected", cam));

const initialCam = hs.camera.findByName(cameraState.cameraName);
if (initialCam) {
  connectToCamera(initialCam);
} else {
  log("Camera not found: " + cameraState.cameraName);
}

log("watcher initialized — event-driven mode");

module.exports = { wallpaper };
