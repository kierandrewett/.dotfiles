{
    description = "Kieran's Nix configuration";

    inputs = {
        # Nixpkgs
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        # Home manager
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        # NixOS hardware support
        nixos-hardware.url = "github:NixOS/nixos-hardware";

        # SOPS secrets
        sops-nix.url = "github:Mic92/sops-nix";
    };

    outputs =
        {
            self,
            nixpkgs,
            ...
        }@inputs:
        let
            inherit (self) outputs;

            # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
            stateVersion = "24.05";

            helpers = import ./lib/helpers.nix { inherit inputs outputs stateVersion; };
        in
        {
            homeConfigurations = {
                # Main PC
                "kieran@fsociety" = helpers.mkHome {
                    hostname = "fsociety";
                    username = "kieran";
                };
                # Lenovo IdeaPad Slim 5
                "kieran@ssociety" = helpers.mkHome {
                    hostname = "ssociety";
                    username = "kieran";
                };
            };

            nixosConfigurations = {
                # Main PC
                fsociety = helpers.mkSystem {
                    hostname = "fsociety";
                    username = "kieran";
                    desktop = "gnome";
                };
                # Lenovo IdeaPad Slim 5
                ssociety = helpers.mkSystem {
                    hostname = "ssociety";
                    username = "kieran";
                    desktop = "gnome";
                };
            };

            packages = helpers.forAllSystems (system: nixpkgs.legacyPackages.${system});
        };
}
