{
    inputs,
    ...
}:
{
    home.packages = [inputs.nixpkgs-spotify.spotify];
}