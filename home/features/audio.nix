{
    pkgs,
    ...
}:
{
    environment.systemPackages = with pkgs; [
        pkgs.easyeffects
    ];

    services.easyeffects = {
        enable = true;
        preset = "Default";
    };
}