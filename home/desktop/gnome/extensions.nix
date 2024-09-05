{
    pkgs,
    lib,
    ...
}:
let
    extensions = with pkgs.gnomeExtensions; [
        dash-to-dock
    ];
in
with pkgs.gnomeExtensions; {
    dconf.settings = {
        "org/gnome/shell" = {
            disable-user-extensions = false;
            disabled-extensions = [];
            enabled-extensions = builtins.map (extension: extension.extensionUuid) extensions;
        };

        "org/gnome/shell/extensions/dash-to-dock" = lib.mkIf (lib.elem dash-to-dock extensions) {
            autohide = false;
            scroll-action = "cycle-windows";
            intellihide = false;
            show-trash = false;
            show-mounts = false;
            running-indicator-style = "DOTS";
            dash-max-icon-size = 48;
        };
    };
}