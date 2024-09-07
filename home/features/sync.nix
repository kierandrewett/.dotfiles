{
    pkgs,
    config,
    ...
}:
let
    mountDir = "${config.home.homeDirectory}/Sync";
in
{
    home.packages = with pkgs; [
        rclone
    ];

    systemd.user.services.rclone-mount = {
        Unit = {
            Description = "Mounts the remote rclone synchronised drive.";
            After = [ "network-online.target" ];
        };
        Install.WantedBy = [ "multi-user.target" ];
        Service = {
            ExecStartPre = "${pkgs.writeShellScript "rclone-prepare" ''
                ${pkgs.coreutils}/bin/mkdir -p ${mountDir}
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

                rclone --config /tmp/rclone-nc.conf \
                    mount nc: ${mountDir} \
                    --fast-list \
                    --dir-cache-time 168h \
                    --vfs-cache-mode full \
                    --vfs-cache-max-age 168h \
                    --vfs-read-chunk-size 64M \
                    --vfs-read-chunk-size-limit 2048M \
                    --max-read-ahead 256M \
                    --poll-interval 1m \
                    --no-modtime \
                    --buffer-size 512M \
                    --timeout 10m \
                    --transfers 16 \
                    --checkers 12 \
                    --fuse-flag=sync_read \
                    --fuse-flag=auto_cache \
                    -v
            ''}";
            ExecStop = "${pkgs.writeShellScript "rclone-umount" ''
                /run/wrappers/bin/fusermount -zu ${mountDir}
            ''}";
            Type = "notify";
            Restart = "on-failure";
            RestartSec = "2s";
            Environment = [
                "PATH=/run/wrappers/bin/:$PATH"
            ];
        };
    };
}