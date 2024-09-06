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

    # This is a little hacky, as we
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