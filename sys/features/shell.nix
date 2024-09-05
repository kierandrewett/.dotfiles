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
        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;
    };
}