{
    config,
    inputs,
    lib,
    outputs,
    pkgs,
    platform,
    stateVersion,
    username,
    ...
}:
{
    imports = [
        inputs.sops-nix.homeManagerModules.sops

        ../lib/nix-config.nix
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

    packages = with pkgs; [
        fastfetch
    ];

    fonts.fontconfig.enable = true;

    xdg.enable = true;
}