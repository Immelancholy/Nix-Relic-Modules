{
  writeShellApplication,
  pkgs,
  rofiPackage ? pkgs.rofi-wayland,
  ...
}:
writeShellApplication {
  name = "rofi-power-menu";
  runtimeInputs = [
    rofiPackage
  ];
  text = builtins.readFile ./Bash/rofi-power-menu;
}
