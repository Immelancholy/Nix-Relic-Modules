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
    inherit (self) outputs;
    systems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    packages = forAllSystems (system: import ./packages nixpkgs.legacyPackages.${system});

    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    overlays = import ./overlays;

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
