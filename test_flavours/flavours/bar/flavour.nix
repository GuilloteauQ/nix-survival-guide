let
  name = "bar";
  driver = ./driver.py;
in
{
  inherit name driver;
  compose = { pkgs ? import <nixpkgs> {}, ... }:

  pkgs.writeTextFile {
    name = "compose-info.json";
    text = builtins.toJSON({
      inherit name driver;
    });
  };
}
