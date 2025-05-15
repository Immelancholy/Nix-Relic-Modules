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
      type = with types; attrsOf attrs;
      apply = mapAttrs user;
      default = [];
    };
  };
  options.users.users = mkOption {
    type = with types;
      attrsOf (submodule ({
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
          isAdmin = mkOption {
            type = types.bool;
            default = false;
            description = "Access to sudo";
          };
          home-config = mkOption {
            description = "Extra home manager config";
            type = types.attrs;
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
    users = {
      users = cfg.users;
    };
  };
}
