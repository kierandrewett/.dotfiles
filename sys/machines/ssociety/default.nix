# Lenovo IdeaPad Slim 5

{ inputs, ... }:
{
    imports = [
        # Hardware
        inputs.nixos-hardware.nixosModules.lenovo-ideapad-slim-5
        ./disk-configuration.nix

        # Apps
        ../../apps/all.nix
    ];
}