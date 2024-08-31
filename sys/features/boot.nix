{
    lib,
    ...
}:
{
    boot = {
        kernelParams = [
            "quiet"
        ];

        consoleLogLevel = lib.mkForce 0;

        # Hides the bootloader, press any key on boot to show
        loader.timeout = 0;

        plymouth = {
            enable = true;
        };
    };
}