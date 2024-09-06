{
    pkgs,
    ...
}:
{
    imports = [
        ./firefox.nix
    ];

    environment.systemPackages = with pkgs; [
        microsoft-edge
        vivaldi
        tor-browser
    ];

    programs.google-chrome.enable = true;
}