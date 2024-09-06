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
    ...
}:
{
    imports = [
        inputs.sops-nix.homeManagerModules.sops

        ./apps/all.nix
        ./desktop
        ./features
        ./users
    ];

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