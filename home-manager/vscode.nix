{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Needed by Nix IDE extension
    rnix-lsp
  ];
  programs.vscode = {
    enable = true;
    userSettings =
      {
        "brittany.showErrorNotification" = true;
        "brittany.path" = "/nix/store/ffw1gywbywsjskm1midbx8x5acfg6l81-brittany-0.14.0.2/bin/brittany";
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
        "python.formatting.blackPath" = "/nix/store/s9ijw34ckdfj71inlswdc49is7l86iw6-python3.8-black-20.8b1/bin/black";
        "python.formatting.provider" = "black";
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
        name = "brittany";
        publisher = "MaxGabriel";
        version = "0.0.9";
        sha256 = "sha256-04zGi3solPJgzObKJf8/hOa4v7Y7hMyd79rt6hD7y7E=";
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
}
