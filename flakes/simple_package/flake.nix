{
  description = "hello_nix flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-20.03";

  outputs = { self, nixpkgs }: {

    defaultPackage.x86_64-linux = 
      with import nixpkgs { system = "x86_64-linux"; };
      stdenv.mkDerivation {
        name = "hello_nix_survival";
        src = ./.;
        buildInputs = [
          gcc
        ];
        installPhase = ''
          gcc main.c -o hello_nix
          mkdir -p $out/bin
          mv hello_nix $out/bin
          '';
      };
  };
}
