{
    pkgs,
    system,
    ...
}:
let
    nixpkgsWithOldSpotify = import (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/1b7a6a6e57661d7d4e0775658930059b77ce94a4.tar.gz";
        sha256 = "12k1yz0z6qjl0002lsay2cbwvrwqfy23w611zkh6wyjn97nqqvjc";
    }) {
        inherit system;
    };

    spotify = nixpkgsWithOldSpotify.spotify;
in
{
    home.packages = [spotify];
}