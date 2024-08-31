_:
{
    disko.devices = {
        disk = {
            # QEMU Virtual Disk
            vda = {
                type = "disk";
                device = "/dev/vda";
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
                                mountOptions = [
                                    "defaults"
                                ];
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
                                        swap.swapfile.size = "8GB";
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