{ pkgs, ... }:

{
   boot.postBootCommands = ''
       ln -s ${./.} /srv
    '';
   environment.systemPackages = with pkgs; [
     hello
   ];
}
