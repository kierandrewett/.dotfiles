{
    inputs,
    username,
    hostname,
    platform,
    desktop,
    stateVersion ? null,
    ...
}:
{
    imports = [
        inputs.home-manager.nixosModules.home-manager
        inputs.sops-nix.nixosModules.sops

        ../lib/nix-config.nix

        ./machines/${hostname}
        ./desktop/${desktop}
        ./features
        ./users
    ];

    sops = {
        age = {
            keyFile = "/home/${username}/.config/sops/age/key.txt";
            generateKey = false;
        };

        defaultSopsFile = ../secrets/secrets.yaml;

        secrets = {
            "luks/passphrase" = {};

            "users/${username}/passwd" = {
                neededForUsers = true;
            };

            "networks/vm/ssid" = {};
            "networks/vm/psk" = {};
        };
    };

    system.stateVersion = stateVersion;
}