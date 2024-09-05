{
    pkgs,
    config,
    ...
}:
let
    zsh-headline = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/moarram/headline/master/headline.zsh-theme";
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
        };
    };

    programs.zsh = {
        enable = true;

        initExtra = "fastfetch";
        promptInit = ''
            source ${zsh-headline}
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
            theme = "custom";
        };
    };
}