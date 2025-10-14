{
  writeShellScriptBin,
  pkgs,
  cavaDir ? "$HOME/.config/cava",
  ...
}:
writeShellScriptBin "cavaCfg" ''
  cavaDir="${cavaDir}"
  cavaConfigFile="$cavaDir/config"
  id=$(${pkgs.wireplumber}/bin/wpctl status | grep "virtual_cable_in" | ${pkgs.gawk}/bin/awk '{print $2}' | grep -m1 "" | cut -f1 -d ".")
  serial=$(${pkgs.wireplumber}/bin/wpctl inspect "''${id}" | sed -n 's/.*object.serial = //p')
  reduce=$((FRAMERATE / 2))
  if (( $reduce > 90 )); then
    reduce=90
  fi

  if [ ! -d "$cavaDir" ]; then
    echo "Making cava Directory"
    mkdir -p "$cavaDir"
  fi

  cat >"$cavaConfigFile" <<EOF
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
