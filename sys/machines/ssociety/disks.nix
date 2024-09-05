_:
{
    disko.devices = {
        disk = {
            # WD PC SN740 1TB M.2 NVMe
            nvme0 = {
                type = "disk";
                device = "/dev/disk/by-id/nvme-WD_PC_SN740_SDDPMQD-1T00-1101_232961802977";
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
                                    mountpoint = "/";
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