// -*- mode: gnome-shell -*-

var Meta = imports.gi.Meta;
var Clutter = imports.gi.Clutter;
var St = imports.gi.St;
var Main = imports.ui.main;
var Shell = imports.gi.Shell;
var Extension = imports.misc.extensionUtils.getCurrentExtension();
var Me = Extension.imports.user;
var Tiling = Extension.imports.tiling;
var Utils = Extension.imports.utils;
var Keybindings = Extension.imports.keybindings;
var App = Extension.imports.app;

var onDisable = [];
var signals = new Utils.Signals();

function init() {
    // registerMoveSpaceToMonitor();
    // registerActivateWorkspaceOnCurrentMonitor();
}

function enable() {
    // Runs on extension reloads, eg. when unlocking the session
    connectWindowHorizontalScroll();
}

function disable() {
    // Runs on extension reloads eg. when locking the session (`<super>L).
    onDisable.forEach((f) => f());
    onDisable = [];
}

/**
 * Scroll through windows horizontally using super + scroll wheel.
 */
function connectWindowHorizontalScroll() {
    const wm = imports.ui.windowManager;
    const WindowManager = wm.WindowManager;
    const stage = global.stage;
    const Navigator = Extension.imports.navigator;

    function handleScroll(event) {
        if (event.get_scroll_direction() === Clutter.ScrollDirection.UP) {
            const tabPopup = Navigator.getActionDispatcher(Clutter.GrabState.KEYBOARD);
            tabPopup.show(false, 'switch-left', Clutter.ModifierType.MOD4_MASK);
            return Clutter.EVENT_STOP;
        } else if (event.get_scroll_direction() === Clutter.ScrollDirection.DOWN) {
            const tabPopup = Navigator.getActionDispatcher(Clutter.GrabState.KEYBOARD);
            tabPopup.show(false, 'switch-right', Clutter.ModifierType.MOD4_MASK);
            return Clutter.EVENT_STOP;
        }
        // Smooth scrolling without switching focus. A bit buggy.
        //
        // const space = Tiling.spaces.selectedSpace;
        // if (event.get_scroll_direction() === Clutter.ScrollDirection.SMOOTH) {
        //     const [dx, dy] = event.get_scroll_delta();
        //     const sensitivity = 100;
        //     const delta = dy * sensitivity;
        //     const target = Math.round(space.targetX - delta);
        //     space.targetX = target;
        //     space.cloneContainer.x = target;
        //     space.moveDone();
        //     return Clutter.EVENT_STOP;
        // }
        return Clutter.EVENT_PROPAGATE;
    }

    signals.connect(stage, 'scroll-event', (actor, event) => {
        const allowedModes = Shell.ActionMode.NORMAL;
        if ((allowedModes & Main.actionMode) === 0) {
            return Clutter.EVENT_PROPAGATE;
        } else if ((event.get_state() & global.display.compositor_modifiers) === 0) {
            return Clutter.EVENT_PROPAGATE;
        } else {
            return handleScroll(event);
        }
    });

    const originalHandleWorkspaceScroll = WindowManager.prototype.handleWorkspaceScroll;
    WindowManager.prototype.handleWorkspaceScroll = function (event) {
        if (Main.overview.visible) {
            return originalHandleWorkspaceScroll.apply(this, [event]);
        } else {
            return Clutter.EVENT_PROPAGATE;
        }
    };
    onDisable.push(() => {
        WindowManager.prototype.handleWorkspaceScroll = originalHandleWorkspaceScroll;
    });
}

function registerMoveSpaceToMonitor(basebinding = '<super><alt>') {
    /**
     * Move the active workspace to a neighboring monitor in the given direction.
     *
     * The active monitor switches back the last workspace that was active on that monitor.
     */
    function moveTo(direction) {
        let spaces = Tiling.spaces;
        let currentSpace = spaces.selectedSpace;
        let nextMonitor = getMonitor(direction);
        getPreviousSpaceOnMonitor().workspace.activate(global.get_current_time());
        currentSpace.setMonitor(nextMonitor);
        spaces.monitors.set(nextMonitor, currentSpace);
        currentSpace.workspace.activate(global.get_current_time());
    }

    for (let arrow of ['Down', 'Left', 'Up', 'Right']) {
        Keybindings.bindkey(`${basebinding}${arrow}`, `move-space-monitor-${arrow}`, () => {
            moveTo(Meta.DisplayDirection[arrow.toUpperCase()]);
        });
    }
}

function registerActivateWorkspaceOnCurrentMonitor(basebinding = '<super><alt>') {
    let workspaceManager = global.workspace_manager;
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
        Keybindings.bindkey(`${basebinding}${k}`, `goto-space-${targetIndex}`, () =>
            activateSpace(targetIndex),
        );
    }
}

/** Returns the neighboring monitor in the given direction relative to the active monitor. */
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

/** Returns the last workspace that was active on the active monitor. */
function getPreviousSpaceOnMonitor() {
    let spaces = Tiling.spaces;
    const mru = [...spaces.stack];
    const from = mru.indexOf(spaces.selectedSpace);
    let to = from;
    do {
        to = (to + 1) % mru.length;
    } while (to !== from && mru[to].monitor !== spaces.selectedSpace.monitor);
    return mru[to];
}
