{ pkgs, lib, ... }:

let
  common_nixos_tests = {
    boot.postBootCommands = ''
      ln -s ${./..} /srv
    '';
  };

  service_common =
    (import ./services/services_common.nix { inherit pkgs lib; });

in {
  name = "oar";
  skipLint = true;

  nodes.server = { ... }:
    (import ./services/services_server.nix { inherit pkgs lib; })
    // common_nixos_tests;

  nodes.node = { ... }:
    (import ./services/services_node.nix { inherit pkgs lib; })
    // common_nixos_tests;

  nodes.frontend = { ... }:
    (import ./services/services_frontend.nix { inherit pkgs lib; })
    // common_nixos_tests;

  testScript = ''
    start_all()
  '';
}
