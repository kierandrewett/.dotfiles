_:
{
    programs.git = {
        enable = true;
        userName = "kierandrewett";
        userEmail = "kieran@dothq.org";

        extraConfig = {
            credential.helper = "store";

            safe.directory = [
                "/etc/nixos"
            ];
        };
    };
}