{ pkgs ? import <nixpkgs> { }, lib, isArion ? false, ... }:

lib.recursiveUpdate (import ./services_common.nix { inherit pkgs lib isArion; }) {
  services.oar.node = {
    enable = true;
    register = {
      enable = true;
      extraCommand = "/srv/common/prepare_oar_cgroup.sh init 0";
    };
  };
}
