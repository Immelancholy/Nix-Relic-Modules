{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nix-relic.wallpaper;
in {
  options.nix-relic.wallpaper = {
    path = mkOption {
      type = types.path;
      default = null;
      description = "Path to wallpaper image (Must be set)";
    };
    animatedWallpaper = {
      enable = mkEnableOption "Whether to use an animated Wallpaper";
      path = mkOption {
        type = types.path;
        default = null;
        description = "Path to animated wallpaper";
      };
    };
  };
  config = {
    stylix = {
      image = cfg.path;
    };
  };
}
