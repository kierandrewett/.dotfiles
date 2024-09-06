{
    inputs,
    username,
    hostname,
    platform,
    desktop,
    stateVersion ? null,
    lib,
    config,
    pkgs,
    ...
}:
{
    imports = [
        inputs.sops-nix.nixosModules.sops
        inputs.disko.nixosModules.disko

        ./apps/all.nix
        ./config
        ./machines/${hostname}
        ./desktop/${desktop}
        ./features
        ./users
    ];

    # These packages are absolutely essential
    # and will be required on all machines!
    environment.systemPackages = with pkgs; [
        git
        pciutils
        nix-prefetch
    ];
}