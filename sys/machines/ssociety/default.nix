# Lenovo IdeaPad Slim 5

{ inputs, ... }:
{
    imports = [
        # Hardware
        inputs.nixos-hardware.nixosModules.lenovo-ideapad-slim-5

        ./disks.nix
    ];

    boot.initrd.kernelModules = [
        "mt7921e" # Wi-Fi
    ];
}