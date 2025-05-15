{
  config,
  lib,
  ...
}:
with lib; let
  userOpts = {
    name,
    config,
    ...
  }: {
    options = {
      userOpts = {
        name,
        config,
        ...
      }: {
        isAdmin = mkEnableOption "Enable sudo access";
      };
    };
    config = mkMerge [
      (mkIf config.isNormalUser {
        extraGroups = [
          "networkmanager"
          "video"
          "seat"
        ];
      })
      (mkIf config.isAdmin {
        extraGroups = [
          "networkmanager"
          "video"
          "seat"
          "wheel"
        ];
      })
    ];
  };
in {
  options.users.users = mkOption {
    default = {};
    type = with types; attrsOf (submodule userOpts);
  };
}
