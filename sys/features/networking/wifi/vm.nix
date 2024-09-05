{
    config,
    ...
}:
{
    networking.networkmanager.ensureProfiles = {
        environmentFiles = [config.sops.templates."wifi/vm.env".path];

        profiles.vm = {
            connection = {
                id = "vm";
                type = "wifi";
            };
            wifi = {
                ssid = "$SSID";
            };
            wifi-security = {
                key-mgmt = "wpa-psk";
                psk = "$PSK";
            };
        };
    };
}