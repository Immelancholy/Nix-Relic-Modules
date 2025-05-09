{
  description = "A kitty terminal mpd album art viewer";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    inherit nixpkgs;
    systems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    packages = forAllSystems (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        brightness = pkgs.callPackage ./Packages/brightness.nix {
          inherit system;
        };
        btop = pkgs.callPackage ./Packages/btop.nix {
          inherit system;
        };
        cava = pkgs.callPackage ./Packages/cava.nix {
          inherit system;
        };
        checkshell = pkgs.callPackage ./Packages/checkshell.nix {
          inherit system;
        };
        cliphist = pkgs.callPackage ./Packages/cliphist.nix {
          inherit system;
        };
        colortrans = pkgs.callPackage ./Packages/colortrans.nix {
          inherit system;
        };
        mpdchck = pkgs.callPackage ./Packages/mpdchck.nix {
          inherit system;
        };
        neo = pkgs.callPackage ./Packages/neo.nix {
          inherit system;
        };
        playerVolMPD = pkgs.callPackage ./Packages/playerVolMPD.nix {
          inherit system;
        };
        playerVolMpris = pkgs.callPackage ./Packages/playerVolMpris.nix {
          inherit system;
        };
        playerVolDefault_Sink = pkgs.callPackage ./Packages/playerVolDefault_Sink.nix {
          inherit system;
        };
        rofi-power-menu = pkgs.callPackage ./Packages/rofi-power-menu.nix {
          inherit system;
        };
        ss = pkgs.callPackage ./Packages/ss.nix {
          inherit system;
        };
        tmux_dev = pkgs.callPackage ./Packages/tmux_dev.nix {
          inherit system;
        };
        tmux_nix = pkgs.callPackage ./Packages/tmux_nix.nix {
          inherit system;
        };
        tmux_notes = pkgs.callPackage ./Packages/tmux_notes.nix {
          inherit system;
        };
        toggle-mute = pkgs.callPackage ./Packages/toggle-mute.nix {
          inherit system;
        };
        waycava = pkgs.callPackage ./Packages/waycava.nix {
          inherit system;
        };
      }
    );
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    nixosModules = rec {
      all = ./Modules/System;
      default = all;
    };

    homeManagerModules = rec {
      all = import ./Modules/Home;
      default = all;
      programs = {
        playerVol = import ./Modules/Home/programs/playerVol.nix;
        nixvim = import ./Modules/Home/programs/nixvim;
        zen = import ./Modules/Home/programs/zen;
        default = import ./Modules/Home/programs;
      };
      catppuccin = import ./Modules/Home/catppuccin;
      stylix = import ./Modules/Home/stylix;
      hyprlandLayouts = import ./Modules/Home/wayland/windowManager/hyprland/layouts;
      hyprLiveWallpaper = import ./Modules/Home/wayland/windowManager/hyprland/useLiveWallpaper.nix;
      hyprPlugins = import ./Modules/Home/wayland/windowManager/hyprland/plugins;
    };
  };
}
