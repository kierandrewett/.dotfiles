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

    homeDirLinks = {
        # Local path <=> Remote path
        "/Documents" = "/Documents";
        "/Downloads" = "/Downloads";
        "/Music" = "/Music";
        "/Pictures" = "/Pictures";
        "/Videos" = "/Videos";
    };

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

    xdg.configFile."Nextcloud/sync-exclude.lst".source = ../config/nextcloud/sync-exclude.lst;
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
        rm "${ncConfigPath}"
        echo "${ncConfig}" > "${ncConfigPath}"
        chown ${config.home.username}:users "${ncConfigPath}"
        chmod 644 "${ncConfigPath}"

        echo "Setup homedir symlinks..."
        ${builtins.concatStringsSep "\n" (map (path: ''
            rm -rf ${homeDir}${path} && ln -s ${mountDir}${homeDirLinks.${path}} ${homeDir}${path}
        '') homeDirLinks)}
    '';
}