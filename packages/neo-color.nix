{
  writeShellApplication,
  pkgs,
  text ? "e8e1e1",
  teal ? "ae8795",
  blue ? "a585bc",
  mauve ? "c970ca",
  flamingo ? "9181eb",
  ...
}: let
  colortrans = pkgs.callPackage ./colortrans.nix {};
in
  writeShellApplication {
    name = "neo-color";

    runtimeInputs = [
      colortrans
      pkgs.gawk
    ];
    text = ''
      neoDir="$XDG_CONFIG_HOME/neo"
      neoColorFile="$neoDir/colors"

      text=$(colortrans ${text} | sed -n '2p' | awk '{print $8}')
      teal=$(colortrans ${teal} | sed -n '2p' | awk '{print $8}')
      blue=$(colortrans ${blue} | sed -n '2p' | awk '{print $8}')
      mauve=$(colortrans ${mauve} | sed -n '2p' | awk '{print $8}')
      flamingo=$(colortrans ${flamingo} | sed -n '2p' | awk '{print $8}')

      if [ ! -d "$neoDir" ]; then
        echo "Making Neo Directory"
        mkdir -p "$neoDir"
      fi

      cat >"$neoColorFile" <<EOF
        neo_color_version 1
        -1
        ''${flamingo:11}
        ''${blue:11}
        ''${mauve:11}
        ''${teal:11}
        ''${text:11}
      EOF
    '';
  }
