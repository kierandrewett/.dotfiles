_:
let
    pkgs = import (builtins.fetchGit {
        name = "nixpkgs-spotify-1.1.84.716.gc5f8b819";
        url = "https://github.com/NixOS/nixpkgs/";
        ref = "refs/heads/nixpkgs-unstable";
        rev = "1b7a6a6e57661d7d4e0775658930059b77ce94a4";
    }) {};

    spotifyPkg = pkgs.spotify;
in
{
    home.packages = [spotifyPkg];
}