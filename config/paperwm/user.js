// -*- mode: gnome-shell -*-

var Meta = imports.gi.Meta;
var Clutter = imports.gi.Clutter;
var St = imports.gi.St;
var Main = imports.ui.main;
var Shell = imports.gi.Shell;

var workspaceManager = global.workspace_manager;

// Extension local imports
var Extension, Me, Tiling, Utils, App, Keybindings, Examples, Settings;

const wmClassesToMoveToScratch = [
    'evolution-alarm-notify', // Wayland
    'Evolution-alarm-notify', // X11
];

const directions = {
    Left: 'h',
    Down: 'j',
    Up: 'k',
    Right: 'l',
};

// ============================================
// Utility Functions
// ============================================

function getPreviousSpaceOnScreen() {
    let spaces = Tiling.spaces;
    const mru = [...spaces.stack];
    const from = mru.indexOf(spaces.selectedSpace);
    let to = from;
    do {
        to = (to + 1) % mru.length;
    } while (to !== from && mru[to].monitor !== spaces.selectedSpace.monitor);
    return mru[to];
}

function getMonitor(direction) {
    let display = global.display;
    let spaces = Tiling.spaces;

    let currentSpace = spaces.selectedSpace;
    let monitor = currentSpace.monitor;
    let i = display.get_monitor_neighbor_index(monitor.index, direction);
    let opposite;
    switch (direction) {
        case Meta.DisplayDirection.RIGHT:
            opposite = Meta.DisplayDirection.LEFT;
            break;
        case Meta.DisplayDirection.LEFT:
            opposite = Meta.DisplayDirection.RIGHT;
            break;
        case Meta.DisplayDirection.UP:
            opposite = Meta.DisplayDirection.DOWN;
            break;
        case Meta.DisplayDirection.DOWN:
            opposite = Meta.DisplayDirection.UP;
            break;
    }
    let n = i;
    if (i === -1) {
        let i = monitor.index;
        while (i !== -1) {
            n = i;
            i = display.get_monitor_neighbor_index(n, opposite);
        }
    }
    return Main.layoutManager.monitors[n];
}

// ============================================
// Keybindings
// ============================================

function activateWorkspaceOnCurrentMonitor() {
    /**
     * Focuses the workspace with the given index.
     *
     * If the workspace is currently visible on a monitor, the respective monitor gets focused.
     * Otherwise, the workspace is activated on the monitor that currently has focus.
     */
    function activateSpace(targetIndex) {
        let spaces = Tiling.spaces;
        let currentSpace = spaces.selectedSpace;
        let monitor = currentSpace.monitor;
        let target = workspaceManager.get_workspace_by_index(targetIndex);
        let targetSpace = spaces.spaceOf(target);
        let targetSpaceIsVisible = spaces.monitors.get(targetSpace.monitor) === targetSpace;
        if (!targetSpaceIsVisible) {
            targetSpace.setMonitor(monitor);
            spaces.monitors.set(monitor, targetSpace);
        }
        targetSpace.workspace.activate(global.get_current_time());
    }
    for (let k = 0; k <= 9; k++) {
        let targetIndex = (k + 9) % 10;
        Keybindings.bindkey(`<Super><Shift>${k}`, `goto-space-${targetIndex}`, () =>
            activateSpace(targetIndex),
        );
    }
}

function moveSpaceToMonitor(basebinding = '<super><alt>') {
    function moveTo(direction) {
        let spaces = Tiling.spaces;
        let currentSpace = spaces.selectedSpace;
        let nextMonitor = getMonitor(direction);
        getPreviousSpaceOnScreen().workspace.activate(global.get_current_time());
        currentSpace.setMonitor(nextMonitor);
        spaces.monitors.set(nextMonitor, currentSpace);
        currentSpace.workspace.activate(global.get_current_time());
    }

    for (let arrow of ['Down', 'Left', 'Up', 'Right']) {
        Keybindings.bindkey(`${basebinding}${arrow}`, `move-space-monitor-${arrow}`, () => {
            moveTo(Meta.DisplayDirection[arrow.toUpperCase()]);
        });
        Keybindings.bindkey(
            `${basebinding}${directions[arrow]}`,
            `move-space-monitor-${arrow}-alt`,
            () => {
                moveTo(Meta.DisplayDirection[arrow.toUpperCase()]);
            },
        );
    }
}

// ============================================
// Hooks
// ============================================

function init() {
    // Runs _only_ once on startup

    // Initialize extension imports here to make gnome-shell-reload work
    Extension = imports.misc.extensionUtils.getCurrentExtension();
    Me = Extension.imports.user;
    Tiling = Extension.imports.tiling;
    Utils = Extension.imports.utils;
    Keybindings = Extension.imports.keybindings;
    Examples = Extension.imports.examples;
    App = Extension.imports.app;
    Settings = Extension.imports.settings;

    // Keybindings
    moveSpaceToMonitor();
    Examples.keybindings.cycleMonitor();
    activateWorkspaceOnCurrentMonitor();

    // Window properties
    for (const wm_class of wmClassesToMoveToScratch) {
        Settings.defwinprop({
            wm_class,
            scratch_layer: true,
        });
    }
}

function enable() {
    // Runs on extension reloads, eg. when unlocking the session
}

function disable() {
    // Runs on extension reloads eg. when locking the session (`<super>L).
}
