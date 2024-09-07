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
                ${pkgs.coreutils}/bin/cat > /tmp/rclone-nc.conf << EOF
                [nc]
                type = webdav
                url = $(${pkgs.coreutils}/bin/cat ${config.sops.secrets."sync/nc/url".path})
                user = $(${pkgs.coreutils}/bin/cat ${config.sops.secrets."sync/nc/username".path})
                pass = $(${pkgs.coreutils}/bin/cat ${config.sops.secrets."sync/nc/password".path})
                vendor = nextcloud
                EOF

                ${pkgs.rclone}/bin/rclone --config /tmp/rclone-nc.conf \
                    mount nc: ${mountDir} \
                    --dir-cache-time 168h \
                    --vfs-cache-mode full \
                    --vfs-cache-max-age 168h \
                    --vfs-read-chunk-size 64M \
                    --vfs-read-chunk-size-limit 2048M \
                    --max-read-ahead 256M \
                    --buffer-size 512M \
                    --timeout 10m \
                    --transfers 16 \
                    --checkers 12 \
                    -v
            ''}";
            ExecStop = "${pkgs.writeShellScript "rclone-umount" ''
                /run/wrappers/bin/fusermount -zu ${mountDir}
            ''}";
            Type = "simple";
            Restart = "on-failure";
            RestartSec = "10s";
            Environment = [
                "PATH=/run/wrappers/bin/:$PATH"
            ];
        };
    };
}