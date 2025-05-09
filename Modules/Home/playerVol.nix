self: {
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  inherit (pkgs.stdenv.hostPlatform) system;
  cfg = config.player;
  playerVolMPD = self.packages.${system}.playerVolMPD;
  playerVolMpris = self.packages.${system}.playerVolMpris;
  playerVolDefault_Sink = self.packages.${system}.playerVolDefault_Sink;
  hyprgame = self.packages.${system}.hyprgame;
in {
  options.player = {
    name = mkOption {
      type = types.str;
      default = "mpd";
      description = "Mpris name of the music player";
    };
    cmd = mkOption {
      type = types.str;
      default = ''uwsm app -- kitty --class "mpd" --session=mpd.session'';
      description = "Launch command for music player";
    };
    class = mkOption {
      type = types.str;
      default = ''mpd'';
      description = "Class of music player";
    };
    scriptUseDefaultSink = mkOption {
      type = types.bool;
      default = false;
      description = "Make the volume control script use the default sink";
    };
  };
  config = mkMerge [
    {
      wayland.windowManager.hyprland.settings = {
        "$player" = "${cfg.name}";
        exec-once = [
          ''[workspace 1 silent; float; size 858 559; move 640 40] ${cfg.cmd}''
        ];
        bind = [
          ''$mods, U, exec, [workspace 1 silent; float; size 858 559; move 640 40] ${cfg.cmd}''
        ];
      };
    }
    (mkIf (config.player.name == "mpd" && ! config.player.scriptUseDefaultSink) {
      home.packages = [
        playerVolMPD
      ];
    })
    (mkIf (config.player.name != "mpd" && ! config.player.scriptUseDefaultSink) {
      home.packages = [
        (playerVolMpris.override {
          player = cfg.name;
        })
      ];
    })
    (mkIf config.player.scriptUseDefaultSink {
      home.packages = [
        playerVolDefault_Sink
      ];
    })
  ];
}
