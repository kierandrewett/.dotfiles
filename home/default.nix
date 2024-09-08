{
    config,
    inputs,
    lib,
    outputs,
    pkgs,
    platform,
    stateVersion,
    username,
    desktop,
    hostname,
    ...
}:
{
    imports = [
        ./apps/all.nix
        ./desktop
        ./features
        ./users
        ./config
    ] ++ lib.optional (builtins.pathExists (./. + "/machines/${hostname}")) ./machines/${hostname};

    home = {
        inherit stateVersion;
        inherit username;

        homeDirectory = "/home/${username}";
    };

    programs = {
        home-manager.enable = true;
    };

    fonts.fontconfig.enable = true;

    xdg.enable = true;

    nixpkgs.config.allowUnfree = true;

    sops = {
        age = {
            keyFile = "${config.home.homeDirectory}/.config/sops/age/key.txt";
            generateKey = false;
        };

        defaultSopsFile = ../secrets/secrets.yaml;

        secrets = {
            "sync/nc/url" = {};
            "sync/nc/username" = {};
        };
    };
}