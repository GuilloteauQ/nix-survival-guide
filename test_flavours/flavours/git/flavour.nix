let
  name = "test-git";
  src = builtins.fetchGit {
    url = "https://github.com/GuilloteauQ/test-flavour.git";
    rev = "5998f33b99e90e314a149fb092529950b383bf37";
  };
  driver = src + "/driver.py";
  description = "test git driver";
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
