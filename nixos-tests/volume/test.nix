{ ... }:

{
  name = "minimal_test";
  skipLint = true;

  nodes.server = ./server.nix;

  testScript = ''
    start_all()
    server.wait_for_unit("multi-user.target")
    print(server.execute("cat /srv/test.nix")[1])
    (status, output) = server.execute("hello")
    assert("Hello, world!\n" == output)
  '';
}
