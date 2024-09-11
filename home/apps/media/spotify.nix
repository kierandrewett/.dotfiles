{
    inputs,
    platform,
    ...
}:
{
    inputs.nixpkgs-spotify.config.allowUnfree = true;

    home.packages = [inputs.nixpkgs-spotify.legacyPackages.${platform}.spotify];
}