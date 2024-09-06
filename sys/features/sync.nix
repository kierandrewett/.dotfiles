{
    config,
    username,
    pkgs,
    lib,
    ...
}:
let
    # syncMap = {
    #     # Local <=> Remote
    #     "/Documents" = "/Documents";
    # };
in
{
    # environment.systemPackages = with pkgs; [
    #     rclone
    # ];

    # # This is a little hacky, as we
    # fileSystems = lib.mapAttrs' (local: remote:
    #     lib.nameValuePair "/home/${username}${local}" {
    #         device = "nc:${remote}";
    #         fsType = "rclone";
    #         options = [
    #             "nodev"
    #             "nofail"
    #             "allow_other"
    #             "args2env"
    #             "config=/home/${username}/.config/rclone/nc.conf"
    #         ];
    #     }
    # ) syncMap;
}