{
    pkgs,
    config,
    ...
}:
let
    mountDir = "${config.home.homeDirectory}/Sync";
in
{
    systemd.user.services.rclone-mount = {
        Unit = {
            Description = "Mounts the remote rclone synchronised drive.";
            After = [ "network-online.target" ];
        };
        Install.WantedBy = [ "multi-user.target" ];
        Service = {
            ExecStartPre = "${pkgs.writeShellScript "rclone-prepare" ''
                mkdir -p ${mountDir}
            ''}";
            ExecStart = "${pkgs.writeShellScript "rclone-mount-drv" ''
                cat > /tmp/rclone-nc.conf << EOF
                [nc]
                type = webdav
                url = $(cat ${config.sops.secrets."sync/nc/url".path})
                user = $(cat ${config.sops.secrets."sync/nc/username".path})
                pass = $(cat ${config.sops.secrets."sync/nc/password".path})
                vendor = nextcloud
                EOF

                RCLONE_CONFIG=/tmp/rclone-nc.conf

                rclone mount nc: ${mountDir} \
                    --dir-cache-time 48h \
                    --vfs-cache-mode full \
                    --vfs-cache-max-age 48h \
                    --vfs-read-chunk-size 10M \
                    --vfs-read-chunk-size-limit 512M \
                    --no-modtime \
                    --buffer-size 512M
            ''}";
            ExecStop = "${pkgs.writeShellScript "rclone-umount" ''
                fusermount -u ${mountDir}
            ''}";
            Type = "notify";
            Restart = "always";
            RestartSec = "30s";
        };
    };
}