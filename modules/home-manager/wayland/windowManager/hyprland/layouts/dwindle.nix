{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.wayland.windowManager.hyprland.layout.dwindle;
in {
  options.wayland.windowManager.hyprland.layout.dwindle = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''Use Hy3 tyling style'';
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      settings = {
        general = {
          layout = "dwindle";
        };
        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };
        bind =
          [
            "$mod, Z, togglegroup"
            "$mods, 0, movetoworkspacesilent, 10"
            "$mods, Q, killactive"
            "$mods, X, movetoworkspacesilent, special"
            "Alt+Shift, Return, fullscreen, 1"
          ]
          ++ (
            # workspaces
            # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
            builtins.concatLists (builtins.genList (
                i: let
                  ws = i + 1;
                in [
                  "$mods, code:1${toString i}, movetoworkspacesilent, ${toString ws}"
                ]
              )
              9)
          );
      };
      extraConfig = ''
        bind = $mod, A, submap, manage
        submap = manage
        bind = Alt, Return, fullscreen, 1
        bind = Alt+Shift, Return, fullscreen
        bind = , W, togglefloating
        bind = , H, movefocus, l
        bind = , J, movefocus, d
        bind = , K, movefocus, u
        bind = , L, movefocus, r
        bind = , Left, movefocus, l
        bind = , Down, movefocus, d
        bind = , Up, movefocus, u
        bind = , Right, movefocus, r
        bind = , P, pin, active
        bindm = $mod, mouse:272, movewindow
        bindm = $mod, mouse:273, resizewindow

        bind = $mod, Right, movetoworkspace, r+1
        bind = $mod, Left, movetoworkspace, r-1
        bind = $mod, Down, movetoworkspace, empty
        bind = $mod, L, movetoworkspace, r+1
        bind = $mod, H, movetoworkspace, r-1
        bind = $mod, J, movetoworkspace, empty
        bind = $mod, Right, workspace, r+1
        bind = $mod, Left, workspace, r-1
        bind = $mod, Down, workspace, empty
        bind = $mod, L, workspace, r+1
        bind = $mod, H, workspace, r-1
        bind = $mod, J, workspace, empty

        bind = Ctrl, H, changegroupactive, b
        bind = Ctrl, L, changegroupactive, f
        bind = Ctrl, Right, changegroupactive, b
        bind = Ctrl, Left, changegroupactive, f

        bind = Shift, H, movewindow, l
        bind = Shift, J, movewindow, d
        bind = Shift, K, movewindow, u
        bind = Shift, L, movewindow, r
        bind = Shift, Right, movewindow, r
        bind = Shift, Down, movewindow, d
        bind = Shift, Up, movewindow, u
        bind = Shift, Left, movewindow, l
        bind = , mouse_up, workspace, e+1
        bind = , mouse_down, workspace, e-1
        bind = $mod, mouse_up, workspace, r+1
        bind = $mod, mouse_down, workspace, r-1

        bind = Shift, R, submap, resize
        submap = resize
        binde = , Right, resizeactive, 30 0
        binde = , Left, resizeactive, 30 0
        binde = , Left, moveactive, -30 0
        binde = , Up, resizeactive, 0 30
        binde = , Up, moveactive, 0 -30
        binde = , Down, resizeactive, 0 30

        binde = , L, resizeactive, 30 0
        binde = , H, resizeactive, 30 0
        binde = , H, moveactive, -30 0
        binde = , K, resizeactive, 0 30
        binde = , K, moveactive, 0 -30
        binde = , J, resizeactive, 0 30

        binde = Shift, Right, resizeactive, -30 0
        binde = Shift, Right, moveactive, 30 0
        binde = Shift, Left, resizeactive, -30 0
        binde = Shift, Up, resizeactive, 0 -30
        binde = Shift, Down, resizeactive, 0 -30
        binde = Shift, Down, moveactive, 0 30

        binde = Shift, L, resizeactive, -30 0
        binde = Shift, L, moveactive, 30 0
        binde = Shift, H, resizeactive, -30 0
        binde = Shift, K, resizeactive, 0 -30
        binde = Shift, J, resizeactive, 0 -30
        binde = Shift, J, moveactive, 0 30
        bind = , R, submap, manage
        bind = , escape, submap, manage
        submap = manage

        bind = , R, submap, resizeTiled
        submap = resizeTiled
        binde = , Left, resizeactive, 1 0
        binde = , Right, resizeactive, -1 0
        binde = , Up, resizeactive, 0 -1
        binde = , Down, resizeactive, 0 1
        binde = , H, resizeactive, 30 0
        binde = , L, resizeactive, -30 0
        binde = , K, resizeactive, 0 -30
        binde = , J, resizeactive, 0 30
        bind = , R, submap, manage
        bind = , escape, submap, manage
        submap = manage

        bind = , M, submap, move
        submap = move
        binde = , Left, moveactive, 10 0
        binde = , Right, moveactive, -10 0
        binde = , Up, moveactive, 0 -10
        binde = , Down, moveactive, 0 10
        binde = , H, moveactive, 30 0
        binde = , L, moveactive, -30 0
        binde = , K, moveactive, 0 -30
        binde = , J, moveactive, 0 30
        bind = , M, submap, manage
        bind = , escape, submap, manage
        submap = manage
        bind = , escape, submap, reset

        bind = $mod, A, submap, reset
        submap = reset
      '';
    };
  };
}
