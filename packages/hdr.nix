{writeShellScriptBin}:
writeShellScriptBin "force-hdr" ''
  FORCE_HDR=$(hyprctl getoption render:cm_fs_passthrough | sed -n '1p' | awk '{print $2}')

  if [ "$FORCE_HDR" != 1 ]; then
  	hyprctl keyword monitor "$*, bitdepth, 10, cm, hdr"
  	hyprctl keyword render:cm_fs_passthrough 1
  else
  	hyprctl keyword monitor "$*, bitdepth, 8, cm, srgb"
  	hyprctl keyword render:cm_fs_passthrough 2
  fi
''
