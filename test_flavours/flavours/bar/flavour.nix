let
  name = "bar";
  driver = ./driver.py;
  description = "bar driver";
in
{
  inherit name driver description;
  compose = { pkgs ? import <nixpkgs> {}, ... }:

  pkgs.writeTextFile {
    name = "compose-info.json";
    text = builtins.toJSON({
      inherit name driver;
    });
  };
}
