{ pkgs, ... }:

# cSpell:disable
{
  home.packages = with pkgs; [
    # Needed by Nix IDE extension
    rnix-lsp
  ];
  programs.vscode = {
    enable = true;
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
    extensions = with pkgs.vscode-extensions; [
      arrterian.nix-env-selector
      bbenoist.nix
      davidanson.vscode-markdownlint
      eamodio.gitlens
      gitlab.gitlab-workflow
      haskell.haskell
      jnoortheen.nix-ide
      justusadam.language-haskell
      editorconfig.editorconfig
      ms-azuretools.vscode-docker
      ms-python.python
      ms-python.vscode-pylance
      pkief.material-icon-theme
      shardulm94.trailing-spaces
      streetsidesoftware.code-spell-checker
      timonwong.shellcheck
      vscodevim.vim
      wholroyd.jinja
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "haskell-linter";
        publisher = "hoovercj";
        version = "0.0.6";
        sha256 = "sha256-MjgqR547GC0tMnBJDMsiB60hJE9iqhKhzP6GLhcLZzk=";
      }
      {
        name = "esphome-vscode";
        publisher = "ESPHome";
        version = "2023.6.0";
        sha256 = "sha256-/o2eFxxF84dDk8qgkVeA1B6RvAgCSDhulOWHRmjOjng=";
      }
      {
        name = "direnv";
        publisher = "mkhl";
        version = "0.14.0";
        sha256 = "sha256-T+bt6ku+zkqzP1gXNLcpjtFAevDRiSKnZaE7sM4pUOs=";
      }
      {
        name = "json-tools";
        publisher = "eriklynd";
        version = "1.0.2";
        sha256 = "sha256-7tBjhcqCUnwOXwjhLK8iYtXH/my6ATpWvgrfDNi8tzw=";
      }
      {
        name = "language-yesod";
        publisher = "BIGMOON";
        version = "0.9.0";
        sha256 = "sha256-77tsTExt+rstjwQGkHIYRckX7KkjiBViMGaWmgRn4+4=";
      }
      {
        name = "shfmt";
        publisher = "mkhl";
        version = "1.2.0";
        sha256 = "sha256-jgKJz6FQt6jBsiDQCKYnEuWhHg+9zD0P+GOMYTt1ZZA=";
      }
      {
        name = "vscode-cabal-fmt";
        publisher = "berberman";
        version = "0.0.3";
        sha256 = "sha256-TY1fxdhjktsdRDqWAioUKSBd8I0ztroPIeC4Cv+NzE0=";
      }
      {
        name = "vscode-open-multiple-files";
        publisher = "fabiospampinato";
        version = "1.4.0";
        sha256 = "sha256-gTBOH1w4i02ezPaNq1tPI9BXbSBuBOvWTn4RKBvMV0o=";
      }
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
