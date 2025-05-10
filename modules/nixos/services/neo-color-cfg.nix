{
  pkgs,
  config,
  lib,
  ...
}: let
  colortrans = pkgs.callPackage ../../../packages/colortrans.nix {};

  neo-color = pkgs.callPackage ../../../packages/neo-color.nix {
    base = "${config.lib.stylix.colors.base00}";
    mantle = "${config.lib.stylix.colors.base01}";
    surface0 = "${config.lib.stylix.colors.base02}";
    surface1 = "${config.lib.stylix.colors.base03}";
    surface2 = "${config.lib.stylix.colors.base04}";
    text = "${config.lib.stylix.colors.base05}";
    rosewater = "${config.lib.stylix.colors.base06}";
    lavender = "${config.lib.stylix.colors.base07}";
    red = "${config.lib.stylix.colors.base08}";
    peach = "${config.lib.stylix.colors.base09}";
    yellow = "${config.lib.stylix.colors.base0A}";
    green = "${config.lib.stylix.colors.base0B}";
    teal = "${config.lib.stylix.colors.base0C}";
    blue = "${config.lib.stylix.colors.base0D}";
    mauve = "${config.lib.stylix.colors.base0E}";
    flamingo = "${config.lib.stylix.colors.base0F}";
  };

  cfg = config.services.neo-color;
in {
  options.services.neo-color.enable = lib.mkEnableOption "Enable neo color file generation service";

  config = lib.mkIf cfg.enable {
    systemd.user.services."neo-color" = {
      enable = true;
      name = "Neo Color";
      wantedBy = ["default.target"];
      path = [
        colortrans
        neo-color
        pkgs.gawk
      ];
      script = ''neo-color'';
    };
  };
}
