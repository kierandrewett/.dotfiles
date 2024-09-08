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
    ncUrl = "https://nc.kierand.dev";
    ncUser = "kieran";

    ncConfigDir = "${config.xdg.configHome}/Nextcloud";
    ncConfigPath = "${ncConfigDir}/nextcloud.cfg";

    ncConfig = ''
        [General]
        launchOnSystemStartup=true

        [Accounts]
        0\version=1;
        0\url=${ncUrl};
        0\authType=webflow;
        0\webflow_user=${ncUser};
        0\dav_user=${ncUser};

        0\Folders\0\version=2;
        0\Folders\0\localPath=${mountDir};
        0\Folders\0\targetPath=/;
    '';
in
{
    home.packages = with pkgs; [
        nextcloud-client
    ];

    services.nextcloud-client = {
        enable = true;
        startInBackground = true;
    };

    home.activation.initNextcloudConfig = lib.mkAfter ''
        echo "Setting up nextcloud config..."
        mkdir -p "${ncConfigDir}"
        echo "${ncConfig}" > "${ncConfigPath}"
        chown ${config.home.username}:users "${ncConfigPath}"
        chmod 644 "${ncConfigPath}"
    '';
}