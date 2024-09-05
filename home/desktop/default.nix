{
    lib,
    desktop,
    ...
}:
{
    imports = lib.optional (builtins.pathExists (./. + "/${desktop}")) ./${desktop};
}