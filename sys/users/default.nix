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

        # mkpasswd -m sha-512
        hashedPassword = "$6$h0qd3j1d1ENjklBD$De5UJ9CfcTVdEnpXP5QbmZQjS8qE4.ZyxKZKnl8SLUHV/44bV5WfEi8kG/Yry9IS5QwJGauKPBG3TQGomxKw/1";
    };
}