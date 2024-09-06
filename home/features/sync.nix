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
}