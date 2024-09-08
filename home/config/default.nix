{
    config,
    ...
}:
{
    imports = [
        (if config.services.easyeffects.enable then ./easyeffects else null)
    ];
}