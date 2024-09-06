{
    pkgs,
    ...
}:
let
    discordIcon = pkgs.fetchurl {
        url = "https://dashboard.snapcraft.io/site_media/appmedia/2021/05/discord.png";
        hash = "sha256-jgVu/SQYnScTvJFWTkqQzP9/BW1l6la1CtLdYhEoZbk=";
    };
in
{
    home.packages = with pkgs; [
        (vesktop.overrideAttrs (oldAttrs: {
            desktopItems = [
                (makeDesktopItem {
                    name = "vesktop";
                    desktopName = "Discord";
                    exec = "vesktop %U";
                    icon = "discord";
                    startupWMClass = "Vesktop";
                    genericName = "Internet Messenger";
                    keywords = [ "discord" "vencord" "electron" "chat" ];
                    categories = [ "Network" "InstantMessaging" "Chat" ];
                })
            ];
        }))
    ];

    xdg.dataFile."icons/discord.png".source = discordIcon;
}