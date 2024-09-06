{
    username,
    outputs,
    platform,
    pkgs,
    lib,
    stateVersion,
    ...
}:
{
    nix = {
        settings = {
            experimental-features = "nix-command flakes";
            flake-registry = "";
            auto-optimise-store = true;
            trusted-users = [ "root" "${username}" ];
            warn-dirty = false;
        };
    };

    nixpkgs.config.allowUnfree = true;

    system = {
        inherit stateVersion;
    };
}