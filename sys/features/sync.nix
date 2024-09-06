{
    config,
    username,
    pkgs,
    lib,
    ...
}:
let
    hasConfig = builtins.pathExists /home/${username}/.config/rclone/nc.conf;

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

    # This is a little hacky, as we can't mount
    # our filesystems from home-manager, but we
    # still need to ensure a config for NC exists.
    file."/home/${username}/.config/rclone/nc.conf".source = config.sops.templates."rclone/nc.conf".path;

    fileSystems = if hasConfig then lib.mapAttrs' (local: remote:
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
    ) syncMap else {};
}