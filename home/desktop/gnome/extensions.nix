{
    pkgs,
    lib,
    ...
}:
let
    extensions = with pkgs.gnomeExtensions; [
        appindicator
        bluetooth-battery
        color-picker
        dash-to-dock
        do-not-disturb-while-screen-sharing-or-recording
        gsconnect
        impatience
        mpris-label
        night-theme-switcher
        resource-monitor
        steal-my-focus-window
    ];
in
with pkgs.gnomeExtensions; {
    dconf.settings = {
        "org/gnome/shell" = {
            disable-user-extensions = false;
            disabled-extensions = [];
            enabled-extensions = builtins.map (extension: extension.extensionUuid) extensions;
        };

        "org/gnome/shell/extensions/color-picker" = lib.mkIf (lib.elem color-picker extensions) {
            enable-shortcut = true;
            color-picker-shortcut = "['<Super>comma']";
        };

        "org/gnome/shell/extensions/dash-to-dock" = lib.mkIf (lib.elem dash-to-dock extensions) {
            autohide = false;
            scroll-action = "cycle-windows";
            dock-fixed = true;
            intellihide = false;
            show-trash = false;
            show-mounts = false;
            require-pressure-to-show = false;
            running-indicator-style = "DOTS";
            dash-max-icon-size = 56;
        };

        "org/gnome/shell/extensions/mpris-label" = lib.mkIf (lib.elem mpris-label extensions) {
            auto-switch-to-most-recent = true;
            extension-place = "right";
            left-padding = 4;
            right-padding = 4;
            first-field = "xesam:title";
            second-field = "";
            last-field = "xesam:artist";
            divider-string = " - ";
            max-string-length = 20;
            refresh-rate = 1000;
            left-click-action = "activate-player";
        };

        "org/gnome/shell/extensions/nighttimeswitcher" = lib.mkIf (lib.elem night-theme-switcher extensions) {
            manual-schedule = false;
        };
    };
}