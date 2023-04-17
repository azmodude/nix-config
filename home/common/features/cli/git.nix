{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    signing = {
      signByDefault = true;
      gpgPath = "${config.programs.gpg.package}/bin/gpg2";
    };
    extraConfig = {
      diff.colorMoved = "dimmed-zebra";
      feature.manyFiles = true;
      fetch.prune = true;
      gpg.format = "ssh";
      gpg.ssh.program = "${pkgs._1password-gui}/share/1password/op-ssh-sign";
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      submodule.recurse = true;
    };
    lfs.enable = true;
    ignores = [".direnv" "result"];
    difftastic = {
      enable = true;
      background = "dark";
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      # catppuccin-macchiato
      gui = {
        icons = true;
        theme = {
          lightTheme = false;
          activeBorderColor = ["#a6da95" "bold"];
          inactiveBorderColor = ["#cad3f5"];
          optionsTextColor = ["#8aadf4"];
          selectedLineBgColor = ["#363a4f" "reverse"];
          selectedRangeBgColor = ["#363a4f" "reverse"];
          cherryPickedCommitBgColor = ["#8bd5ca"];
          cherryPickedCommitFgColor = ["#8aadf4"];
          unstagedChangesColor = ["red"];
        };
      };
    };
  };
  programs.gh = {
    enable = true;
    extensions = with pkgs; [gh-markdown-preview gh-dash];
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
    };
  };
}
