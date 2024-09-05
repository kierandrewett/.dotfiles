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
    dconf.settings."org/gnome/shell" = {
        disable-user-extensions = false;
        disabled-extensions = [];
        enabled-extensions = builtins.map (extension: extension.extensionUuid) extensions;
    };

    "org/gnome/shell/extensions/dash-to-dock" = lib.mkIf (lib.elem dash-to-dock extensions) {

    };
}