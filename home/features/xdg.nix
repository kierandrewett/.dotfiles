{
    pkgs,
    lib,
    config,
    ...
}:
let
    browser = "firefox.desktop";
    file-manager = "org.gnome.Nautilus.desktop";
    image-viewer = "org.gnome.Loupe.desktop";
    mail = "thunderbird.desktop";
    code = "code.desktop";
in
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
            "text/html" = browser;
            "x-scheme-handler/http" = browser;
            "x-scheme-handler/https" = browser;
            "x-scheme-handler/about" = browser;
            "x-scheme-handler/unknown" = browser;
            "application/xhtml+xml" = browser;
            "application/pdf" = browser;
            "image/svg+xml" = browser;
            "image/svg+xml-compressed" = browser;

            # Mail
            "x-scheme-handler/mailto" = mail;

            # Text
            "text/plain" = code;

            # Files and folders
            "inode/directory" = file-manager;

            # Images
            "image/jpeg" = image-viewer;
            "image/bmp" = image-viewer;
            "image/gif" = image-viewer;
            "image/jpg" = image-viewer;
            "image/pjpeg" = image-viewer;
            "image/png" = image-viewer;
            "image/tiff" = image-viewer;
            "image/webp" = image-viewer;
            "image/x-bmp" = image-viewer;
            "image/x-gray" = image-viewer;
            "image/x-icb" = image-viewer;
            "image/x-ico" = image-viewer;
            "image/x-png" = image-viewer;
            "image/x-portable-anymap" = image-viewer;
            "image/x-portable-bitmap" = image-viewer;
            "image/x-portable-graymap" = image-viewer;
            "image/x-portable-pixmap" = image-viewer;
            "image/x-xbitmap" = image-viewer;
            "image/x-xpixmap" = image-viewer;
            "image/x-pcx" = image-viewer;
            "image/vnd.wap.wbmp" = image-viewer;
            "image/x-icns" = image-viewer;
        };
    };
}