{ pkgs ? import ../arion-pkgs.nix, lib, isArion ? false, ... }:

let

  # mypkgs = import ../arion-pkgs.nix;

inherit (import ../common/ssh-keys.nix pkgs) snakeOilPrivateKey snakeOilPublicKey;

in
{
  networking.firewall.enable = false;
  boot.tmpOnTmpfs = true;

  networking.firewall.allowedTCPPorts = [ 22 ];

  users.users.user1 = {isNormalUser = true;};
  users.users.user2 = {isNormalUser = true;};
  
  # oar common stuffs
  imports = lib.attrValues pkgs.nur.repos.kapack.modules;
  # imports = lib.attrValues mypkgs.nur.repos.kapack.modules;
  
  # oar user's key files
  environment.etc."privkey.snakeoil" = { mode = "0600"; source = snakeOilPrivateKey; };
  environment.etc."pubkey.snakeoil" = { mode = "0600"; source = snakeOilPublicKey; };

  services.oar = {
    # oar db passwords
    database = {
      host = "server";
      # passwordFile = if isArion then "/srv/common/oar-dbpassword" else "${../common/oar-dbpassword}";
      passwordFile = "/srv/common/oar-dbpassword";
    };
    server.host = "server";
    privateKeyFile = "/etc/privkey.snakeoil";
    publicKeyFile = "/etc/pubkey.snakeoil";
  };  
}
