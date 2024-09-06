{
    hostname,
    username,
    lib,
    ...
}:
{
    imports = [
        ./firewall.nix
        
        ./wifi/vm.nix
    ];

    networking = {
        hostName = hostname;

        useDHCP = lib.mkForce true;

        nameservers = [
            "1.1.1.1"
            "1.0.0.1"
        ];

        networkmanager = {
            enable = true;
        };
    };

    users.users.${username}.extraGroups = [
        "networkmanager"
    ];
}