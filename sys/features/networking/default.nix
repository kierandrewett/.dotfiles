{
    hostname,
    username,
    lib,
    ...
}:
let
    safeHostname = builtins.replaceStrings [" "] ["--"] hostname;

    nextdnsHostname = "${safeHostname}-729ec3.dns.nextdns.io";
in
{
    imports = [
        ./firewall.nix

        ./wifi/vm.nix
    ];

    networking = {
        hostName = hostname;

        useDHCP = lib.mkForce true;

        nameservers = [
            "45.90.28.0#${nextdnsHostname}"
            "45.90.30.0#${nextdnsHostname}"
            "1.1.1.1#one.one.one.one"
            "1.0.0.1#one.one.one.one"
        ];

        networkmanager = {
            enable = true;
            dns = "systemd-resolved";
        };
    };

    services.resolved = {
        enable = true;

        dnssec = "true";
        dnsovertls = "true";
        domains = [ "~." ];

        fallbackDns = [
            "45.90.28.0#${nextdnsHostname}"
            "2a07:a8c0::#${nextdnsHostname}"
            "45.90.30.0#${nextdnsHostname}"
            "2a07:a8c1::#${nextdnsHostname}"
            "1.1.1.1#one.one.one.one"
            "1.0.0.1#one.one.one.one"
        ];
    };

    users.users.${username}.extraGroups = [
        "networkmanager"
    ];
}