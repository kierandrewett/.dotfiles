_:
{
    disko.devices = {
        disk = {
            # QEMU Virtual Disk
            sda = {
                type = "disk";
                device = "/dev/sda";
                content = {
                    type = "gpt";
                    partitions = {
                        boot = {
                            size = "1024M";
                            type = "EF00";
                            content = {
                                type = "filesystem";
                                format = "vfat";
                                mountpoint = "/boot";
                            };
                        };
                        root = {
                            size = "100%";
                            content = {
                                type = "btrfs";
                                extraArgs = [ "-f" ];
                                mountpoint = "/";
                                mountOptions = [ "compress=zstd" "noatime" ];
                                subvolumes = {
                                    "/swap" = {
                                        mountpoint = "/.swapvol";
                                        # 1/4 of RAM size
                                        swap.swapfile.size = "8G";
                                    };
                                };
                            };
                        };
                        luks = {
                            size = "100%";
                            content = {
                                type = "luks";
                                name = "crypted";
                                settings = {
                                    allowDiscards = true;
                                    keyFile = "/tmp/luks.key";
                                };
                                content = {
                                    type = "btrfs";
                                    extraArgs = [ "-f" ];
                                    mountpoint = "/home";
                                    mountOptions = [ "compress=zstd" "noatime" ];
                                };
                            };
                        };
                    };
                };
            };
        };
    };
}