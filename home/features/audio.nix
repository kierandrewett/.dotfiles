{
    pkgs,
    config,
    ...
}:
{
    services.easyeffects = {
        enable = true;
        preset = "Default";
    };

    dconf.settings."com/github/wwmm/easyeffects" = {
        last-loaded-output-preset = config.services.easyeffects.preset;
    };
}