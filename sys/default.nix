{
    inputs,
    username,
    hostname,
    platform,
    desktop,
    stateVersion ? null,
    lib,
    config,
    pkgs,
    ...
}:
{
    imports = [
        inputs.sops-nix.nixosModules.sops
        inputs.disko.nixosModules.disko

        ./machines/${hostname}
        ./desktop/${desktop}
        ./features
        ./users
    ];

    # These packages are absolutely essential
    # and will be required on all machines!
    environment.systemPackages = with pkgs; [
        pkgs.git
    ];

    sops = {
        age = {
            keyFile = "/home/${username}/.config/sops/age/key.txt";
            generateKey = false;
        };

        defaultSopsFile = ../secrets/secrets.yaml;

        secrets = {
            "luks/passphrase" = {};

            "users/${username}/passwd" = {};

            "networks/vm/ssid" = {};
            "networks/vm/psk" = {};
        };

        templates = {
            "wifi/vm.env" = {
                content = ''
                    ssid = "${config.sops.placeholder."networks/vm/ssid"}"
                    psk = "${config.sops.placeholder."networks/vm/psk"}"
                '';
            };
        };
    };
}