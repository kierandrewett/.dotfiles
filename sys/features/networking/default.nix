{
    hostname,
    ...
}:
{
    imports = [
        ./wifi/vm.nix
    ];

    networking = {
        hostName = hostname;

        wireless.enable = true;

        nameservers = [
            "1.1.1.1"
            "1.0.0.1"
        ];

        networkmanager = {
            enable = true;
        };
    };
}