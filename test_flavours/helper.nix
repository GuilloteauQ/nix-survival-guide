{
  getFlavoursFile = rootPath:
    let
      dir = builtins.readDir rootPath;
    in
      builtins.map (flavourFolder: (toString rootPath) + "/" + flavourFolder + "/flavour.nix") (builtins.attrNames dir)
    ;

  generateJSONFlavours = { rootPath, pkgs }:
    let
      dir = builtins.readDir rootPath;
    in

    pkgs.writeTextFile {
      name = "flavours.json";
      text = builtins.toJSON (
              builtins.listToAttrs (
                builtins.map
                  (flavourFolder: {
                    name = flavourFolder;
                    value = (import (./. + ("/" + "flavours/" + flavourFolder + "/flavour.nix"))).description;
                  })
                  (builtins.attrNames dir)
            )
            );
          };

    


}
