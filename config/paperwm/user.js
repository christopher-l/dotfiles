// -*- mode: gnome-shell -*-

var Meta = imports.gi.Meta;
var Clutter = imports.gi.Clutter;
var St = imports.gi.St;
var Main = imports.ui.main;
var Shell = imports.gi.Shell;

var workspaceManager = global.workspace_manager;

// Extension local imports
var Extension, Me, Tiling, Utils, App, Keybindings, Examples, Settings;

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
        Keybindings.bindkey(`<Super>${k}`, `goto-space-${targetIndex}`, () =>
            activateSpace(targetIndex),
        );
    }
}

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
    Examples.keybindings.moveSpaceToMonitor();
    Examples.keybindings.cycleMonitor();
    // Examples.keybindings.gotoByIndex();
    activateWorkspaceOnCurrentMonitor();

    // Window properties
    Settings.defwinprop({
        wm_class: '',
        title: 'HyperLightDrifter',
        scratch_layer: true,
    });
}

function enable() {
    // Runs on extension reloads, eg. when unlocking the session
}

function disable() {
    // Runs on extension reloads eg. when locking the session (`<super>L).
}
