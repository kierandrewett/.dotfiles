{
    pkgs,
    ...
}:
{
    # Main GNOME profile
    programs.dconf.profiles.user.databases = [
        {
            lockAll = true;

            settings = {
                "org/gnome/desktop/background" = {
                    picture-options = "zoom";
                    picture-uri = "${pkgs.gnome-backgrounds}/share/backgrounds/gnome/adwaita-l.jxl";
                    picture-uri-dark = "${pkgs.gnome-backgrounds}/share/backgrounds/gnome/adwaita-d.jxl";
                };

                "org/gnome/desktop/screensaver" = {
                    picture-options = "zoom";
                    picture-uri = "${pkgs.gnome-backgrounds}/share/backgrounds/gnome/adwaita-l.jxl";
                };
            };
        }
    ];

    # GDM profile (lock screen)
    programs.dconf.profiles.gdm.databases = [
        {
            lockAll = true;

            settings = {};
        }
    ];
}