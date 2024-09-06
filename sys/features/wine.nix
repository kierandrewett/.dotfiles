{
    pkgs,
    ...
}:
{
    environment.systemPackages = with pkgs; [
        wine

        wineWowPackages.stable
        wineWowPackages.waylandFull

        winetricks

        bottles
    ];
}

