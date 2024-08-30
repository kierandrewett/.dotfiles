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
        shell = pkgs.zsh;

        hashedPasswordFile = if builtins.pathExists config.sops.secrets."users/${username}/passwd".path
                    then config.sops.secrets."users/${username}/passwd".path
                    else null;
    };
}