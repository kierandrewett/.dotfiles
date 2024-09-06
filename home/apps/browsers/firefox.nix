{
    inputs,
    lib,
    desktop,
    platform,
    pkgs,
    username,
    ...
}:
let
    package = inputs.firefox-nightly.packages.${platform}.firefox-nightly-bin.override {
        nativeMessagingHosts = with pkgs; [
            (lib.optional (desktop == "gnome") gnome-browser-connector)
        ];
    };
in
{
    programs.firefox = {
        enable = true;

        inherit package;

        profiles = {
            ${username} = {
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

                settings = {
                    "browser.tabs.cardPreview.delayMs" = 250;

                    # Automatically enable extensions
                    "extensions.autoDisableScopes" = 0;

                    "general.autoScroll" = true;

                    "widget.use-xdg-desktop-portal.file-picker" = 1;
                    "widget.use-xdg-desktop-portal.location" = 1;
                    "widget.use-xdg-desktop-portal.mime-handler" = 1;
                    "widget.use-xdg-desktop-portal.open-uri" = 1;
                };
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
        };
    };
}