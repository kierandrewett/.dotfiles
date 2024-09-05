{
    hostname,
    username,
    lib,
    ...
}:
{
    imports = [
        ./wifi/vm.nix
    ];

    networking = {
        hostName = hostname;

        useDHCP = lib.mkForce true;

        nameservers = [
            "1.1.1.1"
            "1.0.0.1"
        ];
    };

    users.users.${username}.extraGroups = [
        "networkmanager"
    ];
}