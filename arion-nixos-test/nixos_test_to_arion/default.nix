# { pkgs ? import ./arion-pkgs.nix  }: {
# import ./arion-pkgs; 
let
  pkgs = import ./arion-pkgs.nix;
in
{
  test = pkgs.nixosTest ./test.nix;
}
