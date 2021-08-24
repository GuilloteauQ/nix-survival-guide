let
  name = "foo";
  driver = ./driver.py;
  description = "foo driver";
in
{
  inherit name driver description;
  compose = { pkgs ? import <nixpkgs> {}, ... }:

  pkgs.writeTextFile {
    name = "compose-info.json";
    text = builtins.toJSON({
      inherit driver;
      flavour = name;
    });
  };
}
