{
    config,
    lib,
    pkgs,
    username,
    ...
}:
let
    syncDriveMounts = {
        # Local <=> Remote
        "/Documents" = "/Documents";
    };
in
{
    home.packages = with pkgs; [
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

    home.file.".config/rclone/nc.conf".source = config.sops.templates."rclone/nc.conf".path;

    fileSystems = lib.mapAttrs' (local: remote:
        lib.nameValuePair "/home/${username}${local}" {
            device = "nc:${remote}";
            fsType = "rclone";
            options = [
                "nodev"
                "nofail"
                "allow_other"
                "args2env"
                "config=${config.home.file.".config/rclone/nc.conf".path}"
            ];
        }
    ) syncDriveMounts;
}