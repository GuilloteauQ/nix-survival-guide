{ lib, common_arion, nodes }:

{
  config.services = builtins.mapAttrs (node_name: set:
    lib.recursiveUpdate {
      nixos.configuration = set;
      service.hostname = node_name;
    } common_arion) nodes;
}
