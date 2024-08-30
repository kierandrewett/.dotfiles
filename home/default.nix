{
    config,
    inputs,
    lib,
    outputs,
    pkgs,
    stateVersion,
    username,
    ...
}:
{
    imports = [
        ../lib/nix-config.nix
        ./features
        ./users
    ];

    home = {
        inherit stateVersion;
        inherit username;

        homeDirectory = "/home/${username}";
    };

    packages = with pkgs; [
        fastfetch
    ];

    fonts.fontconfig.enable = true;

    programs.home-manager.enable = true;

    xdg.enable = true;
}