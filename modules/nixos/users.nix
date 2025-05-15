{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nix-relic.users;
  user = name: attrs @ {
    isNormalUser ? true,
    createHome ? true,
    ...
  }:
    attrs
    // {
      inherit isNormalUser createHome;
    };
in {
  options.nix-relic.users = {
    defaultGroups = mkOption {
      description = "Groups all users should have";
      type = with types; listOf str;
      default = [
        "networkmanager"
        "video"
        "seat"
      ];
    };
    users = mkOption {
      description = "Users with sane defaults";
      type = with types; loaOf attrs;
      apply = mapAttrs user;
      default = [];
    };
  };
  options.user.users = mkOption {
    type = with types;
      loaOf (submodule ({
        name,
        config,
        ...
      }: {
        options = {
          extraGroups = mkOption {
            apply = groups:
              if config.isNormalUser
              then cfg.defaultGroups ++ groups
              else groups;
          };
          isAdmin = mkEnableOption "Access to sudo";
          home-config = mkOption {
            description = "Extra home manager config";
            type = types.atts;
            default = {};
          };
        };
        config = {
          extraGroups =
            if config.isAdmin
            then ["wheel"]
            else [];
        };
      }));
  };

  config = {
    users = cfg.users;
  };
}
