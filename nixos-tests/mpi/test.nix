{ ... }:

{
  name = "mpi_test";
  skipLint = true;


  nodes.server = { pkgs, ... }:
  {
    services.openssh.enable = true;
services.openssh.permitRootLogin = "yes";

    services.openssh.openFirewall = true;
	networking = {
		firewall.enable = false;
 		# interfaces.eth1.ipv4.addresses = [{
        # 	address = "192.168.1.1";
        # 	prefixLength = 28;
      	# }];
	};
    environment.systemPackages = [
      (import ./mpi_hello/default.nix)
    ];
  };

  nodes.node =  { pkgs, ... }:
  {
    services.openssh.enable = true;
    services.openssh.openFirewall = true;

	networking = {
		firewall.enable = false;
 		# interfaces.eth1.ipv4.addresses = [{
        # 	address = "192.168.1.2";
        # 	prefixLength = 28;
      	# }];
	};

    environment.systemPackages = [
      (import ./mpi_hello/default.nix)
    ];
  };

  testScript = ''
start_all()
server.wait_for_open_port(22)
node.wait_for_open_port(22)
node.succeed("ping -c 1 server")
server.succeed("ping -c 1 node")
server.succeed("scp root@node:${./machine_file} plop")

# (s, o) = server.execute("cat ${./machine_file}")
(s, o) = server.execute("cat plop")
print(o)
print(server.execute("which hello"))
# (status, output) = server.execute("hello --allow-run-as-root --machinefile ${./machine_file}")
(status, output) = server.execute("hello --allow-run-as-root")
print(output)
assert("Hello from node 0 !\n" == output)
  '';
}

