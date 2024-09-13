{
    inputs,
    platform,
    pkgs,
    desktop,
    ...
}:
let
    package = inputs.firefox-nightly.packages.${platform}.firefox-nightly-bin;

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