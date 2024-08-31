# Test VM

{ inputs, ... }:
{
    imports = [
        # Hardware
        inputs.nixos-hardware.nixosModules.common-pc
        ./disks.nix

        # Apps
        ../../apps/all.nix
    ];
}