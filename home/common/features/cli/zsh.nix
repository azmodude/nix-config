{
  pkgs,
  config,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableSyntaxHighlighting = true;
    enableVteIntegration = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    autocd = true;
    dirHashes = {
      docs = config.home.homeDirectory + "/Documents";
      dl = config.home.homeDirectory + "/Downloads";
      vids = config.home.homeDirectory + "/Videos";
      projects = config.home.homeDirectory + "/projects";
    };
    #defaultKeymap = "viins"; # handled by zsh-vi-mode
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "rsync"
        "sudo"
      ];
    };
    prezto = {
      enable = false;
      editor = {
        dotExpansion = true;
        promptContext = true;
      };
      syntaxHighlighting.highlighters = [
        "main"
        "brackets"
        "pattern"
        "line"
        # "cursor" # cursor highlighter breaks zsh-vi-mode cursor styles
        "root"
      ];
      pmodules = [
        "environment"
        "terminal"
        "editor"
        "syntax-highlighting"
        "autosuggestions"
        "history"
        "directory"
        "spectrum"
        "utility"
        "archive"
        "git"
        "docker"
        "rsync"
        "completion"
        # "prompt" # handled by starship
      ];
      utility.safeOps = true;
    };
    zplug = {
      enable = true;
      plugins = [
        {
          name = "hlissner/zsh-autopair";
          tags = [defer:2];
        }
        {name = "zsh-users/zsh-completions";}
        {name = "mdumitru/fancy-ctrl-z";}
      ];
    };
    localVariables = {
      # fire up ZVM initializing directly after sourcing, prevents stomping over other plugins' (like atuin) keybindings
      ZVM_INIT_MODE = "sourcing";
    };

    initExtraFirst = ''
    '';

    initExtra = ''
      # this is kind-of-hacky, but for now it works until a vivid module lands in hm
      export LS_COLORS="$(${pkgs.vivid}/bin/vivid generate catppuccin-macchiato)"
      ZVM_VI_INSERT_ESCAPE_BINDKEY="jk"
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      ZVM_INSERT_MODE_CURSOR="$ZVM_CURSOR_BLINKING_BEAM"
      ZVM_NORMAL_MODE_CURSOR="$ZVM_CURSOR_BLOCK"
    '';

    loginExtra = ''
      # Set SSH_AUTH_SOCK to use 1Password as SSH Agent when not ssh'd in remotely.
      [ -z $SSH_TTY ] && export SSH_AUTH_SOCK=~/.1password/agent.sock
    '';

    shellAliases = {
      man = "${pkgs.bat-extras.batman}/bin/batman";
      cp = "cp -i --reflink=auto --sparse=auto";
      mv = "mv -i";
      rm = "rm -i";
    };
  };
}
