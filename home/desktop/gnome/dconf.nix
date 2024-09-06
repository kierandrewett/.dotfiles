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
                "vesktop.desktop"
                "spotify.desktop"
                "figma.desktop"
                "code.desktop"
                "steam.desktop"
                "thunderbird.desktop"
                "org.gnome.Console.desktop"
                "obs-studio.desktop"
                "org.gnome.Extensions.desktop"
                "easyeffects.desktop"
                "org.gnome.tweaks.desktop"
                "spacecadetpinball.desktop"
                "org.gnome.SystemMonitor.desktop"
                "org.gnome.Settings.desktop"
            ];

            last-selected-power-profile = (lib.optional (type == "laptop") "power-saver");
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

        "org/gtk/gtk4/settings/file-chooser" = {
            show-hidden = true;
        };
    };
}