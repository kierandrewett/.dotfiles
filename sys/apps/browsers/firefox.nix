{
    inputs,
    platform,
    pkgs,
    ...
}:
let
    package = inputs.firefox-nightly.packages.${platform}.firefox-nightly-bin.override {
        nativeMessagingHosts = with pkgs; [
            (lib.optional (desktop == "gnome") gnome-browser-connector)
        ];
    };

    customizable-ui = builtins.toJSON {
        placements = {
            unified-extensions-area = [];
            nav-bar = [
                "back-button"
                "forward-button"
                "stop-reload-button"
                "sidebar-button"
                "home-button"
                "customizableui-special-spring1"
                "urlbar-container"
                "edit-controls"
                "customizableui-special-spring2"
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
                "customizableui-special-spring3"
                "customizableui-special-spring4"
                "customizableui-special-spring5"
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

        preferencesStatus = "locked";

        preferences = {
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

        policies = {
            UserMessaging = {
				Locked = true;
				ExtensionRecommendations = false;
				FeatureRecommendations = false;
				MoreFromMozilla = false;
				SkipOnboarding = true;
				UrlbarInterventions = false;
				WhatsNew = false;
			};

            PasswordManagerEnabled = false;
            OfferToSaveLogins = false;

            ExtensionSettings = {
                "*".installation_mode = "blocked";
            };
        };
    };
}