{
    inputs,
    platform,
    ...
}:
{
    home.packages = [inputs.nixpkgs-spotify.packages.${platform}.spotify];
}