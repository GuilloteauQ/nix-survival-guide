{ lib, commonArion, nodes, nodeExtraConfig ? { } }:

{
  config.services = builtins.mapAttrs (nodeName: set:
    lib.recursiveUpdate {
      nixos.configuration = if nodeExtraConfig ? nodeName then
        (lib.recursiveUpdate set nodeExtraConfig.nodeName)
      else
        set;
      service.hostname = nodeName;
    } commonArion) nodes;
}
