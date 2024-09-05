{
    pkgs,
    inputs,
    platform,
    ...
}:
{
    home.packages = with pkgs; [
        microsoft-edge
        vivaldi
        tor-browser
    ];

    programs.firefox = {
        enable = true;
        package = inputs.firefox-nightly.packages.${platform}.firefox-nightly-bin;
    };

    programs.google-chrome.enable = true;
}