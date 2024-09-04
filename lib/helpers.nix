{
    inputs,
    outputs,
    stateVersion,
    ...
}:
{
    mkSystem =
        {
            hostname,
            desktop,
            username,
            platform ? "x86_64-linux",
        }:
        inputs.nixpkgs.lib.nixosSystem {
            specialArgs = {
                inherit inputs outputs username hostname platform desktop stateVersion;
            };

            modules = [
                ../lib/nix-config.nix

                inputs.home-manager.nixosModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                }

                ../sys
                ../home
            ];
        };

    forAllSystems = inputs.nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
    ];
}