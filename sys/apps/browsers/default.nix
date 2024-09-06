{
    pkgs,
    ...
}:
{
    imports = [
        ./firefox.nix
    ];

    environment.systemPackages = with pkgs; [
        google-chrome
        microsoft-edge
        vivaldi
        tor-browser
    ];
}