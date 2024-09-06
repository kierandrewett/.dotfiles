{
    pkgs,
    ...
}:
let
    segoe-ui = pkgs.stdenv.mkDerivation rec {
        pname = "ttf-segoe-ui";
        version = "2024-09-06";

        src = pkgs.fetchFromGitHub {
            owner = "mrbvrz";
            repo = "segoe-ui-linux";
            rev = "a89213b7136da6dd5c3638db1f2c6e814c40fa84";
            sha256 = "sha256-0KXfNu/J1/OUnj0jeQDnYgTdeAIHcV+M+vCPie6AZcU=";
        };

        installPhase = ''
            mkdir -p $out/share/fonts/truetype
            install -m644 $src/font/*.ttf $out/share/fonts/truetype/
        '';
    };
in
{
    environment.systemPackages = with pkgs; [
        geist-font

        # Microsoft fonts
        corefonts
        vistafonts
        segoe-ui
    ];

    fonts.fontconfig.defaultFonts.monospace = [ "Geist Mono" ];
}