{
  pkgs,
  config,
  lib,
  ...
}: let
  cavaCfg = pkgs.callPackage ../../../packages/cavaCfg.nix {
    red = "${config.lib.stylix.colors.base08}";
    peach = "${config.lib.stylix.colors.base09}";
    yellow = "${config.lib.stylix.colors.base0A}";
    green = "${config.lib.stylix.colors.base0B}";
    teal = "${config.lib.stylix.colors.base0C}";
    blue = "${config.lib.stylix.colors.base0D}";
    mauve = "${config.lib.stylix.colors.base0E}";
  };

  cfg = config.services.cavaCfg;
in {
  options.services.cavaCfg.enable = lib.mkEnableOption "Enable neo color file generation service";

  config = lib.mkIf cfg.enable {
    systemd.user.services."cavaCfg" = {
      enable = true;
      name = "Neo Color";
      wantedBy = ["default.target"];
      path = [
        cavaCfg
      ];
      script = ''cavaCfg'';
    };
  };
}
