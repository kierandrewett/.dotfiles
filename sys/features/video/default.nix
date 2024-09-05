{
    graphics,
    lib,
    ...
}:
{
    imports = []
        ++ lib.optional (builtins.pathExists (./. + "/${graphics}.nix")) ./${graphics}.nix;

    hardware.graphics = {
        enabled = true;
        enable32Bit = true;
    };
}