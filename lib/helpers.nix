{
    inputs,
    outputs,
    stateVersion,
    ...
}:
{
    mkHome =
        {
            username,
            platform ? "x86_64-linux",
        }:
        inputs.home-manager.lib.homeManagerConfiguration {
            pkgs = inputs.nixpkgs.legacyPackages.${platform};

            extraSpecialArgs = {
                inherit inputs outputs username platform stateVersion;
            };

            modules = [
                ../home
            ];
        };

    mkSystem =
        {
            hostname,
            desktop,
            platform ? "x86_64-linux",
        }:
        inputs.nixpkgs.lib.nixosSystem {
            pkgs = inputs.nixpkgs.legacyPackages.${platform};

            specialArgs = {
                inherit inputs outputs hostname platform desktop stateVersion;
            };

            modules = [
                ../sys
            ];
        };

    forAllSystems = inputs.nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
    ];
}