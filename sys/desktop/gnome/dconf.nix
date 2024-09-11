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

                    clock-show-weekday = true;
                };

                "org/gnome/desktop/a11y" = {
                    always-show-universal-access-status = true;
                };

                "org/gnome/desktop/wm/preferences" = {
                    button-layout = "icon:minimize,maximize,close";
                };

                "org/gnome/shell/keybindings" = {
                    show-screenshot-ui = [ "<Alt>s" "Print" ];
                };

                "org/gnome/mutter" = {
                    edge-tiling = true;
                    dynamic-workspaces = true;
                };

                "org/gnome/system/location" = {
                    enabled = true;
                };

                "org/gnome/desktop/interface" = {
                    # Sets the legacy GTK3 theme to modern libawaita
                    gtk-theme = "adw-gtk3";

                    monospace-font-name = "Geist Mono 10";
                    show-battery-percentage = true;
                };

                "org/gnome/desktop/peripherals/mouse" = {
                    speed = -0.9;
                };

                "org/gnome/desktop/peripherals/touchpad" = {
                    speed = -0.15;
                    tap-to-click = true;
                    natural-scroll = true;
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