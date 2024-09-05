{
    pkgs,
    ...
}:
{
    # Main GNOME profile
    programs.dconf.profiles.user.databases = [
        {
            settings = {
                "org/gnome/desktop/background" = {
                    picture-uri = "${pkgs.gnome-backgrounds}/share/backgrounds/gnome/adwaita-l.jxl";
                    picture-uri-dark = "${pkgs.gnome-backgrounds}/share/backgrounds/gnome/adwaita-d.jxl";
                };

                "org/gnome/desktop/screensaver" = {
                    picture-uri = "${pkgs.gnome-backgrounds}/share/backgrounds/gnome/adwaita-l.jxl";
                };
            };
        }
    ];

    # GDM profile (lock screen)
    programs.dconf.profiles.gdm.databases = [
        {
            settings = {};
        }
    ];
}