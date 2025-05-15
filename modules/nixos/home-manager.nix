{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.nix-relic.home-manager = {
    useHostNameUserNameHomePath = mkEnableOption "Use ./\${config.networking.hostName}/users/\${config.nix-relic.home-manager.config.home.username}/home.nix\n as import for home-manager";
    config = mkOption {
      type = mkOptionType {
        name = "attribute set or function";
        merge = const (map (x: x.value));
        check = x: isAttrs x || isFunction x;
      };
      default = {};
    };
  };

  config = let
    nixosConfig = config;
    makeHM = name: _user: let
      user = cconfig.users.users.${name};
    in ({
      config,
      options,
      pkgs,
      ...
    }:
      recursiveUpdate {
        _module.args = {
          inherit nixosConfig user;
        };

        home.username = "${user}";
        home.homeDirectory = "/home/${user}";

        imports =
          if nixosConfig.nix-relic.home-manager.useHostNameUserNameHomePath
          then
            nixosConfig.nix-relic.home-manager.config
            ++ [
              ./${nixosConfig.networking.hostName}/users/${user}/home.nix
            ]
          else nixosConfig.nix-relic.home-manager.config;
      }
      user.home-config);
  in {
    home-manager.users = mapAttrs makeHM config.nix-relic.users.users;
  };
}
