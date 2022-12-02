{ pkgs, ... }:

{
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
}
