{
  config,
  lib,
  ...
}:
with lib; {
  options.nix-relic.home-manager.config = mkOption {
    description = ''
      Global Home Manager configuration.
      It can be specified the same way as in `home-manager.users.<name>`
      and it applies to all regular users (`isNormalUser` attribute is set).

      There are some optional argument available to the global home manager
      modules, namely:

      - *user*: The current user who the configuration is generated for\
      - *nixosConfig*: The global nixos configuration\

      Note that all `profiles` set in the global configuration is inherited
      by home manager and can be explicitly disabled.
    '';
    type = mkOptionType {
      name = "attribute set or function";
      merge = const (map (x: x.value));
      check = x: isAttrs x || isFunction x;
    };
    default = {};
  };

  config = let
    nixosConfig = config;
    makeHM = name: _user: let
      user = config.users.users.${name};
    in ({
      config,
      options,
      pkgs,
      ...
    }:
      recursiveUpdate
      {
        _module.args = {
          inherit nixosConfig user;
        };
        home.username = "${user}";
        home.homeDirectory = "/home/${user}";
        imports = nixosConfig.nix-relic.home-manager.config;
      }
      user.home-config);
  in {
    home-manager.users = mapAttrs makeHM config.nix-relic.users.users;
  };
}
