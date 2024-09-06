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
                    url = ${config.sops.secrets."sync/nc/url"}
                    user = ${config.sops.secrets."sync/nc/username"}
                    pass = ${config.sops.secrets."sync/nc/password"}
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

                rm -rf /tmp/rclone-nc.conf
            ''}";
        };
    };
}