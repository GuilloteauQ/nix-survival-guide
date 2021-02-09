# import /home/quentin/these/nix/nixpkgs/nixos/tests/make-test-python.nix ({ pkgs , lib, ... }:
# import /home/quentin/these/nix/nixpkgs/nixos/tests/make-test-python.nix
{ pkgs, lib, ... }:

{
  name = "oar";
  skipLint = true;

  nodes.server = { ... }:
  (import ./machines/server.nix { inherit pkgs lib; isArion = false; });
  # (import ./machines/server.nix { isArion = false; });

  nodes.node = { ... }:
  (import ./machines/node.nix { inherit pkgs lib; isArion = false; });
  # (import ./machines/node.nix { isArion = false; });

  nodes.frontend = { ... }:
  (import ./machines/frontend.nix { inherit pkgs lib; isArion = false; });
  # (import ./machines/frontend.nix { isArion = false; });

  testScript = ''
start_all()
frontend.wait_for_unit("multi-user.target")
# node.wait_for_unit("multi-user.target")
server.wait_for_unit("multi-user.target")
print(frontend.execute("oarnodes")[1])
print(frontend.execute("ls /srv")[1])
# print(server.execute("ping -c 1 frontend"))
# print(server.execute("ping -c 1 node"))
# print(frontend.execute("ping -c 1 node"))
print(node.execute("systemctl status oar-node-register")[1])
print("Node:    \t", node.execute("cat /proc/loadavg"))
print("Server:  \t", server.execute("cat /proc/loadavg"))
print("Frontend:\t", frontend.execute("cat /proc/loadavg"))
print(node.execute("cat /srv/plop.sh")[1])
print(frontend.execute("/run/wrappers/bin/oarsub \"sh /srv/plop.sh\"")[1])
# print(frontend.execute("scp node:/root/plop /root/plop"))
# frontend.wait_for_file("/root/plop")
'';
# })
}
