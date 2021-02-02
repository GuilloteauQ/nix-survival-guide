{ pkgs ? import ./arion-pkgs.nix  }: {
  test = pkgs.nixosTest ./test.nix;
}
