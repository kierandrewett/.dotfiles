{
    pkgs,
    ...
}:
{
    # Main GNOME profile
    programs.dconf.profiles.user.databases = [
        {
            lockAll = true;

            settings = {};
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