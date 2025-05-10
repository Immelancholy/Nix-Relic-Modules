{
  writeShellScriptBin,
  base ? "",
  mantle ? "",
  surface0 ? "",
  surface1 ? "",
  surface2 ? "",
  text ? "",
  rosewater ? "",
  lavender ? "",
  red ? "",
  peach ? "",
  yellow ? "",
  green ? "",
  teal ? "",
  blue ? "",
  mauve ? "",
  flamingo ? "",
  ...
}:
writeShellScriptBin "neo-color" ''
  neoDir="$XDG_CONFIG_HOME/neo"
  neoColorFile="$neoDir/colors"

  base=$(colortrans ${base} | sed -n '2p' | awk '{print $8}')
  mantle=$(colortrans ${mantle} | sed -n '2p' | awk '{print $8}')
  surface0=$(colortrans ${surface0} | sed -n '2p' | awk '{print $8}')
  surface1=$(colortrans ${surface1} | sed -n '2p' | awk '{print $8}')
  surface2=$(colortrans ${surface2} | sed -n '2p' | awk '{print $8}')
  text=$(colortrans ${text} | sed -n '2p' | awk '{print $8}')
  rosewater=$(colortrans ${rosewater} | sed -n '2p' | awk '{print $8}')
  lavender=$(colortrans ${lavender} | sed -n '2p' | awk '{print $8}')
  red=$(colortrans ${red} | sed -n '2p' | awk '{print $8}')
  peach=$(colortrans ${peach} | sed -n '2p' | awk '{print $8}')
  yellow=$(colortrans ${yellow} | sed -n '2p' | awk '{print $8}')
  green=$(colortrans ${green} | sed -n '2p' | awk '{print $8}')
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
''
