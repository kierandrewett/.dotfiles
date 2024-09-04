{
    lib,
    pkgs,
    username,
    config,
    ...
}:
{
    imports = [
        ./root
    ] ++ lib.optional (builtins.pathExists (./. + "/${username}")) ./${username};

    environment.localBinInPath = true;

    users.users.${username} = {
        extraGroups = [
            "users"
            "wheel"
        ];

        homeMode = "0755";
        isNormalUser = true;

        packages = [ pkgs.home-manager ];

        sops.secrets."users/${username}/passwd".neededForUsers = true;
        hashedPasswordFile = config.sops.secrets."users/${username}/passwd".path;
    };
}