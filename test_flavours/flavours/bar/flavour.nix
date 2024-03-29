let
  name = "bar";
  src = ./.;
  driver = src + "/driver.py";
  description = "bar driver";
in
{
  inherit name driver description;
  compose = { pkgs ? import <nixpkgs> {}, ... }:

  pkgs.writeTextFile {
    name = "compose-info.json";
    text = builtins.toJSON({
      inherit driver src;
      flavour = name;
    });
  };
}
