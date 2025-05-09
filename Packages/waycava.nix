{writeShellScriptBin, ...}: writeShellScriptBin "waycava.sh" (builtins.readFile ./Bash/waycava.sh)
