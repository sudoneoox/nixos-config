{pkgs, ...}:
{
	programs = {
	bat.enable = true;
	zsh = {
	enable = true;
	history = {
	append = true;
	share = true;

	};
	
	};
	};
}
