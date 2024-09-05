{
    pkgs,
    lib,
    ...
}:
{
    dconf.settings = with lib.hm.gvariant; {
        "org/gnome/shell" = {
            favorite-apps = [
                "org.gnome.Nautilus.desktop"
                "firefox-nightly.desktop"
                "discord-canary.desktop"
                "Spotify.desktop"
                "figma.desktop"
                "code.desktop"
                "com.valvesoftware.Steam.desktop"
                "thunderbird.desktop"
                "org.gnome.Software.desktop"
                "org.gnome.Console.desktop"
                "obs-studio.desktop"
                "org.gnome.Extensions.desktop"
                "easyeffects.desktop"
                "org.gnome.tweaks.desktop"
                "com.github.k4zmu2a.spacecadetpinball.desktop"
                "org.gnome.SystemMonitor.desktop"
                "org.gnome.Settings.desktop"
            ];
        };

        "org/gnome/desktop/background" = {
            picture-options = "zoom";
            picture-uri = "${pkgs.gnome-backgrounds}/share/backgrounds/gnome/adwaita-l.jxl";
            picture-uri-dark = "${pkgs.gnome-backgrounds}/share/backgrounds/gnome/adwaita-d.jxl";
        };

        "org/gnome/desktop/screensaver" = {
            picture-options = "zoom";
            picture-uri = "${pkgs.gnome-backgrounds}/share/backgrounds/gnome/adwaita-d.jxl";
        };
    };
}