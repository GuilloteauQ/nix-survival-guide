{
  description = "A very basic flake";

  outputs = { self, nixpkgs }:
  let
    helper = import ./helper.nix;
    flavourFiles = helper.getFlavoursFile ./flavours;
    pkgs = import nixpkgs { system = "x86_64-linux"; };
  in
  {

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.foo;

    packages.x86_64-linux = builtins.listToAttrs (builtins.map (flavourFile: let
      flavourSet = import flavourFile;
    in
    {
      name  = flavourSet.name;
      value = flavourSet.compose { inherit pkgs ;};
    })
    flavourFiles);

  };
}
