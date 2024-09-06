{
    config,
    username,
    pkgs,
    ...
}:
{
    environment.systemPackages = with pkgs; [
        rclone
    ];

    # Nextcloud Sync
    sops.templates."rclone/nc.conf".content = ''
        [nc]
        type = webdav
        url = ${config.sops.placeholder."sync/nc/url"}
        user = ${config.sops.placeholder."sync/nc/username"}
        pass = ${config.sops.placeholder."sync/nc/password"}
        vendor = nextcloud
    '';


    environment.etc."rclone/nc.conf".source = config.sops.secrets."rclone/nc.conf".path;

    fileSystems."/home/${username}/Sync" = {
        device = "nc:/";
        fsType = "rclone";
        options = [
            "nodev"
            "nofail"
            "allow_other"
            "args2env"
            "config=/etc/rclone/nc.conf"
        ];
    };
}