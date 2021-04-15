{ pkgs ? import ./arion-pkgs.nix, lib, ... }:

let
  common_arion = {
    service.volumes = [ "${builtins.getEnv "PWD"}/.:/srv" ];
    service.capabilities = { SYS_ADMIN = true; }; # for nfs
    service.useHostStore = true;

    nixos.useSystemd = true;
    nixos.runWrappersUnsafe = true;
  };

  nodes = (import ./test.nix { inherit pkgs lib; }).nodes;

in {
  config.services = builtins.mapAttrs (node_name: set:
    lib.recursiveUpdate {
      nixos.configuration = set;
      service.hostname = node_name;
    } common_arion) nodes;
}
