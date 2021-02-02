{ pkgs, ... }:
{
  config.services = {

    webserver = import ./server.nix { isArion = true; };

  };
}
