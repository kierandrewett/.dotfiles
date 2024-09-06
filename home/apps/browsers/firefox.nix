{
    inputs,
    platform,
    pkgs,
    ...
}:
let
    package = inputs.firefox-nightly.packages.${platform}.firefox-nightly-bin;
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

                extensions = with pkgs.nur.repos.rycee.firefox-addons; [
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