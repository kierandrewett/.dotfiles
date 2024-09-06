{
    pkgs,
    ...
}:
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
}