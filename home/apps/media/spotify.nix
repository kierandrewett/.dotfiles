{
    inputs,
    platform,
    lib,
    ...
}:
let
    pkgSpotify = import (fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/7d0ed7f2e5aea07ab22ccb338d27fbe347ed2f11.tar.gz";
        sha256 = "0v27szwci00zi1gpznqs1lhalvhfhh19gxd8yb8brxi2mb1kc0bb";
    }) {
        system = platform;
        
        config = { allowUnfree = true; };
    };
in
{
    home.packages = [pkgSpotify.spotify];
}