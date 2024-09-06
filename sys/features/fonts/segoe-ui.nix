{
    stdenv,
    fetchFromGitHub,
}:
stdenv.mkDerivation rec {
    pname = "ttf-segoe-ui";
    version = "2024-09-06";

    src = fetchFromGitHub {
        owner = "mrbvrz";
        repo = "segoe-ui-linux";
        rev = "a89213b7136da6dd5c3638db1f2c6e814c40fa84";
        hash = "1gsscyahcfia5hnsi9sakd435ffimhccjwv4y2q8cqqm28bvzjhg";
    };

    installPhase = ''
        mkdir -p $out/share/fonts/truetype
        install -m644 $src/font/*.ttf $out/share/fonts/truetype/
    '';
}