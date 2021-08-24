
{
  name = "bar";
  compose = { pkgs ? import <nixpkgs> {}, ... }:

  pkgs.writeTextFile {
    name = "compose-info.json";
    text = builtins.toJSON({
      name = "bar";
    });
  };
}
