{ pkgs, lib, ... }:

{
  name = "oar";
  skipLint = true;

  nodes.server = { ... }:
  (import ./server.nix { inherit pkgs lib; isArion = false; });

  nodes.node = { ... }:
  (import ./node.nix { inherit pkgs lib; isArion = false; });

  nodes.frontend = { ... }:
  (import ./frontend.nix { inherit pkgs lib; isArion = false; });

  testScript = ''
start_all()
frontend.wait_for_unit("multi-user.target")
# node.wait_for_unit("multi-user.target")
server.wait_for_unit("multi-user.target")
print(frontend.execute("oarnodes"))
'';
}
