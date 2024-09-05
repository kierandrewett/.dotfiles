{
    graphics,
    lib,
    ...
}:
{
    imports = []
        ++ lib.optional (builtins.pathExists (./. + "/${graphics}.nix")) ./${graphics}.nix;

    hardware.graphics = {
        enable = true;
        enable32Bit = true;
    };
}