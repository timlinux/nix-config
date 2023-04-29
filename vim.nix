{ pkgs, ... }:
{
  programs.vim.defaultEditor = true;

  environment.systemPackages = with pkgs; [
    ((vim_configurable.override { }).customize {
      name = "vim";
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [ 
		vim-nix 
		YouCompleteMe
		nerdtree
		airline
	]; # load plugins on startup
      };
      vimrcConfig.customRC = ''
        " custom
        " vimrc
        " 
 	set nu
	set paste
        " Type z= on a highlighted word to get correction list
        set spell spelllang=en
        " Enable highlight of lua, python and ruby in vimscript.
        let g:vimsyn_embed= "lPr"

        " Activates syntax highlighting, but keeping current color settings. From the
        " documentation: "If you want Vim to overrule your settings with the
        " defaults, use ':syntax on'".
        syntax enable
        
        " Start NERDTree when Vim is started without file arguments.
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
      '';
    })
  ];
}

