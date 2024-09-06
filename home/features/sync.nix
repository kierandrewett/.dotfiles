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
                #!/run/current-system/sw/bin/bash
                RSYNC_URL=(cat ${config.sops.secrets."sync/nc/url".path}})
                RSYNC_USER=(cat ${config.sops.secrets."sync/nc/username".path}})
                RSYNC_PASS=(cat ${config.sops.secrets."sync/nc/password".path}})

                rsync \
                    --webdav-url $RSYNC_URL
                    --webdav-user $RSYNC_USER
                    --webdav-pass $RSYNC_PASS
                    --webdav-vendor nextcloud
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