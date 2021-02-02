{ pkgs, lib,... }:

{
  config.services = {

    frontend = (import ./frontend.nix { inherit pkgs lib; isArion = true; });

    server = (import ./server.nix { inherit pkgs lib; isArion = true; });

    node = (import ./node.nix { inherit pkgs lib; isArion = true; });
  };

}
