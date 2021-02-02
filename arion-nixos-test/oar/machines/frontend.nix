{ pkgs, lib, isArion ? false, ... }:

let
  common = (import ./common.nix { inherit pkgs lib; });
in
  if isArion then
  lib.recursiveUpdate common {
    service.hostname="frontend";
    nixos.configuration = (import ../services/services_frontend.nix { inherit pkgs lib isArion; });
  }
else (import ../services/services_frontend.nix { inherit pkgs lib isArion; })

