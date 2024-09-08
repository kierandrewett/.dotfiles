{
    inputs,
    pkgs,
    config,
    lib,
    username,
    ...
}:
let
    homeDir = config.home.homeDirectory;

    readSecretFile = file:
        lib.optionalString (builtins.pathExists file) (builtins.readFile file);

    mountDir = "${homeDir}/Nextcloud";

    nextcloudUrl = readSecretFile "/run/secrets/sync/nc/url";
    nextcloudUser = readSecretFile "/run/secrets/sync/nc/username";
in
{
    home.packages = with pkgs; [
        nextcloud-client
    ];

    services.nextcloud-client = {
        enable = true;
        startInBackground = true;
    };

    xdg.configFile."Nextcloud/nextcloud.cfg".text = ''
        [General]
        launchOnSystemStartup=true

        [Accounts]
        0\version=1;
        0\url=${nextcloudUrl};
        0\authType=webflow;
        0\webflow_user=${nextcloudUser};
        0\dav_user=${nextcloudUser};

        0\Folders\0\version=2;
        0\Folders\0\localPath=${mountDir};
        0\Folders\0\targetPath=/;
    '';
}