{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "Gordon Schulz";
    userEmail = "gordon@gordonschulz.de";
    extraConfig = {
      feature.manyFiles = true;
      init.defaultBranch = "main";
      user.signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICQh4341SBJaXdFAvDtAvS9zs4tiS5v8jod0OhgzBXpV";
      commit.gpgSign = true;
      gpg.program = "${config.programs.gpg.package}/bin/gpg2";
      gpg.format = "ssh";
      gpg.ssh.program = "${pkgs._1password-gui}/share/1password/op-ssh-sign";
      pull.rebase = true;
      fetch.prune = true;
      diff.colorMoved = "dimmed-zebra";
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
