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

  # import of the function generating Arion expression
  to_arion = import ./to_arion.nix;

in 
  to_arion {inherit lib common_arion nodes;}
