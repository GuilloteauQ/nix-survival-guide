{ pkgs, lib, isArion ? false, ... }:

let
  common_arion = (import ./common_arion.nix { inherit pkgs lib; });
  common_nixos_tests = (import ./common_nixos_tests.nix { inherit pkgs lib; });
in
  if isArion then
  lib.recursiveUpdate common_arion {
    service.hostname="node";
    nixos.configuration = (import ../services/services_node.nix { inherit pkgs lib isArion; });
  }
else (import ../services/services_node.nix { inherit pkgs lib isArion; }) // common_nixos_tests

