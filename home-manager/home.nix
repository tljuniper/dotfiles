{ config, pkgs, ... }:

{
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  # home.stateVersion = "21.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # ------------------------------------------------------------------

  home.packages = with pkgs; [
    bat
    cachix
    diff-so-fancy
    dos2unix
    rsync
    screen
    fzf
    htop
    jq
    tree
    unzip
  ];

  home.file.".aspell.de_DE.prepl".source = ./aspell.de_DE.prepl;
  home.file.".aspell.de_DE.pws".source = ./aspell.de_DE.pws;
  home.file.".aspell.en.prepl".source = ./aspell.en.prepl;
  home.file.".aspell.en.pws".source = ./aspell.en.pws;

  programs.autojump = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    shellAliases = {
      Grep = "grep -Hirn --color=auto";
      l = "ls -h -CFAl --color=auto";
    };
    sessionVariables = {
      CONDA_DEFAULT_ENV = "";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "copybuffer"
        "copyfile"
        "dirhistory"
        "git"
        "sudo"
        "history"
        "web-search"
      ];
      theme = "af-magic";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      git_branch = {
        symbol = "🌱 ";
      };
      nix_shell = {
        format = "via [❄️ ](bold blue) ";
      };
      sudo = {
        disabled = false;
      };
    };
  };

  programs.git = {
    enable = true;
    aliases = {
      lol = "log --oneline";
      rofl = "log --oneline";
      unstage = "restore --staged";
    };
    extraConfig = {
      pager = {
        branch = false;
      };
      core = {
        editor = "vim";
      };
      init = {
        defaultBranch = "main";
      };
      interactive.diffFilter = "${pkgs.diff-so-fancy}/bin/diff-so-fancy --patch";
      # Push new branch to origin (or default branch) without explicit --set-upstream
      push.autoSetupRemote = true;
    };
  };

  programs.vim = {
    enable = true;
    settings = {
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      ignorecase = true;
      number = true;
      relativenumber = true;
      mouse = "a";
    };
    extraConfig = ''
      set autoindent
      set smartindent
      set showcmd
      set showmatch
      set autowrite
      set ignorecase
      set incsearch
      set ruler
      set so=5
      set modeline
      syntax on
      set clipboard=unnamedplus

      " Used for pasting without breaking the indentation
      set pastetoggle=<F2>

      set hlsearch
      " turn off hlsearch on enter
      nnoremap <CR> :noh<CR><CR>

      set colorcolumn=80,120
      set cursorline
      highlight ColorColumn ctermbg=0
      set textwidth=80

      "Spell checking
      autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en_us
      " autocmd BufRead,BufNewFile *.md setlocal spell spelllang=de_de
      autocmd BufRead,BufNewFile *.tex setlocal spell spelllang=en_us
      " autocmd BufRead,BufNewFile *.tex setlocal spell spelllang=de_de

      " Don't insert two spaces after joining a sentence with 'J' or 'gq'
      set nojoinspaces

      " Formatting options for markdown
      " t --> auto-wrap the text
      " a --> automatically format paragraphs
      " n --> recognize numbered lists
      autocmd FileType *.md set fo=tan

      " Fix 'legacy Snipmate parser is deprecated' warning
      let g:snipMate = { 'snippet_version' : 1 }

      " vim-better-whitespace
      " only autostrip whitespace from lines I've modified
      let g:strip_only_modified_lines=1
      " do not ask me to strip whitespace
      let g:strip_whitespace_confirm=0

      set t_Co=256  " make use of 256 terminal colors

    '';
    plugins = with pkgs.vimPlugins; [
      commentary
      repeat
      vim-snipmate
      vim-snippets
      surround
    ];
  };

  home.stateVersion = "22.05";
}
