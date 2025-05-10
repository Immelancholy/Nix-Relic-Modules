{
  pkgs,
  config,
  lib,
  ...
}: let
  colortrans = pkgs.callPackage ../../../packages/colortrans.nix {};

  neo-color = pkgs.callPackage ../../../packages/neo-color.nix {};

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
