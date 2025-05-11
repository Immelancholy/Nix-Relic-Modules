{
  description = "Modules and packages for my Nix-Relic template.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
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

    homeManagerModules.default = import ./modules/home-manager;
  };
}
