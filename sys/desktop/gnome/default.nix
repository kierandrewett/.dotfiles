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
    ]) ++ (with pkgs.gnome; [
        # pkgs.gnome.*
        epiphany # Web
        geary # Email reader
        evince # Document viewer
    ]);

    environment.systemPackages = with pkgs; [
        # Gnome applications
        gnome-extension-manager
        gnome.gnome-tweaks

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
    };
}