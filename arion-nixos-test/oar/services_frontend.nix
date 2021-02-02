{ pkgs ? import <nixpkgs> { }, lib, isArion ? false, ... }:

lib.recursiveUpdate (import ./services_common.nix { inherit pkgs lib isArion; }) {
  services.oar.client.enable = true;
}
