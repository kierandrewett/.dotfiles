{
    pkgs,
    config,
    ...
}:
{
    systemd.user.services.rclone-sync = {
        Unit = {
            Description = "Performs a bidirectional sync of data between the client and remote.";
        };
        Install = {
            WantedBy = [ "default.target" ];
        };
        Service = {
            ExecStart = "${pkgs.writeShellScript "rclone-sync" ''
                RCLONE_URL=$(cat ${config.sops.secrets."sync/nc/url".path})
                RCLONE_USER=$(cat ${config.sops.secrets."sync/nc/username".path})
                RCLONE_PASS=$(cat ${config.sops.secrets."sync/nc/password".path})

                rclone \
                    --webdav-url $RCLONE_URL \
                    --webdav-user $RCLONE_USER \
                    --webdav-pass $RCLONE_PASS \
                    --webdav-vendor nextcloud \
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