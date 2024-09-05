{
    graphics,
    lib,
    username,
    ...
}:
{
    imports = []
        ++ lib.optional (builtins.pathExists (./. + "/${graphics}.nix")) ./${graphics}.nix;

    hardware.graphics = {
        enable = lib.mkForce true;
        enable32Bit = lib.mkForce true;
    };

    users.users.${username}.extraGroups = [
        "video"
    ];
}