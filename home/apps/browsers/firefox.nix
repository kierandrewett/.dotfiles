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

    customizable-ui = {
        placements = {
            unified-extensions-area = [];
            nav-bar = [
                "back-button"
                "forward-button"
                "stop-reload-button"
                "sidebar-button"
                "home-button"
                "customizableui-special-spring"
                "urlbar-container"
                "edit-controls"
                "customizableui-special-spring"
                "downloads-button"
                "fxa-toolbar-menu-button"
                "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action" # Bitwarden
                "ublock0_raymondhill_net-browser-action"
                "unified-extensions-button"
                "profiler-button"
                "developer-button"
            ];
            toolbar-menubar = [
                "menubar-items"
            ];
            TabsToolbar = [
                "customizableui-special-spring"
                "customizableui-special-spring"
                "customizableui-special-spring"
                "tabbrowser-tabs"
                "new-tab-button"
                "alltabs-button"
            ];
            PersonalToolbar = [
                "personal-bookmarks"
            ];
        };

        currentVersion = 29;
        newElementCount = 0;
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
                    "browser.newtabpage.activity-stream.topSitesRows" = 3;
                    "browser.shell.checkDefaultBrowser" = false;
                    "browser.tabs.cardPreview.delayMs" = 250;
                    "browser.toolbars.bookmarks.visibility" = "always";
                    "browser.uiCustomization.state" = builtins.toJSON customizable-ui;

                    "extensions.autoDisableScopes" = 0; # Automatically enable extensions
                    "extensions.update.enabled" = false; # Disable extension updates as this is handled by Nix

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

            FirefoxHome = {
                SponsoredTopSites = false;
                SponsoredPocket = false;
            };

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