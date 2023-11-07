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
          "css"
          "cabal"
          "git-commit"
          "haskell"
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
      davidanson.vscode-markdownlint
      eamodio.gitlens
      jnoortheen.nix-ide
      editorconfig.editorconfig
      eriklynd.json-tools
      esphome.esphome-vscode
      fabiospampinato.vscode-open-multiple-files
      gitlab.gitlab-workflow
      mkhl.direnv
      ms-azuretools.vscode-docker
      pkief.material-icon-theme
      shardulm94.trailing-spaces
      streetsidesoftware.code-spell-checker
      vscodevim.vim
      # Nix
      arrterian.nix-env-selector
      bbenoist.nix
      jnoortheen.nix-ide
      # Ansible
      wholroyd.jinja
      # Bash
      mkhl.shfmt
      timonwong.shellcheck
      # Python
      ms-python.python
      ms-python.vscode-pylance
      # Haskell
      haskell.haskell
      hoovercj.haskell-linter
      justusadam.language-haskell
      berberman.vscode-cabal-fmt
      bigmoon.language-yesod
    ];
  };
  xdg.desktopEntries.code = {
    exec = "code %F";
    name = "VS Code";
    icon = "code";
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
