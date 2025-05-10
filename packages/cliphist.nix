{writeShellScriptBin, ...}:
writeShellScriptBin "cliphist.sh" ''
  cliphist list | rofi -dmenu | cliphist decode | wl-copy
''
