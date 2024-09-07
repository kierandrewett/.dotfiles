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