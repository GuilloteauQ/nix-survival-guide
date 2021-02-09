{ pkgs, lib, ... }:

{
  boot.postBootCommands = ''
    ln -s ${./..} /srv
  '';
}
