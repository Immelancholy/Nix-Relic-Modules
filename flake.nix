{
  description = "Modules and packages for my Nix-Relic template.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    overlay = final: prev: {
      nrm = import ./packages final.pkgs;
      stable = import self.inputs.nixpkgs-stable {
        system = final.system;
        config.allowUnfree = true;
      };
      nur = self.inputs.nur.overlays.default;
    };
  in {
    packages = forAllSystems (system: import ./packages nixpkgs.legacyPackages.${system});

    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    overlays.default = overlay;

    nixosModules.default = import ./modules/nixos;

    homeManagerModules.default = import ./modules/home-manager;
  };
}
