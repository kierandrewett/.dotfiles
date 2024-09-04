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

    sops.secrets."users/${username}/passwd".neededForUsers = true;

    users.defaultUserShell = pkgs.zsh;
    users.users.${username} = {
        extraGroups = [
            "users"
            "wheel"
        ];

        homeMode = "0755";
        isNormalUser = true;

        packages = [ pkgs.home-manager ];

        hashedPasswordFile = config.sops.secrets."users/${username}/passwd".path;
    };
}