{
    username,
    outputs,
    platform,
    pkgs,
    ...
}:
{
    nixpkgs = {
        overlays = [];
        hostPlatform = platform;
        config = {
            allowUnfree = true;
        };
    };

    nix = {
        package = pkgs.nix;
        settings = {
            experimental-features = ["nix-command" "flakes"];
            auto-optimise-store = true;
            trusted-users = [ "root" "${username}" ];
            warn-dirty = false;
        };
    };
}