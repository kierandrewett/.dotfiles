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
        inputs.sops-nix.homeManagerModules.sops

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
}