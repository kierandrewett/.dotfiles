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
                cat > /tmp/rclone-nc.conf << EOF
                [nc]
                type = webdav
                url = $(cat ${config.sops.secrets."sync/nc/url".path})
                user = $(cat ${config.sops.secrets."sync/nc/username".path})
                pass = $(cat ${config.sops.secrets."sync/nc/password".path})
                vendor = nextcloud
                EOF

                rclone \
                    --config /tmp/rclone-nc.conf \
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