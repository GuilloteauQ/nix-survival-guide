{
  description = "A very basic flake";

  outputs = { self, nixpkgs }:
  let
    helper = import ./helper.nix;
    rootPath = ./flavours;
    flavourFiles = helper.getFlavoursFile rootPath;
    pkgs = import nixpkgs { system = "x86_64-linux"; };
    
  in
  {

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.init;

    packages.x86_64-linux = builtins.listToAttrs (builtins.map (flavourFile: let
      flavourSet = import flavourFile;
    in
    {
      name  = flavourSet.name;
      value = flavourSet.compose { inherit pkgs ;};
    })
    flavourFiles) // { init = helper.generateJSONFlavours { inherit rootPath pkgs; };} ;

  };
}
