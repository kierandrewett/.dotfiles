{
    pkgs,
    ...
}:
{
    imports = [
        ./dconf.nix
        ./extensions.nix
    ];

    programs.kdeconnect = {
        enable = true;
        package = pkgs.gnomeExtensions.gsconnect;
    };
}