{ pkgs ? import ./arion-pkgs.nix, lib, isArion ? false, ... }:

lib.recursiveUpdate (import ./services_common.nix { inherit pkgs lib isArion; }) {
  services.oar.server.enable = true;
  services.oar.dbserver.enable = true;
  environment.etc."oar/api-users" = {
    mode = "0644";
    text = ''
      user1:$apr1$yWaXLHPA$CeVYWXBqpPdN78e5FvbY3/
      user2:$apr1$qMikYseG$VL8nyeSSmxXNe3YDOiCwr1
    '';
  };
}
