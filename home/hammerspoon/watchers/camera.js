// watchers/camera.js — port of watchers/camera.lua
// Continuity camera ("Cam Phone Camera") in use → Meeting focus + wallpaper swap; restore on release.
// ponytail: hs.screen.wallpaper gone — HS2 exposes screen.desktopImage (settable path or file:// URL).
//
// Fully event-driven. Verified against a patched Hammerspoon 2 (hs-camera-emitter-fix.patch):
// attaching the per-camera watcher inside the "connected" notification works and native
// in-use callbacks fire. Unpatched builds throw inside HSCamera.addWatcher() for hot-plugged
// Continuity cameras, so a single delayed retry remains as a cheap safety net.

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

function setWallpaper(path) {
  // hs.screen.all().forEach((s) => {
  //   s.desktopImage = path;
  // });
}

function handleCameraState(inUse) {
  if (inUse && !cameraState.activeByUs) {
    log("Camera in use — enabling Meeting focus + wallpaper");
    hs.shortcuts
      .run("AUTO: Turn on Meeting focus")
      .catch((e) => log("focus shortcut failed: " + e));
    cameraState.previousWallpaper =
      hs.screen.main() && hs.screen.main().desktopImage;
    setWallpaper(cameraState.meetingWallpaper);
    cameraState.activeByUs = true;
  } else if (!inUse && cameraState.activeByUs) {
    log("Camera no longer in use — disabling Meeting focus + wallpaper");
    hs.shortcuts
      .run("AUTO: Turn off Meeting focus")
      .catch((e) => log("focus shortcut failed: " + e));
    if (cameraState.previousWallpaper)
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

  const addWatcher = cam && cam.addWatcher;
  if (typeof addWatcher !== "function") {
    scheduleAttachRetry();
    return false;
  }

  try {
    cameraState.perCameraWatcher = handleCameraState;
    addWatcher.call(cam, cameraState.perCameraWatcher);
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

hs.camera.addWatcher((event, lightCam) => {
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
});

const initialCam = hs.camera.findByName(cameraState.cameraName);
if (initialCam) {
  connectToCamera(initialCam);
} else {
  log("Camera not found: " + cameraState.cameraName);
}

log("watcher initialized — event-driven mode");
