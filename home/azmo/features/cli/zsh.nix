{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableSyntaxHighlighting = true;
    enableVteIntegration = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    autocd = true;
    #defaultKeymap = "viins"; # handled by zsh-vi-mode
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
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
      ZVM_INIT_MODE="sourcing";
  };

    initExtraFirst = ''
    '';

    initExtra = ''
            # this is kind-of-hacky, but for now it works until a vivid module lands in hm
            export LS_COLORS="$(${pkgs.vivid}/bin/vivid generate catppuccin-macchiato)"
            source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
            ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BEAM
            ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
    '';
  };
}
