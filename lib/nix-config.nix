{
    inputs,
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
        config = {
            allowUnfree = true;
        };

        overlays = [
            inputs.nur.overlay
        ];
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

    nixpkgs.hostPlatform = lib.mkDefault "${platform}";

    system = {
        inherit stateVersion;
    };
}