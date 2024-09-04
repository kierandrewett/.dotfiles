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
        gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
        };
    };

    nixpkgs.config.allowUnfree = true;

    nixpkgs.hostPlatform = lib.mkDefault "${platform}";

    system = {
        inherit stateVersion;
    };
}