{
    config,
    ...
}:
{
    networking.wireless.environmentFile = config.sops.templates."wifi/vm.env".path;
    networking.wireless.networks = {
        "@ssid@" = {
            psk = "@psk@";

            # Always attempt to use this network
            priority = 1000;
        };
    };
}