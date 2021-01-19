let
  pkgs = import <nixpkgs> {};

  inherit (pkgs) stdenv;

  basic_hello = stdenv.mkDerivation {
    name = "hello_mpi";
    src = ./.;
    buildInputs = with pkgs; [
      gcc
      openmpi
    ];
    buildPhase = ''
      mpicc main.c -o hello_mpi
    '';
    installPhase = ''
      mkdir -p $out/bin
      cp hello_mpi $out/bin
    '';
  };

  nb_nodes = "6";

  mpi_hello = pkgs.writeScriptBin "hello" ''
#!${pkgs.stdenv.shell}
# ${pkgs.openmpi}/bin/mpirun -np ${nb_nodes} $@ ${basic_hello}/bin/hello_mpi
${pkgs.openmpi}/bin/mpirun  $@ ${basic_hello}/bin/hello_mpi
  '';
in

pkgs.symlinkJoin {
  name = "MPIHello";
  paths = [
    mpi_hello
    basic_hello
	pkgs.openmpi
  ];
}
