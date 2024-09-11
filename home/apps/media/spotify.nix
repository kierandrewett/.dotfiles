{
    pkgs,
    ...
}:
let
    nixpkgsWithOldSpotify = import (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/1b7a6a6e57661d7d4e0775658930059b77ce94a4.tar.gz";
    }) {};

    spotify = nixpkgsWithOldSpotify.spotify;
in
{
    home.packages = [spotify];
}