{
    lib,
    username,
    ...
}:
{
    imports = let
        userPath = ./. + "/${username}";
    in lib.optional (builtins.pathExists userPath) [userPath];
}