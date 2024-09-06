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
    sops.templates."rclone/nc.conf" = {
        owner = username;
        content = ''
            [nc]
            type = webdav
            url = ${config.sops.placeholder."sync/nc/url"}
            user = ${config.sops.placeholder."sync/nc/username"}
            pass = ${config.sops.placeholder."sync/nc/password"}
            vendor = nextcloud
        '';
    };
}