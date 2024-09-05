# Main PC

{ inputs, ... }:
{
    imports = [
        # Hardware
        inputs.nixos-hardware.nixosModules.common-cpu-amd
        inputs.nixos-hardware.nixosModules.common-gpu-amd
        inputs.nixos-hardware.nixosModules.common-pc
        inputs.nixos-hardware.nixosModules.common-pc-ssd

        ./disks.nix
    ];
}