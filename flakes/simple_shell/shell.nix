{pkgs, ... }:

pkgs.mkShell {
	name = "Rggplot";
	buildInputs = with pkgs; [
		R
		rPackages.ggplot2
		rPackages.dplyr
	];
	shellHook = ''
      PS1="\n\033[1;34m\[(dev)[\u@\h:\w]\$\[\033[0m\] "

      R --version
	'';
}
