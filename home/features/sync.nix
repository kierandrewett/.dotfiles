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

    mountDir = "${homeDir}/Nextcloud";

    nextcloudUrl = builtins.readFile config.sops.secrets."sync/nc/url".path;
    nextcloudUser = builtins.readFile config.sops.secrets."sync/nc/username".path;
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