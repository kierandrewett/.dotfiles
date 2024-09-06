{
    pkgs,
    inputs,
    platform,
    ...
}:
let
    extensions = inputs.vscode-extensions.extensions.${platform};
in 
{
    home.packages = with pkgs; [
        vscode
    ];

    programs.vscode = {
        enable = true;
        enableUpdateCheck = true;
        enableExtensionUpdateCheck = true;

        extensions = with extensions.vscode-marketplace; [
            github.github-vscode-theme
            pkief.material-icon-theme
            miguelsolorio.fluent-icons
        ];

        userSettings = {
            "window.titleBarStyle" = "custom";
            "workbench.colorTheme" = "GitHub Dark Default";
            "workbench.iconTheme" = "material-icon-theme";
            "workbench.productIconTheme" = "fluent-icons";
        };
    };
}