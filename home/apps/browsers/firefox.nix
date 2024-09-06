{
    inputs,
    platform,
    ...
}:
let
    package = inputs.firefox-nightly.packages.${platform}.firefox-nightly-bin;
    addons = inputs.firefox-addons.packages.${platform};
in
{
    programs.firefox = {
        enable = true;
        enableGnomeExtensions = true;

        inherit package;

        profiles = {
            default = {
                isDefault = true;

                search = {
                    force = true;
                    default = "DuckDuckGo";
                };

                extensions = with addons; [
                    ublock-origin
                    bitwarden
                    darkreader
                    refined-github
                    ipvfoo
                    flagfox
                    return-youtube-dislikes
                    steam-database
                    sponsorblock
                ];
            };
        };

        # https://mozilla.github.io/policy-templates/
        policies = {
            DisableFirefoxStudies = true;
            DisableTelemetry = true;

            DontCheckDefaultBrowser = true;

            FirefoxSuggest = {
                SponsoredSuggestions = false;
                ImproveSuggest = false;
            };

            # Not needed, we have Bitwarden
            OfferToSaveLogins = false;
            PasswordManagerEnabled = false;

            Preferences = {
                "browser.tabs.cardPreview.delayMs" = 250;

                "general.autoScroll" = true;

                "widget.use-xdg-desktop-portal.file-picker" = 1;
                "widget.use-xdg-desktop-portal.location" = 1;
                "widget.use-xdg-desktop-portal.mime-handler" = 1;
                "widget.use-xdg-desktop-portal.open-uri" = 1;
            };
        };
    };
}