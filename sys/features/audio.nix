{
    lib,
    config,
    username,
    ...
}:
{
    security.rtkit.enable = true;

    services.pipewire = {
        enable = true;

        alsa.enable = true;
        alsa.support32Bit = lib.mkForce config.hardware.opengl.driSupport32Bit;

        pulse.enable = true;
    };

    services.easyeffects = {
        enable = true;
        preset = "Default";
    };

    # Add our user to the rtkit and audio groups
    users.users.${username}.extraGroups = [
        "rtkit"
        "audio"
    ]
}