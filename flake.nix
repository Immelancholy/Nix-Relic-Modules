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

    homeManagerModules = {
      default = import ./Modules/Home {inherit self;};
    };
  };
}
