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
        inputs.nur.hmModules.nur

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