{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    userSettings =
      {
        "cabal-fmt.indent" = 4;
        "cmake.configureOnOpen" = false;
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
        "haskell.manageHLS" = "PATH";
        "nix.enableLanguageServer" = true;
        "python.formatting.blackPath" = "/nix/store/s9ijw34ckdfj71inlswdc49is7l86iw6-python3.8-black-20.8b1/bin/black";
        "python.formatting.provider" = "black";
        "workbench.colorTheme" = "Default Dark+";
        "workbench.iconTheme" = "material-icon-theme";
        "[haskell]" = {
          "editor.defaultFormatter" = "MaxGabriel.brittany";
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
      shardulm94.trailing-spaces
      # 2gua.rainbow-brackets
      vscodevim.vim
      pkief.material-icon-theme

      timonwong.shellcheck
      # mkhl.shfmt

      # eriklynd.json-tools
      davidanson.vscode-markdownlint
      ms-azuretools.vscode-docker
      # fabiospampinato.vscode-open-multiple-files

      # # No idea if needed
      # EditorConfig.EditorConfig
      # twxs.cmake
      # ms-vscode.cmake-tools
      # cab404.vscode-direnv
      # mkhl.direnv

      # # Git
      # GitLab.gitlab-workflow
      eamodio.gitlens

      # # Haskell development
      # MaxGabriel.brittany
      haskell.haskell
      justusadam.language-haskell
      # BIGMOON.language-yesod
      # berberman.vscode-cabal-fmt

      # # Nix extensions
      bbenoist.nix
      arrterian.nix-env-selector
      # pinage404.nix-extension-pack
      jnoortheen.nix-ide
      # jamesottaway.nix-develop

      # # Python
      ms-python.vscode-pylance
      ms-python.python

    ];
  };
}
