{
    username,
    outputs,
    platform,
    pkgs,
    lib,
    ...
}:
{
    nixpkgs = {
        overlays = [];
    };

    nix = {
        settings = {
            experimental-features = "nix-command flakes";
            flake-registry = "";
            auto-optimise-store = true;
            trusted-users = [ "root" "${username}" ];
            warn-dirty = false;
        };
    };

    nixpkgs.hostPlatform = lib.mkDefault "${platform}";
}