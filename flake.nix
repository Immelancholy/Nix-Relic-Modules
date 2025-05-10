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
        brightness = pkgs.callPackage ./packages/brightness.nix {
          inherit system;
        };
        btop = pkgs.callPackage ./packages/btop.nix {
          inherit system;
        };
        cava = pkgs.callPackage ./packages/cava.nix {
          inherit system;
        };
        checkshell = pkgs.callPackage ./packages/checkshell.nix {
          inherit system;
        };
        cliphist = pkgs.callPackage ./packages/cliphist.nix {
          inherit system;
        };
        colortrans = pkgs.callPackage ./packages/colortrans.nix {
          inherit system;
        };
        mpdchck = pkgs.callPackage ./packages/mpdchck.nix {
          inherit system;
        };
        neo = pkgs.callPackage ./packages/neo.nix {
          inherit system;
        };
        playerVolMPD = pkgs.callPackage ./packages/playerVolMPD.nix {
          inherit system;
        };
        playerVolMpris = pkgs.callPackage ./packages/playerVolMpris.nix {
          inherit system;
        };
        playerVolDefault_Sink = pkgs.callPackage ./packages/playerVolDefault_Sink.nix {
          inherit system;
        };
        rofi-power-menu = pkgs.callPackage ./packages/rofi-power-menu.nix {
          inherit system;
        };
        ss = pkgs.callPackage ./packages/ss.nix {
          inherit system;
        };
        tmux_dev = pkgs.callPackage ./packages/tmux_dev.nix {
          inherit system;
        };
        tmux_nix = pkgs.callPackage ./packages/tmux_nix.nix {
          inherit system;
        };
        tmux_notes = pkgs.callPackage ./packages/tmux_notes.nix {
          inherit system;
        };
        toggle-mute = pkgs.callPackage ./packages/toggle-mute.nix {
          inherit system;
        };
        waycava = pkgs.callPackage ./packages/waycava.nix {
          inherit system;
        };
        default = pkgs.callPackages ./packages;
      }
    );
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    nixosModules = rec {
      all = ./modules/nixos;
      default = all;
    };

    homeManagerModules = rec {
      all = import ./modules/home-manager;
      default = all;
      programs = {
        playerVol = import ./modules/home-manager/programs/playerVol.nix;
        nixvim = import ./modules/home-manager/programs/nixvim;
        zen = import ./modules/home-manager/programs/zen;
        default = import ./modules/home-manager/programs;
      };
      catppuccin = import ./modules/home-manager/catppuccin;
      stylix = import ./modules/home-manager/stylix;
      hyprlandLayouts = import ./modules/home-manager/wayland/windowManager/hyprland/layouts;
      hyprLiveWallpaper = import ./modules/home-manager/wayland/windowManager/hyprland/useLiveWallpaper.nix;
      hyprPlugins = import ./modules/home-manager/wayland/windowManager/hyprland/plugins;
    };
  };
}
