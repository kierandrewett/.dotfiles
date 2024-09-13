{
    pkgs,
    ...
}:
{
    imports = [
        ./spotify.nix
    ];

    home.packages = with pkgs; [
        vlc
        obs-studio
        handbrake
        audacity
        kdenlive
    ];
}