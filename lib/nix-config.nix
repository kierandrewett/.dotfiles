{
    inputs,
    username,
    outputs,
    platform,
    pkgs,
    lib,
    stateVersion,
    config,
    ...
}:
{
    nixpkgs = {
        config = {
            allowUnfree = true;
        };

        overlays = [
            inputs.nur.overlay
        ];
    };

    nix = {
        settings = {
            experimental-features = "nix-command flakes";
            flake-registry = "";
            auto-optimise-store = true;
            trusted-users = [ "root" "${username}" ];
            warn-dirty = false;
        };
        gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
        };
    };

    nixpkgs.hostPlatform = lib.mkDefault "${platform}";

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

            "sync/nc/url" = {};
            "sync/nc/username" = {};
            "sync/nc/password" = {};
        };

        templates = {
            "wifi/vm.env" = {
                content = ''
                    SSID = "${config.sops.placeholder."networks/vm/ssid"}"
                    PSK = "${config.sops.placeholder."networks/vm/psk"}"
                '';
            };
        };
    };

    system = {
        inherit stateVersion;
    };
}