{ pkgs, lib, isArion ? false, ... }:

let
  common = (import ./common.nix { inherit pkgs lib; });
in
  if isArion then
  lib.recursiveUpdate common {
    service.hostname="server";
    nixos.configuration = (import ./services_server.nix { inherit pkgs lib isArion; });
  }
else (import ./services_server.nix { inherit pkgs lib isArion; })

