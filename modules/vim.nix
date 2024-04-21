{ pkgs, ... }:
{
  programs.vim.defaultEditor = true;

  environment.systemPackages = with pkgs; [
    alejandra # nix code formatter do :%!alejandra -qq
    ((vim_configurable.override { }).customize {
      name = "vim";
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [ 
		vim-nix 
		YouCompleteMe
		nerdtree
		airline
 		vim-lastplace
                colorizer
	]; # load plugins on startup
      };
      vimrcConfig.customRC = ''
        " custom
        " vimrc
        " 
 	set nu
	set paste
        " Type z= on a highlighted word to get correction list
        set spell spelllang=en_gb
	"in vim you can do
        ":set spell spelllang=pt_pt
        "to switch to portuguese and it will automatically prompt you
	"to download the pt aspell files....
        hi clear SpellBad
        hi SpellBad cterm=underline
        " Set style for gVim
        hi SpellBad gui=undercurl
        " Enable highlight of lua, python and ruby in vimscript.
        let g:vimsyn_embed= "lPr"

        " Activates syntax highlighting, but keeping current color settings. From the
        " documentation: "If you want Vim to overrule your settings with the
        " defaults, use ':syntax on'".
        syntax enable
        
        " Start NERDTree when Vim is started without file arguments.
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
        " Make backspace work
        set backspace=indent,eol,start 

	" Next group of entries taken from the excellent article at:
	" https://realpython.com/vim-and-python-a-match-made-in-heaven/
        " split navigations
        " Remaps moving around splits to match the movement keys
        " 
        "    Ctrl+J move to the split below
    	"    Ctrl+K move to the split above
	"    Ctrl+L move to the split to the right
    	"    Ctrl+H move to the split to the left
        " 
	nnoremap <C-J> <C-W><C-J>
	nnoremap <C-K> <C-W><C-K>
	nnoremap <C-L> <C-W><C-L>
	nnoremap <C-H> <C-W><C-H>

        " PEP8 Indentation
	au BufNewFile,BufRead *.py
	    \ set tabstop=4
	    \ set softtabstop=4
	    \ set shiftwidth=4
	    \ set textwidth=79
	    \ set expandtab
	    \ set autoindent
	    \ set fileformat=unix

	" Nice indents for html, js, css etc
	au BufNewFile,BufRead *.js, *.html, *.css
	    \ set tabstop=2
	    \ set softtabstop=2
	    \ set shiftwidth=2

	set encoding=utf-8
    
	" Cut and paste from the system keyboard
	set clipboard=unnamed
 
        " Shortcut to format a .nix file using alejandra
        " Do this to format: :%!alejandra -qq
        :nnoremap <C-=> :%!alejandra -qq<CR>
      '';
    })
  ];
}

