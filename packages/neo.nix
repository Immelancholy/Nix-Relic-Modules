{
  writeShellApplication,
  pkgs,
  ...
}:
writeShellApplication {
  name = "neo.sh";

  runtimeInputs = [
    pkgs.neo
  ];

  text = ''
    user="''${USER^}"
    neo -a -S 20 -d 1 -f "$FRAMERATE" -C "$XDG_CONFIG_HOME"/neo/colors -b 1 -m "Welcome, ''${user}." --lingerms=1,1 --rippct=0
  '';
}
