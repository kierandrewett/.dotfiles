{
    pkgs,
    ...
}:
let
    segoe-ui = import ./segoe-ui.nix;
in 
{
    environment.systemPackages = with pkgs; [
        geist-font

        # Microsoft fonts
        corefonts
        vistafonts
        segoe-ui
    ];
}