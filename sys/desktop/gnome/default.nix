{
    pkgs,
    ...
}:
{
    # Exclude certain packages
    environment.gnome.excludePackages = (with pkgs; [
        # pkgs.*
        gnome-tour
        gnome-connections
        epiphany # Web
        geary # Email reader
        evince # Document viewer
    ]);

    environment.systemPackages = with pkgs; [
        # Gnome applications
        gnome-extension-manager
        gnome-tweaks
        gnome-backgrounds

        # Gnome extensions
        (gnomeExtensions.dash-to-dock)
    ];

    services.xserver = {
        enable = true;

        displayManager = {
            gdm.enable = true;
        };

        desktopManager = {
            gnome.enable = true;
        };

        excludePackages = with pkgs; [
            xterm
        ];
    };

    dconf.settings."org/gnome/desktop/background" = {
        picture-uri = "${pkgs.gnome-backgrounds}/share/backgrounds/gnome/blobs-l.svg";
        picture-uri-dark = "${pkgs.gnome-backgrounds}/share/backgrounds/gnome/blobs-d.svg";
    };

    dconf.settings."org/gnome/desktop/screensaver" = {
        picture-uri = "${pkgs.gnome-backgrounds}/share/backgrounds/gnome/blobs-l.svg";
    };
}