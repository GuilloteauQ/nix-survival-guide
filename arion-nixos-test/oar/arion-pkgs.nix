# Instead of pinning Nixpkgs, we can opt to use the one in NIX_PATH
import <nixpkgs> {
  #overlays = [ (import /home/auguste/dev/nur-kapack/overlays/overlay-dev.nix) ];
  config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
      repoOverrides = {
        #kapack = import /home/auguste/dev/nur-kapack {};
        kapack = import (pkgs.fetchgit {
           url = https://github.com/oar-team/nur-kapack;
           rev = "521a345c64428a8fc7301b792987cda453074c57";
           sha256 = "0dw3w3wq5c35hhb5cnhb36bcnp5dsc3brfvx92pa9f9hv1qxwx3d";
        }) {};
      };
    };
  };
}
