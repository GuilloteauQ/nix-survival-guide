{ pkgs ? import <nixpkgs> { } , ... }:


{
  services.nginx.enable = true;
  services.nginx.virtualHosts.localhost.root = "${pkgs.nix.doc}/share/doc/nix/manual";
}
