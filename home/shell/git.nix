{ pkgs, ... }:
{
  programs = {
    git = {
      enable = true;

      userName = "Juniper";
      userEmail = "48209000+tljuniper@users.noreply.github.com";

      aliases = {
        lol = "log --oneline";
        rofl = "log --oneline";
        unstage = "restore --staged";
        switchMr = "!sh -c 'git fetch $1 merge-requests/$2/head:mr-$1-$2 && git checkout mr-$1-$2' -";
      };
      diff-so-fancy.enable = true;
      ignores = [ ".vscode/" "*.pem" ];
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
  };
}
