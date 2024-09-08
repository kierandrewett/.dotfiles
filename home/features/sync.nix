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

    config = {
        General = {
            launchOnSystemStartup = true;
        };

        Accounts = [
            {
                version = 1;
                url = nextcloudUrl;
                authType = "webflow";
                webflow_user = nextcloudUser;
                dav_user = nextcloudUser;
                Folders = [
                    {
                        version = 2;
                        localPath = config.xdg.userDirs.documents;
                        targetPath = "/Documents";
                    }
                    {
                        version = 2;
                        localPath = config.xdg.userDirs.download;
                        targetPath = "/Downloads";
                    }
                    {
                        version = 2;
                        localPath = config.xdg.userDirs.music;
                        targetPath = "/Music";
                    }
                    {
                        version = 2;
                        localPath = config.xdg.userDirs.pictures;
                        targetPath = "/Pictures";
                    }
                    {
                        version = 2;
                        localPath = config.xdg.userDirs.videos;
                        targetPath = "/Videos";
                    }
                ];
            }
        ];
    };

    syncCfgData = lib.generators.toINI {
        listsAsDuplicateKeys = true;
    } config;
in
{
    home.packages = with pkgs; [
        nextcloud-client
    ];

    services.nextcloud-client = {
        enable = true;
        startInBackground = true;
    };

    xdg.configFile."Nextcloud/nextcloud.cfg".text = syncCfgData;
}