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

    # Really awful that I need to hardcode these.
    # Until SOPS templating support for home manager
    # lands this is my only option.
    nextcloudUrl = "https://nc.kierand.dev";
    nextcloudUser = "kieran";
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