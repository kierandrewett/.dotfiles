{
    pkgs,
    inputs,
    platform,
    ...
}:
{
    imports = [
        ./firefox.nix
    ];

    home.packages = with pkgs; [
        microsoft-edge
        vivaldi
        tor-browser
    ];

    programs.google-chrome.enable = true;
}