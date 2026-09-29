import QtQuick
import Quickshell
import Quickshell.Io

// Omagtk as an Omarchy plugin.
//
// On the first start after the plugin is enabled, it links the omagtk command
// to this clone and runs its setup. It skips that when omagtk is already
// installed, by the package or by install.sh.
//
// It then keeps `omagtk watch` running, which switches GTK3 apps straight
// back to Omagtk when Omarchy resets them to Adwaita during a theme change.
// Omagtk's theme-set hook would do the same, but only once every other theme
// command has finished, so apps would flash Adwaita in between.
Item {
  id: root

  // Injected by omarchy-shell.
  property var shell: null

  readonly property string home: Quickshell.env("HOME")
  readonly property string pluginDir: decodeURIComponent(
    Qt.resolvedUrl(".").toString().replace(/^file:\/\//, "").replace(/\/$/, ""))

  Process {
    id: watcher

    property real startedAt: 0

    running: true
    command: ["bash", "-c",
      "command -v omagtk >/dev/null || [[ -e $HOME/.local/bin/omagtk ]] || " +
      "\"$1/install.sh\" --link >/dev/null || exit; " +
      "PATH=$HOME/.local/bin:$PATH exec omagtk watch",
      "omagtk-plugin", root.pluginDir]

    onStarted: startedAt = Date.now()
    // Restart a watcher that dies, but not one that fails straight away,
    // such as an older omagtk without the watch command.
    onExited: function() {
      if (Date.now() - watcher.startedAt > 10000) restartTimer.start()
    }
  }

  Timer {
    id: restartTimer
    interval: 5000
    onTriggered: watcher.running = true
  }

  // Omarchy writes theme.name as soon as the new theme is in place, well
  // before it resets GTK. Generate the new colors now, so the watcher only
  // has to flip the setting back when the reset comes.
  FileView {
    path: root.home + "/.local/state/omarchy/current/theme.name"
    watchChanges: true
    onFileChanged: colors.running = true
  }

  Process {
    id: colors
    command: ["bash", "-c",
      "[[ -d $HOME/.local/share/themes/Omagtk ]] || exit 0; " +
      "PATH=$HOME/.local/bin:$PATH exec omagtk apply --colors"]
  }
}
