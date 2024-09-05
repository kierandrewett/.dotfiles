{
    graphics,
    lib,
    ...
}:
{
    imports = []
        ++ lib.optional (builtins.pathExists (./. + "/${graphics}.nix")) ./${graphics}.nix;

    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
    };
}