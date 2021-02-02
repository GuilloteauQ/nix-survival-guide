{ pkgs ? import <nixpkgs> { }, lib, isArion ? false, ... }:

lib.recursiveUpdate (import ./services_common.nix { inherit pkgs lib isArion; }) {
  services.oar.server.enable = true;
  services.oar.dbserver.enable = true;
}
