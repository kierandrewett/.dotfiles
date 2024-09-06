{
    pkgs,
    config,
    ...
}:
{
    home.file.".config/rclone/nc.conf".text = ''
        [nc]
        type = webdav
        url = ${config.sops.secrets."sync/nc/url"}
        user = ${config.sops.secrets."sync/nc/username"}
        pass = ${config.sops.secrets."sync/nc/password"}
        vendor = nextcloud
    '';

    systemd.user.services.rclone-sync = {
        Unit = {
            Description = "Performs a bidirectional sync of data between the client and remote.";
        };
        Install = {
            WantedBy = [ "default.target" ];
        };
        Service = {
            ExecStart = "${pkgs.writeShellScript "rclone-sync" ''
                #!/run/current-system/sw/bin/bash
                rsync --config ${config.home.file.".config/rclone/nc.conf".path} \
                    bisync \
                    nc:/ \
                    ~/Documents/ \
                    --create-empty-src-dirs \
                    --compare size,modtime,checksum \
                    --slow-hash-sync-only \
                    --resilient \
                    --fix-case \
                    -MvP
            ''}";
        };
    };
}