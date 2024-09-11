{
    inputs,
    platform,
    lib,
    ...
}:
{
    inputs.nixpkgs-spotify.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "spotify"
    ];

    home.packages = [inputs.nixpkgs-spotify.legacyPackages.${platform}.spotify];
}