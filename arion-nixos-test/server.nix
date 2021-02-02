{ pkgs ? import <nixpkgs> {} , isArion ? false,  ... }:

if isArion then {
  nixos.useSystemd = true;
  nixos.configuration = (import ./service.nix { }) // { boot.tmpOnTmpfs = true; };
  service.useHostStore = true;
  service.ports = [
	"8000:80" # host:container
  ];
  } else
	 (import ./service.nix { }  // { environment.systemPackages = [ pkgs.curl ]; })
