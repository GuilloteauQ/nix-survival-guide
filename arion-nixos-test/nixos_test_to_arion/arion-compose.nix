{ pkgs ? import ./arion-pkgs.nix, lib, ... }:

let
  commonArion = {
    service.volumes = [ "${builtins.getEnv "PWD"}/.:/srv" ];
    service.capabilities = { SYS_ADMIN = true; }; # for nfs
    service.useHostStore = true;

    nixos.useSystemd = true;
    nixos.runWrappersUnsafe = true;
  };

  nodeExtraConfig = {
    server = {};
  };

  nodes = (import ./test.nix { inherit pkgs lib; }).nodes;

  # import of the function generating Arion expression
  toArion = import ./to_arion.nix;

in
  toArion {inherit lib commonArion nodes nodeExtraConfig;}
