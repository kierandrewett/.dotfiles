{
    pkgs,
    ...
}:
{
    home.packages = with pkgs; [
        thunderbird
        onlyoffice-bin
    ];
}