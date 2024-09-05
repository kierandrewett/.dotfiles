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
                    picture-uri = "${pkgs.gnome-backgrounds}/share/backgrounds/gnome/blobs-l.svg";
                    picture-uri-dark = "${pkgs.gnome-backgrounds}/share/backgrounds/gnome/blobs-d.svg";
                };

                "org/gnome/desktop/screensaver" = {
                    picture-uri = "${pkgs.gnome-backgrounds}/share/backgrounds/gnome/blobs-l.svg";
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