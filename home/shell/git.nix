{ pkgs, ... }:
{
  programs = {
    git = {
      enable = true;

      settings = {

        user.name = "Juniper";
        user.email = "48209000+tljuniper@users.noreply.github.com";

        alias = {
          lol = "log --oneline";
          rofl = "log --oneline";
          unstage = "restore --staged";
          switchMr = "!sh -c 'git fetch $1 merge-requests/$2/head:mr-$1-$2 && git checkout mr-$1-$2' -";
        };

        # extraConfig = {
        # };
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
      ignores = [ ".vscode/" "*.pem" ];
    };

    diff-so-fancy = {
      enable = true;
      enableGitIntegration = true;
    };
  };
}
