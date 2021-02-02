{ ... }:

{
  name = "test";
  skipLint = true;

  nodes.webserver = { ... }:
  (import ./server.nix { isArion = false; });

  testScript = ''
start_all()
webserver.wait_for_unit("multi-user.target")
webserver.wait_for_unit("nginx")
webserver.wait_for_open_port(80)
(status_curl, output_curl) = webserver.execute("curl -s localhost:80 -o out.html")
assert (status_curl == 0), "CURL FAILED"
(status_saved, output_saved) = webserver.execute("cat ${./nix_help.html}")
assert (status_saved == 0), "CAT FAILED"
(status_diff, output_diff) = webserver.execute("diff out.html ${./nix_help.html}")
assert(status_diff == 0 and output_diff == "")
'';
}
