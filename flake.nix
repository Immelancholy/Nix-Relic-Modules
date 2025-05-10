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
        brightness = pkgs.callPackage ./packages/brightness.nix {};
        btop = pkgs.callPackage ./packages/btop.nix {};
        cava = pkgs.callPackage ./packages/cava.nix {};
        cavaCfg = pkgs.callPackage ./packages/cavaCfg.nix {};
        checkshell = pkgs.callPackage ./packages/checkshell.nix {};
        cliphist = pkgs.callPackage ./packages/cliphist.nix {};
        colortrans = pkgs.callPackage ./packages/colortrans.nix {};
        hyprgame = pkgs.callPackage ./packages/hyprgame.nix {};
        mpdchck = pkgs.callPackage ./packages/mpdchck.nix {};
        neo-color = pkgs.callPackage ./packages/neo-color.nix {};
        neo = pkgs.callPackage ./packages/neo.nix {};
        playerVolMPD = pkgs.callPackage ./packages/playerVolMPD.nix {};
        playerVolMpris = pkgs.callPackage ./packages/playerVolMpris.nix {};
        playerVolDefault_Sink = pkgs.callPackage ./packages/playerVolDefault_Sink.nix {};
        rofi-power-menu = pkgs.callPackage ./packages/rofi-power-menu.nix {};
        ss = pkgs.callPackage ./packages/ss.nix {};
        tmux_dev = pkgs.callPackage ./packages/tmux_dev.nix {};
        tmux_nix = pkgs.callPackage ./packages/tmux_nix.nix {};
        tmux_notes = pkgs.callPackage ./packages/tmux_notes.nix {};
        toggle-mute = pkgs.callPackage ./packages/toggle-mute.nix {};
        waycava = pkgs.callPackage ./packages/waycava.nix {};
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
