{
    username,
    ...
}:
{
    services.syncthing = {
        enable = true;
        user = username;

        dataDir = "/home/${username}";
        configDir = "/home/${username}/.config/syncthing";

        overrideDevices = true;
        overrideFolders = true;
    };
}