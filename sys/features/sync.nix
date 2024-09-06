{
    config,
    username,
    pkgs,
    lib,
    ...
}:
let
    syncLocationMap = {
        # Local <=> Remote
        "/Documents" = "/Documents";
    };
in
{
    environment.systemPackages = with pkgs; [
        rclone
        syncrclone
    ];

    # Nextcloud Sync
    sops.templates."rclone/nc.conf" = {
        owner = "sync";
        content = ''
            [nc]
            type = webdav
            url = ${config.sops.placeholder."sync/nc/url"}
            user = ${config.sops.placeholder."sync/nc/username"}
            pass = ${config.sops.placeholder."sync/nc/password"}
            vendor = nextcloud
        '';
    };

    fileSystems = lib.mapAttrs' (local: remote:
        lib.nameValuePair "/home/${username}${local}" {
            device = "nc:${remote}";
            fsType = "rclone";
            options = [
                "nodev"
                "nofail"
                "allow_other"
                "args2env"
                "config=/home/${username}/.config/rclone/nc.conf"
            ];
        }
    ) syncLocationMap;
}