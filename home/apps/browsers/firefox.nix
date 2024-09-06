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
            };
        };
    };
}