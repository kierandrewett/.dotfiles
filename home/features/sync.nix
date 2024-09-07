{
    pkgs,
    config,
    lib,
    ...
}:
let
    rclone-fs = name: localMount: remoteMount: {
        Unit = {
            Description = "Mounts the remote ${name} FUSE filesystem.";
            After = [ "network-online.target" ];
            Wants = [ "network-online.target" ];
        };

        Service = {
            ExecStartPre = ''
                ${pkgs.coreutils}/bin/cat > /tmp/rclone-${name}.conf << EOF
                [${name}]
                type = $(${pkgs.coreutils}/bin/cat ${config.sops.secrets."sync/${name}/type".path})
                url = $(${pkgs.coreutils}/bin/cat ${config.sops.secrets."sync/${name}/url".path})
                user = $(${pkgs.coreutils}/bin/cat ${config.sops.secrets."sync/${name}/username".path})
                pass = $(${pkgs.coreutils}/bin/cat ${config.sops.secrets."sync/${name}/password".path})
                vendor = $(${pkgs.coreutils}/bin/cat ${config.sops.secrets."sync/${name}/vendor".path})
                EOF
            '';

            ExecStart = ''
                ${pkgs.rclone}/bin/rclone mount \
                    --config /tmp/rclone-nc.conf \
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
                    ${name}:${remoteMount} ${localMount}
            '';

            Environment = [
                "PATH=/run/wrappers/bin/:$PATH"
            ];
        };
    };
in
{
    home.packages = with pkgs; [
        rclone
    ];

    systemd.user.services.rclone-nc = rclone-fs "nc" "/" "%h/Sync";
    systemd.user.services.rclone-nc-documents = rclone-fs "nc" "/Documents" "%h/Documents";
}