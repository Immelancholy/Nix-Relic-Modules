{
  writeShellApplication,
  pkgs,
  ...
}:
writeShellApplication {
  name = "ss.sh";

  runtimeInputs = [
    pkgs.swappy
    pkgs.hyprshot
  ];

  text = builtins.readFile ./Bash/ss.sh;
}
