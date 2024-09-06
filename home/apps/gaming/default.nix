{
    pkgs,
    ...
}:
{
    home.packages = with pkgs; [
        steam
        space-cadet-pinball
    ];
}