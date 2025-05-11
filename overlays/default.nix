{
  nix-relic-modules = final: _prev: {
    nrm = import ../packages final.pkgs;
  };
}
