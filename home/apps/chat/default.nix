{
    pkgs,
    ...
}:
{
    imports = [
        ./discord.nix
    ];

    home.packages = with pkgs; [
        fractal # GTK4 Matrix app 
    ];
}