{
    lib,
    desktop,
    pkgs,
    ...
}:
{
    imports = lib.optional (builtins.pathExists (./. + "/${desktop}")) ./${desktop};

    services.dbus.enable = true;
    programs.dconf.enable = true;

    # Exclude xterm
    services.xserver = {
        desktopManager.xterm.enable = false;
        excludePackages = [ pkgs.xterm ];
    };
}