{pkgs, ...}:

pkgs.mkShell {
	name = "shell";
	buildInputs = with pkgs; [
	  python3	
	];
	shellHook = ''
		
	'';
}
