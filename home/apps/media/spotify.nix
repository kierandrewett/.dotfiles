{
    inputs,
    platform,
    lib,
    ...
}:
let
    pkgSpotify = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/7d0ed7f2e5aea07ab22ccb338d27fbe347ed2f11.tar.gz") {
        config =  { allowUnfree = true; };
    };
in
{
    home.packages = [pkgSpotify.spotify];
}