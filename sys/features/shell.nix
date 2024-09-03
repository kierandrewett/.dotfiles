{
    pkgs,
    ...
}:
{
    # Super rudimentary zsh config for everyone else
    programs.zsh.enable = true;

    environment.systemPackages = with pkgs; [
        pkgs.fastfetch
    ];
}