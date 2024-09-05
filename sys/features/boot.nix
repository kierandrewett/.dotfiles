{
    lib,
    pkgs,
    ...
}:
{
    environment.systemPackages = with pkgs; [
        plymouth
    ];

    boot = {
        initrd.systemd.enable = true;

        kernelParams = [
            "quiet"
        ];

        kernelPackages = lib.mkForce pkgs.linuxPackages_latest;

        consoleLogLevel = lib.mkForce 0;

        plymouth = {
            enable = true;
        };

        loader = {
            # Continue booting after 5s
            timeout = 2;

            # Allow the installer to modify /boot/efi variables
            efi = {
                canTouchEfiVariables = true;
            };

            # Use systemd-boot as the boot loader
            systemd-boot = {
                enable = true;

                # Max number of NixOS configurations allowed
                # to be displayed in the boot loader.
                configurationLimit = 10;
            };
        };
    };
}