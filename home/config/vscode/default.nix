_:
{
    home.activation.copyVSCodeConfig =
        let
            config = builtins.readFile ./user_settings.json;
        in
        lib.hm.dag.entryAfter [ "writeBoundary" ] ''
            rm -f $XDG_CONFIG_HOME/Code/User/settings.json
            cat >$XDG_CONFIG_HOME/Code/User/settings.json <<EOL
                ${config}
            EOL
        '';
}