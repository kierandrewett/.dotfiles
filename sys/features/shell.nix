{
    pkgs,
    ...
}:
{
    environment.systemPackages = with pkgs; [
        pkgs.fastfetch
    ];

    programs.zsh = {
        enable = true;

        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
    };
}