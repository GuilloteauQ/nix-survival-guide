let
  src = builtins.fetchGit {
    url = "https://github.com/GuilloteauQ/test-flavour.git";
    rev = "5998f33b99e90e314a149fb092529950b383bf37";
  };
in
  import (src + "/flavour.nix")
