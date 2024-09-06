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
    environment.etc."rclone/nc.conf".text = ''
        [nc]
        type = webdav
        url = ${config.sops.secrets."sync/nc/url"}
        user = ${config.sops.secrets."sync/nc/username"}
        pass = ${config.sops.secrets."sync/nc/password"}
        vendor = nextcloud
    '';

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