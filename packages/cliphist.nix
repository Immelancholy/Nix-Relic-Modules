{
  writeShellApplication,
  pkgs,
  ...
}:
writeShellApplication {
  name = "cliphist.sh";
  runtimeInputs = [
    pkgs.cliphist
    pkgs.rofi-wayland
    pkgs.wl-clipboard
  ];
  text = ''
    cliphist list | rofi -dmenu | cliphist decode | wl-copy
  '';
}
