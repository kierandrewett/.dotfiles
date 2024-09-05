{
    hostname,
    username,
    ...
}:
{
    imports = [
        ./wifi/vm.nix
    ];

    networking = {
        hostName = hostname;

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