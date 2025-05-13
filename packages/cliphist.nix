{
  writeShellApplication,
  pkgs,
  rofi-package ? pkgs.rofi-wayland,
  wl-clip-package ? pkgs.wl-clipboard,
  ...
}:
writeShellApplication {
  name = "cliphist.sh";
  runtimeInputs = [
    pkgs.cliphist
    rofi-package
    wl-clip-package
    pkgs.gawk
  ];
  text = builtins.readFile ./Bash/cliphist.sh;
}
