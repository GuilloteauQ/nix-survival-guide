{ pkgs, lib, ... }:

{
  service.volumes = [ "${builtins.getEnv "PWD"}/.:/srv" ];
  service.useHostStore = true;
  
  nixos.useSystemd = true;
  nixos.runWrappersUnsafe = true;
}
