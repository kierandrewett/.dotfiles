{
    pkgs,
    lib,
    ...
}:
{
    # Main GNOME profile
    programs.dconf.profiles.user.databases = [
        {
            lockAll = true;

            settings = {
                "org/gnome/desktop/input-sources" = {
                    sources = [
                        (lib.gvariant.mkTuple [ "xkb" "gb" ]) # English (UK)
                        (lib.gvariant.mkTuple [ "xkb" "us" ]) # English (US)
                    ];
                };

                "org/gnome/desktop/interface" = {
                    # Middle click paste
                    gtk-enable-primary-paste = false;
                };

                "org/gnome/desktop/wm/preferences" = {
                    button-layout = "icon:minimize,maximize,close";
                };

                "org/gnome/shell/keybindings" = {
                    show-screenshot-ui = "['<Alt>s']";
                };

                "org/gnome/mutter" = {
                    edge-tiling = true;
                    dynamic-workspaces = true;
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