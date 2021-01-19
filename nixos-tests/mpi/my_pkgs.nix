let
   nixpkgs = import <nixpkgs> {};
in with nixpkgs;
{
   mpi_hello = import ./mpi_hello/default.nix;
   inherit mkShell mkDerivation nixosTest;
}
