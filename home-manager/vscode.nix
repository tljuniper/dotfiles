{ pkgs, pkgs-unstable, system, inputs, ... }:

# cSpell:disable
{
  home.packages = with pkgs; [
    # Needed by Nix IDE extension
    rnix-lsp
  ];
  programs.vscode = {
    enable = true;
    package = pkgs-unstable.vscode;
    userSettings =
      {
        "cabal-fmt.indent" = 4;
        "diffEditor.renderSideBySide" = false;
        "editor.formatOnSave" = true;
        "editor.formatOnType" = false;
        "editor.renderWhitespace" = "boundary";
        "files.exclude" = {
          "**/.git" = true;
        };
        "files.insertFinalNewline" = true;
        "files.trimFinalNewlines" = true;
        "files.associations" = {
          "*.hs" = "haskell";
        };
        "gitlab.showPipelineUpdateNotifications" = true;
        "haskell.formattingProvider" = "brittany";
        "haskell.serverExecutablePath" = "haskell-language-server";
        "nix.enableLanguageServer" = true;
        "python.formatting.provider" = "black";
        "python.languageServer" = "Pylance";
        "workbench.colorTheme" = "Default Dark+";
        "workbench.iconTheme" = "material-icon-theme";
        "window.title" = "\${rootName}";
        "[haskell]" = {
          "editor.defaultFormatter" = "MaxGabriel.brittany";
        };
        "shfmt.executablePath" = "${pkgs.shfmt}/bin/shfmt";
        "cSpell.enabledLanguageIds" = [
          "git-commit"
          "html"
          "javascript"
          "json"
          "jsonc"
          "latex"
          "markdown"
          "nix"
          "plaintext"
          "python"
          "shellscript"
          "text"
          "yaml"
          "yml"
        ];
        "cSpell.dictionaries" = [ "custom-words" ];
        "cSpell.dictionaryDefinitions" = [
          {
            "name" = "custom-words";
            "path" = "${./cspell-words.txt}";
            "addWords" = true;
          }
        ];
        "terminal.integrated.scrollback" = 100000;
        "update.mode" = "none";
        "nixEnvSelector.nixFile" = "\${workspaceRoot}/shell.nix";
        "cSpell.ignorePaths" = [
          "**/.vscode/**"
        ];
        "vim" = {
          sneak = true;
          # commentary is on by default
          # surround is on by default
          useCtrlKeys = false;
        };
        "peacock.elementAdjustments" = {
          "activityBar" = "none";
          "statusBar" = "none";
          "titleBar" = "none";
        };
        # Make vscode not overwrite existing shell environment
        # We need this for python environments sometimes
        "terminal.integrated.inheritEnv" = false;
      };
    keybindings = [
      {
        key = "ctrl+alt+`";
        command = "workbench.action.toggleMaximizedPanel";
      }
      {
        key = "ctrl+b";
        command = "-extension.vim_ctrl+b";
        when = "editorTextFocus && vim.active && vim.use<C-b> && !inDebugRepl && vim.mode != 'Insert'";
      }
      {
        key = "ctrl+w";
        command = "-extension.vim_ctrl+w";
        when = "editorTextFocus && vim.active && vim.use<C-w> && !inDebugRepl";
      }
      {
        key = "ctrl+,";
        command = "-workbench.action.openSettings";
      }
      {
        key = "ctrl+,";
        command = "editor.action.showHover";
        when = "editorTextFocus";
      }
      {
        key = "ctrl+k ctrl+i";
        command = "-editor.action.showHover";
        when = "editorTextFocus";
      }
    ];
    extensions = with inputs.nix-vscode-extensions.extensions.${system}.vscode-marketplace; [
      # Navigation & Themes
      pkief.material-icon-theme
      johnpapa.vscode-peacock
      fabiospampinato.vscode-open-multiple-files
      mkhl.direnv
      eamodio.gitlens
      tonybaloney.vscode-pets
      tomoki1207.pdf
      # Editor
      editorconfig.editorconfig
      vscodevim.vim
      shardulm94.trailing-spaces
      # Nix
      arrterian.nix-env-selector
      bbenoist.nix
      jnoortheen.nix-ide
      # Bash
      mkhl.shfmt
      timonwong.shellcheck
      # Python
      ms-python.python
      ms-python.vscode-pylance
      # Vue.js
      vue.volar
      # Other linters & language support
      davidanson.vscode-markdownlint
      streetsidesoftware.code-spell-checker
      ms-azuretools.vscode-docker
      esphome.esphome-vscode
      eriklynd.json-tools
      wholroyd.jinja
    ];
  };
  xdg.desktopEntries.code = {
    exec = "code %F";
    name = "VS Code";
    icon = "vscode";
    type = "Application";
    categories = [ "Utility" "TextEditor" "Development" "IDE" ];
    mimeType = [ "text/plain" "inode/directory" ];

    actions = {
      "dotfiles" = {
        exec = "code dotfiles";
      };
      "nixpkgs" = {
        exec = "code github/nixpkgs";
      };
    };
  };
}
# cSpell:enable
