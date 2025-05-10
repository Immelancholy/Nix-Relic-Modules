{writeShellApplication, ...}:
writeShellApplication {
  name = "checkshell.sh";
  text = ''
    shell=$($SHELL --version | cut -d ' ' -f 1)
    shell=''${shell^}
    echo "$shell"
  '';
}
