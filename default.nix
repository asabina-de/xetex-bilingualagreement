{ stdenv, pkgs }:

let
  redefinedInvoice = let
    invoice = pkgs.stdenv.mkDerivation rec {
      version = "2011-10-01";
      pname = "invoice";
      tlType = "run";

      name = "${pname}-${version}";

      src = ./invoice;

      buildInputs = with pkgs; [
        tree
        #unzip
      ];

      dontBuild = true;

      unpackPhase = ''
        echo "nothing to unpack";
      '';

      installPhase = ''
        mkdir -p $out/tex/latex/invoice
        cp -r $src/texinput $out/tex/latex/invoice
      '';
    };
  in { pkgs = [ invoice ]; };
in stdenv.mkDerivation rec {
  name = "asabina-latex-${version}";
  version = "0.1.0";

  buildInputs = with pkgs; [
    (texlive.combine {
      inherit (texlive)
      scheme-basic
      luatex

      # biblatex
      # blindtext
      collection-basic
      collection-fontsrecommended
      collection-langeuropean
      collection-langgerman
      collection-latexrecommended
      datetime
      enumitem
      etoolbox
      fmtcount
      # graphics-def
      # IEEEtran
      # lastpage
      # layouts
      # logreq
      numprint
      paracol
      # pdfcrop
      # realscripts
      tableof
      # tabu
      tocloft
      # varwidth
      # xargs
      xetex
      # xltxtra
      # xstring
      # xtab
      ;
    })
    zip
    unzip
  ];

  #shellHook = ''
  #  #export PATH="$PATH:${pkgs.arduino-core}/share/arduino/"
  #'';
}
