{ pkgs, lib, isArion ? false, ... }:

let
  common = (import ./common.nix { inherit pkgs lib; });
in
  if isArion then
  lib.recursiveUpdate common {
    service.hostname="node";
    nixos.configuration = (import ../services/services_node.nix { inherit pkgs lib isArion; });
  }
else (import ../services/services_node.nix { inherit pkgs lib isArion; })

