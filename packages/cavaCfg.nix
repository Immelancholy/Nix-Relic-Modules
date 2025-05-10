{
  writeShellScriptBin,
  pkgs,
  red ? "",
  peach ? "",
  yellow ? "",
  green ? "",
  teal ? "",
  blue ? "",
  mauve ? "",
  ...
}:
writeShellScriptBin "cavaCfg" ''

  cavaConfigFile=$HOME/.config/cava/vcConfig
  id=$(${pkgs.wireplumber}/bin/wpctl status | grep "virtual_cable_in" | ${pkgs.gawk}/bin/awk '{print $2}' | grep -m1 "" | cut -f1 -d ".")
  serial=$(${pkgs.wireplumber}/bin/wpctl inspect "''${id}" | sed -n 's/.*object.serial = //p')
  reduce=$((FRAMERATE / 2))
  if (( $reduce > 90 )); then
    reduce=90
  fi

  cat >"$cavaConfigFile" <<EOF
  [color]
  gradient=1
  gradient_color_1='${mauve}'
  gradient_color_2='${blue}'
  gradient_color_3='${teal}'
  gradient_color_4='${green}'
  gradient_color_5='${yellow}'
  gradient_color_6='${peach}'
  gradient_color_7='${red}'

  [general]
  bar_spacing=0
  bar_width=1
  bars=0
  framerate=''${FRAMERATE}
  sensitivity=100

  [input]
  method=pipewire
  source=''${serial}

  [output]
  channels=stereo
  method=noncurses
  mono_option=average

  [smoothing]
  monstercat=1
  noise_reduction=''${reduce}
  waves=0
  EOF
''
