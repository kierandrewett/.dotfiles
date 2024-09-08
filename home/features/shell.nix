{
    pkgs,
    config,
    ...
}:
let
    zsh-headline = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/Moarram/headline/c12368adfbbaa35e7f21e743d34b59f8db263a95/headline.zsh-theme";
        sha256 = "0w394y3rmj60gm5fvi829q9lp16dhr8fp5n62y5b618zz2qf18lr";
    };
in
{
    home = {
        packages = with pkgs; [
            fastfetch
        ];

        # These are not user shell specific!
        # Make sure they're compatible with all shells.
        shellAliases = {
            neofetch = "fastfetch"; # Old habits die hard

            nix-pull = pkgs.writeShellScript "nix-pull" ''
                set -ex

                cd /etc/nixos
                sudo git pull
                sudo nixos-rebuild switch $@
            '';
            nix-push = pkgs.writeShellScript "nix-push" ''
                set -ex

                cd /etc/nixos
                sudo git commit
                sudo nixos-rebuild switch $@
                sudo push
            '';
            nix-sync = "nix-pull && nix-push";
        };
    };

    programs.zsh = {
        enable = true;

        initExtra = ''
            source ${zsh-headline}

            fastfetch
        '';

        history = {
            size = 10000;
            path = "${config.xdg.dataHome}/zsh/history";
        };

        oh-my-zsh = {
            enable = true;
            plugins = [
                "git"
            ];
        };
    };
}