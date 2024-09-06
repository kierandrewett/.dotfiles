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

        # Disko
        disko.url = "github:nix-community/disko";
        disko.inputs.nixpkgs.follows = "nixpkgs";

        # Firefox Nightly
        firefox-nightly.url = "github:nix-community/flake-firefox-nightly";
        firefox-nightly.inputs.nixpkgs.follows = "nixpkgs";

        # Firefox addons
        firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
        firefox-addons.inputs.nixpkgs.follows = "nixpkgs";
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
            nixosConfigurations = {
                # Main PC
                fsociety = helpers.mkSystem {
                    hostname = "fsociety";
                    username = "kieran";
                    desktop = "gnome";
                    graphics = "amd";
                };
                # Lenovo IdeaPad Slim 5
                ssociety = helpers.mkSystem {
                    hostname = "ssociety";
                    username = "kieran";
                    desktop = "gnome";
                    graphics = "amd";
                };
                # Test VM
                testvm = helpers.mkSystem {
                    hostname = "testvm";
                    username = "kieran";
                    desktop = "gnome";
                };
            };

            packages = helpers.forAllSystems (system: nixpkgs.legacyPackages.${system});
        };
}
