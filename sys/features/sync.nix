{
    config,
    username,
    pkgs,
    lib,
    ...
}:
let
    syncMap = {
        # Local <=> Remote
        "/Documents" = "/Documents";
    };
in
{
    environment.systemPackages = with pkgs; [
        rclone
    ];

    # Nextcloud Sync
    sops.templates."rclone/nc.conf".content = ''
        [nc]
        type = webdav
        url = ${config.sops.placeholder."sync/nc/url"}
        user = ${config.sops.placeholder."sync/nc/username"}
        pass = ${config.sops.placeholder."sync/nc/password"}
        vendor = nextcloud
    '';

    environment.etc."rclone/nc.conf".source = config.sops.templates."rclone/nc.conf".path;

    fileSystems = lib.mapAttrs' (local: remote: {
        "fileSystems.${"/home/${username}${local}"}" = {
            device = "nc:${remote}";
            fsType = "rclone";
            options = [
                "nodev"
                "nofail"
                "allow_other"
                "args2env"
                "config=/etc/rclone/nc.conf"
            ];
        };
    }) syncMap;
}