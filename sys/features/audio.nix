{
    lib,
    config,
    username,
    pkgs,
    ...
}:
{
    security.rtkit.enable = true;


    hardware.pulseaudio.enable = false;
    services.pipewire = {
        enable = true;

        alsa.enable = true;
        alsa.support32Bit = true;

        pulse.enable = true;
    };

    # Add our user to the rtkit and audio groups
    users.users.${username}.extraGroups = [
        "rtkit"
        "audio"
    ];
}