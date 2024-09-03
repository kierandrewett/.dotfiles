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

        consoleLogLevel = lib.mkForce 0;

        plymouth = {
            enable = true;
        };

        loader = {
            # Continue booting after 5s
            timeout = 5;

            # Allow the installer to modify /boot/efi variables
            efi = {
                canTouchEfiVariables = true;

                efiSysMountPoint = "/boot/efi";
            };

            # Use grub as the boot loader
            grub = {
                enable = true;

                # Enable EFI support
                efiSupport = true;

                # Max number of NixOS configurations allowed
                # to be displayed in the boot loader.
                configurationLimit = 10;

                device = "nodev";
            };
        };
    };
}