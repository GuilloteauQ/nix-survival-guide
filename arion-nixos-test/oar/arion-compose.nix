{ pkgs ? import ./arion-pkgs.nix , lib,... }:

{
  config.services = {

    frontend = (import ./machines/frontend.nix { inherit pkgs lib; isArion = true; });

    server = (import ./machines/server.nix { inherit pkgs lib; isArion = true; });

    node = (import ./machines/node.nix { inherit pkgs lib; isArion = true; });
  };

}
