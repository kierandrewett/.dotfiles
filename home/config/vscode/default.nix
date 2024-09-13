{
    lib,
    config,
    ...
}:
{
    home.activation.copyVSCodeConfig =
        let
            config = builtins.readFile ./user_settings.json;
        in
        lib.hm.dag.entryAfter [ "writeBoundary" ] ''
            rm -f ${config.xdg.configHome}/Code/User/settings.json
            cat >${config.xdg.configHome}/Code/User/settings.json <<EOL
            ${config}
            EOL
        '';
}