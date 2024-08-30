{
    config,
    ...
}:
let
    let ssid = config.sops.secrets."networks/vm/ssid";
    let psk = config.sops.secrets."networks/vm/psk";
in
{
    networks.wireless.networks."${ssid}" = {
        inherit psk;

        # Always attempt to use this network
        priority = 1000;
    }
}