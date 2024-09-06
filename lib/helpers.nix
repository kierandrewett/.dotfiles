{
    inputs,
    outputs,
    stateVersion,
    ...
}:
{
    mkSystem =
        {
            type,
            hostname,
            desktop,
            username,
            platform ? "x86_64-linux",
            graphics,
        }:
        inputs.nixpkgs.lib.nixosSystem {
            system = platform;

            specialArgs = {
                inherit inputs outputs type username hostname platform desktop graphics stateVersion;
            };

            modules = [
                ../lib/nix-config.nix

                inputs.home-manager.nixosModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.backupFileExtension = "hmbak";
                    home-manager.users.${username}.imports = [../home];
                    home-manager.extraSpecialArgs = {
                        inherit inputs outputs type username hostname platform desktop graphics stateVersion;
                    };
                }

                ../sys
            ];
        };

    forAllSystems = inputs.nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
    ];
}