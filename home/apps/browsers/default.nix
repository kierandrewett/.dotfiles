{
    inputs,
    platform,
    ...
}:
{
    programs.firefox = {
        enable = true;
        package = inputs.firefox-nightly.packages.${platform}.firefox-nightly-bin;
    };

    programs.google-chrome.enable = true;
    programs.microsoft-edge.enable = true;
    programs.vivaldi.enable = true;
    programs.tor-browser.enable = true;
}