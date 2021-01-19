# { pkgs ? import ./my_pkgs.nix }: {
{ ... } :
let 
  pkgs = import ./my_pkgs.nix;
in
{
  test = pkgs.nixosTest ./test.nix;
}

