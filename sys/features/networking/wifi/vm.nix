{
    config,
    ...
}:
{
    sops.templates."wifi/vm.env".content = ''
        ssid = "${config.sops.placeholder."networks/vm/ssid"}"
        psk = "${config.sops.placeholder."networks/vm/psk"}"
    '';

    networking.wireless.environmentFile = config.sops.secrets."wifi/vm.env".path;
    networking.wireless.networks = {
        "@ssid@" = {
            psk = "@psk@";

            # Always attempt to use this network
            priority = 1000;
        };
    };
}