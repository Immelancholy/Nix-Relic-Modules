{
  nix-relic-modules = final: _prev: {
    nix-relic-modules = import ../packages final.pkgs;
  };
}
