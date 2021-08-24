{
  getFlavoursFile = rootPath:
    let
      dir = builtins.readDir rootPath;
    in
      builtins.map (flavourFolder: (toString rootPath) + "/" + flavourFolder + "/flavour.nix") (builtins.attrNames dir)
    ;


}
