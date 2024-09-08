{
    pkgs,
    lib,
    config,
    ...
}:
{
    xdg = {
        userDirs = {
            enable = true;

            documents = lib.mkForce "${config.home.homeDirectory}/Documents";
            download = lib.mkForce "${config.home.homeDirectory}/Downloads";
            music = lib.mkForce "${config.home.homeDirectory}/Music";
            pictures = lib.mkForce "${config.home.homeDirectory}/Pictures";
            videos = lib.mkForce "${config.home.homeDirectory}/Videos";
        };

        mimeApps.defaultApplications = {
            # Internet Browsers
            "text/html" = "firefox.desktop";
            "x-scheme-handler/http" = "firefox.desktop";
            "x-scheme-handler/https" = "firefox.desktop";
            "x-scheme-handler/about" = "firefox.desktop";
            "x-scheme-handler/unknown" = "firefox.desktop";
        };
    };
}