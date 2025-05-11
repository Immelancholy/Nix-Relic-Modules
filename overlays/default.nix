{outputs}: {
  nix-relic-modules = final: _prev: import outputs.nix-relic-modules.packages.default final.pkgs;
}
