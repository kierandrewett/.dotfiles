{
    pkgs,
    config,
    lib,
    ...
}:
let
    homeDir = config.home.homeDirectory;

    rclone-fs = name: remote: local: {
        Unit = {
            Description = "Mounts the remote ${name} FUSE filesystem.";
            Requires = [ "network-online.target" "xdg-desktop-autostart.target" ];
        };

        Install = {
            WantedBy = [ "multi-user.target" ];
        };

        Service = {
            ExecStartPre = "${pkgs.writeShellScript "rclone-mount-${name}-pre" ''
                ${pkgs.coreutils}/bin/cat > /tmp/rclone-${name}.conf << EOF
                [${name}]
                type = $(${pkgs.coreutils}/bin/cat ${config.sops.secrets."sync/${name}/type".path})
                url = $(${pkgs.coreutils}/bin/cat ${config.sops.secrets."sync/${name}/url".path})
                user = $(${pkgs.coreutils}/bin/cat ${config.sops.secrets."sync/${name}/username".path})
                pass = $(${pkgs.coreutils}/bin/cat ${config.sops.secrets."sync/${name}/password".path})
                vendor = $(${pkgs.coreutils}/bin/cat ${config.sops.secrets."sync/${name}/vendor".path})
                EOF
            ''}";

            ExecStart = "${pkgs.writeShellScript "rclone-mount-${name}-start" ''
                if [ ! -d "${local}" ]; then
                    ${pkgs.coreutils}/bin/mkdir -p ${local}
                fi

                ${pkgs.rclone}/bin/rclone mount \
                    --config /tmp/rclone-${name}.conf \
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
                    ${name}:${remote} ${local}
            ''}";

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

    systemd.user.services.rclone-nc = rclone-fs "nc" "/" "${homeDir}/Sync";
    systemd.user.services.rclone-nc-documents = rclone-fs "nc" "/Documents" "${homeDir}/Documents";
}