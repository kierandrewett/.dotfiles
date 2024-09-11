{
    inputs,
    platform,
    ...
}:
{
    home.packages = [inputs.nixpkgs-spotify.legacyPackages.${platform}.spotify];
}