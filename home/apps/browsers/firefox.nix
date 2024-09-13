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
    package = inputs.firefox-nightly.packages.${platform}.firefox-nightly-bin;
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
                    "browser.newtabpage.activity-stream.showSponsored" = false;
                    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

                    "browser.uiCustomization.state" = builtins.toJSON customizable-ui;

                    "browser.shell.checkDefaultBrowser" = false;
                    "browser.tabs.cardPreview.delayMs" = 250;
                    "browser.toolbars.bookmarks.visibility" = "always";

                    "devtools.chrome.enabled" = true;
                    "devtools.debugger.remote-enabled" = true;
                    "devtools.toolbox.host" = "right";

                    "extensions.autoDisableScopes" = 0; # Automatically enable extensions
                    "extensions.update.enabled" = false; # Disable extension updates as this is handled by Nix

                    # Disable telemetry
                    "app.shield.optoutstudies.enabled" = false;
                    "browser.discovery.enabled" = false;
                    "browser.newtabpage.activity-stream.feeds.telemetry" = false;
                    "browser.newtabpage.activity-stream.telemetry" = false;
                    "browser.ping-centre.telemetry" = false;
                    "datareporting.healthreport.service.enabled" = false;
                    "datareporting.healthreport.uploadEnabled" = false;
                    "datareporting.policy.dataSubmissionEnabled" = false;
                    "datareporting.sessions.current.clean" = true;
                    "devtools.onboarding.telemetry.logged" = false;
                    "toolkit.telemetry.archive.enabled" = false;
                    "toolkit.telemetry.bhrPing.enabled" = false;
                    "toolkit.telemetry.enabled" = false;
                    "toolkit.telemetry.firstShutdownPing.enabled" = false;
                    "toolkit.telemetry.hybridContent.enabled" = false;
                    "toolkit.telemetry.newProfilePing.enabled" = false;
                    "toolkit.telemetry.prompted" = 2;
                    "toolkit.telemetry.rejected" = true;
                    "toolkit.telemetry.reportingpolicy.firstRun" = false;
                    "toolkit.telemetry.server" = "";
                    "toolkit.telemetry.shutdownPingSender.enabled" = false;
                    "toolkit.telemetry.unified" = false;
                    "toolkit.telemetry.unifiedIsOptIn" = false;
                    "toolkit.telemetry.updatePing.enabled" = false;

                    "privacy.trackingprotection.enabled" = true;
                    "dom.security.https_only_mode" = true;

                    "general.autoScroll" = true;

                    "media.eme.enabled" = true; # DRM

                    # Enable sync for all "places" related data
                    "services.sync.engine.addresses" = true;
                    "services.sync.engine.bookmarks" = true;
                    "services.sync.engine.creditcards" = true;
                    "services.sync.engine.history" = true;
                    "services.sync.engine.passwords" = true;
                    "services.sync.engine.tabs" = true;

                    # Disable sync for addons and prefs
                    # This is handled by Nix and we don't need to sync these
                    "services.sync.engine.addons" = false;
                    "services.sync.engine.prefs" = false;
                    "services.sync.engine.prefs.modified" = false;

                    "signon.rememberSignons" = false;

                    "widget.use-xdg-desktop-portal.file-picker" = 1;
                    "widget.use-xdg-desktop-portal.location" = 1;
                    "widget.use-xdg-desktop-portal.mime-handler" = 1;
                    "widget.use-xdg-desktop-portal.open-uri" = 1;
                };
            };
        };
    };
}