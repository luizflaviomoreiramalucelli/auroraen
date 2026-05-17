const { app, BrowserWindow, nativeTheme } = require("electron");
const express = require("express");
const path = require("path");

let splash;
let mainWindow;
let splashStartTime = 0;
const minSplashDuration = 3000;

function getWebPath() {
  return app.isPackaged
    ? path.join(process.resourcesPath, "web")
    : path.join(__dirname, "../build/web");
}

function createSplashWindow() {
  const isDark = nativeTheme.shouldUseDarkColors;
  splashStartTime = Date.now();

  splash = new BrowserWindow({
    width: 1200,
    height: 800,
    frame: false,
    resizable: false,
    movable: true,
    alwaysOnTop: true,
    transparent: false,
    backgroundColor: isDark ? "#0b0b14" : "#f5f5f5",
  });

  splash.loadFile(path.join(__dirname, "splash.html"));
}

function showMainWindowWhenReady() {
  const elapsed = Date.now() - splashStartTime;
  const remaining = Math.max(0, minSplashDuration - elapsed);

  setTimeout(() => {
    if (splash) {
      splash.close();
      splash = null;
    }

    if (mainWindow) {
      mainWindow.show();
    }
  }, remaining);
}

function createMainWindow(port) {
  const isDark = nativeTheme.shouldUseDarkColors;

  mainWindow = new BrowserWindow({
    width: 1200,
    height: 800,
    show: false,
    backgroundColor: isDark ? "#0b0b14" : "#f5f5f5",
  });

  mainWindow.loadURL(`http://127.0.0.1:${port}`);

  mainWindow.once("ready-to-show", () => {
    showMainWindowWhenReady();
  });
}

function startServer() {
  const webPath = getWebPath();
  const expressApp = express();

  console.log("Serving Flutter from:", webPath);

  expressApp.use(express.static(webPath));

  expressApp.use((req, res) => {
    res.sendFile(path.join(webPath, "index.html"));
  });

  const listener = expressApp.listen(0, "127.0.0.1", () => {
    const port = listener.address().port;
    console.log("Listening on:", port);
    createMainWindow(port);
  });
}

app.whenReady().then(() => {
  createSplashWindow();
  startServer();
});