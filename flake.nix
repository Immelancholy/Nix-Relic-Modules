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
        playerVolMPD = pkgs.callPackage ./Packages/playerVolMPD.nix {
          inherit system;
        };
        playerVolMpris = pkgs.callPackage ./Packages/playerVolMpris.nix {
          inherit system;
        };
        playerVolDefault_Sink = pkgs.callPackage ./Packages/playerVolDefault_Sink.nix {
          inherit system;
        };
      }
    );
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

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
