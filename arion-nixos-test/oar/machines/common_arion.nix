{ pkgs, lib, ... }:

{
  service.volumes = [ "${builtins.getEnv "PWD"}/.:/srv" ];
  service.capabilities = { SYS_ADMIN = true; }; # for nfs
  service.useHostStore = true;
  
  nixos.useSystemd = true;
  nixos.runWrappersUnsafe = true;
}
