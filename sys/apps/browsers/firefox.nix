{
    inputs,
    platform,
    pkgs,
    desktop,
    ...
}:
let
    package = inputs.firefox-nightly.packages.${platform}.firefox-nightly-bin;
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