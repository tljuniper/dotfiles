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
      ms-azuretools.vscode-docker
      ms-python.python
      ms-python.vscode-pylance
      ms-vscode-remote.remote-ssh
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
        version = "2022.10.0";
        sha256 = "sha256-7vBPKvT62U/FODY0DbuzQAKL0GjFyqUybukoQItnmdo=";
      }
      {
        name = "direnv";
        publisher = "mkhl";
        version = "0.6.1";
        sha256 = "sha256-5/Tqpn/7byl+z2ATflgKV1+rhdqj+XMEZNbGwDmGwLQ=";
      }
      {
        name = "json-tools";
        publisher = "eriklynd";
        version = "1.0.2";
        sha256 = "sha256-7tBjhcqCUnwOXwjhLK8iYtXH/my6ATpWvgrfDNi8tzw=";
      }
      {
        # Is needed by shfmt extension
        name = "EditorConfig";
        publisher = "EditorConfig";
        version = "0.16.4";
        sha256 = "sha256-j+P2oprpH0rzqI0VKt0JbZG19EDE7e7+kAb3MGGCRDk=";
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
        version = "1.1.1";
        sha256 = "sha256-PikNlXJNqIkTbyYv4R45ikAtmLrGVA1RhTulU7rmYnU=";
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
