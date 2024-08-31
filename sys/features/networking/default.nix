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

        wireless = {
            enable = true;
            userControlled.enable = true;
        };

        nameservers = [
            "1.1.1.1"
            "1.0.0.1"
        ];

        networkmanager = {
            enable = true;

            # Exclude wireless networks from networkmanager as
            # these will be handled by wpa_supplicant instead.
            unmanaged = [
                "*" "except:type:wwan" "except:type:gsm"
            ];
        };
    };
}