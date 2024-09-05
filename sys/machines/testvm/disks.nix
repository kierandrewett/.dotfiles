_:
{
    disko.devices = {
        disk = {
            # WD Blue SN570 1TB M.2 NVMe
            nvme0 = {
                type = "disk";
                device = "/dev/sda";
                content = {
                    type = "gpt";
                    partitions = {
                        luks = {
                            size = "100%";
                            label = "";
                            content = {
                                type = "luks";
                                name = "crypted";
                                passwordFile = "/tmp/luks.key";
                                settings = {
                                    allowDiscards = true;
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
            # Crucial P2 500GB M.2 NVMe (CT500P2SSD8)
            nvme1 = {
                type = "disk";
                device = "/dev/sdb";
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
                                        swap.swapfile.size = "8G";
                                    };
                                };
                            };
                        };
                    };
                };
            };
        };
    };
}