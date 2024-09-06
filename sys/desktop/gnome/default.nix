{
    pkgs,
    ...
}:
{
    imports = [
        ./dconf.nix
    ];

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

    services.gnome.gnome-browser-connector.enable = true;

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
}